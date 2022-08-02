library(base64enc)
library(tidyverse)
library(data.table)
library(readr)
library(utf8)
library(dtplyr)
library(stringr)

#單一欄位解碼 function
decode64 =  function(value) {
  decoded_value = value %>% 
    map(base64decode) %>%
    map_chr(rawToChar) %>%
    map_chr(str_conv, "UTF-8")
  return(decoded_value)
}

#投射到所有欄位 function
deloop = function(df) {
  decoded_df = df %>% 
    setDT() %>% 
    mutate_at(vars(-contains("出生日期")), decode64) %>% 
    as.data.frame()
  return(decoded_df)
}

#Base64 解碼 loop
setwd("C:/Users/chihyu.tsou/Desktop/學習歷程(1081_1091)_給國教院")
files_to_decode <- list.files()
fs::dir_create("C:/Users/chihyu.tsou/Desktop/EP_v1.0.0/data-raw")
print(files_to_decode)

for (i in files_to_decode) {
  if (str_detect(i, "學生資料名冊_學生資料")) {
    # 讀取學生資料名冊_學生資料，讀取學生資料名冊_學生資料，
    #因為出生日期一欄沒有轉碼，需特別處理
    ep <- fread(i, na.strings = "", encoding = "UTF-8", colClasses = "character", header = FALSE) #讀csv檔
    colnm = iconv(as.character(ep[1,]), to = "UTF-8")
    names(ep) <- colnm
    ep <- ep[-1, ]
  }
  else {
    ep <- fread(i, na.strings = "", encoding = "UTF-8", colClasses = "character", header = TRUE) #讀csv檔
  }
  ep <- sjmisc::replace_na(ep, value = "") #把 na 換成 nothing，不然解碼時會讓空白處出現數字4
  print("successfully replace na")
  ep <- deloop(ep)
  print("successfully decode")
  name <- paste0("C:/Users/chihyu.tsou/Desktop", "/EP_v1.0.0/data-raw", "/", "/", i) #路徑檔名
  fwrite(ep, file = name)
  print(paste0(i," ","sucessfully saved"))
}