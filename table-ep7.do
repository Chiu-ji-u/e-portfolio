//108_1_學生成績名冊_轉學轉科成績
import delimited "data-raw\108_1_學生成績名冊_轉學轉科成績.csv", bindquote(strict) stringcols(_all) clear

rename sch_year upl_ayr_ep7
rename semester upl_sem_ep7
rename book bk_nb_ep7
rename book_nm bk_ep7
rename sheet_nm sht_ep7
rename sch_cd sch_cd_ep7
rename sch_nm sch_ep7
rename 身分證號 id_nat_ep7

rename 對應學年度 cor_ayr_ep7
rename 對應學期 cor_sem_ep7
rename 課程代碼 crs_cd_ep7
rename 科目名稱 crs_ep7
rename 對應年級 cor_gr_ep7
rename 修課學分 cr_ep7
rename 身分別 trftyp_ep7
rename 抵免後成績 wv_sc_ep7
rename 成績及格 ps_ep7
rename 是否採計學分 sc_ct_ep7
rename 質性文字描述 desc_ep7

/*改上傳學年度為西元年，並查看分布狀況*/
changeAD upl_ayr_ep7

/*合併學校代碼與學校名稱為學校名稱*/
replace sch_ep7 = sch_cd_ep7 + "_" + sch_ep7
drop sch_cd_ep7

tab sch_ep7
drop if sch_ep7 == "000000_測試高中" | sch_ep7 == "000001_國教署"

tab sch_ep7 if ustrregexm(sch_ep7, "進修部") == 1 
//10 obs 進修部

/*改對應學年度為西元年，並查看分布狀況*/
changeAD cor_ayr_ep7

/*檢查對應學期與對應年級*/
tab cor_sem_ep7, missing
tab cor_gr_ep7, missing

/*身分別、抵免後分數與分數及格*/
tab trftyp_ep7, missing
tab wv_sc_ep7, missing
tab wv_sc_ep7 trftyp_ep7, missing //無校外抵免修

changeBV ps_ep7
tab wv_sc_ep7 ps_ep7, missing

/*分數是否列入計算*/
tab sc_ct_ep7, missing

/*文字描述前後加上 " " */
protect desc_ep7

save "data\dta\ep7_1081", replace
export delimited using "data\ep7_1081.csv", replace

//108_2_學生成績名冊_轉學轉科成績
import delimited "data-raw\108_2_學生成績名冊_轉學轉科成績.csv", bindquote(strict) stringcols(_all) clear

rename sch_year upl_ayr_ep7
rename semester upl_sem_ep7
rename book bk_nb_ep7
rename book_nm bk_ep7
rename sheet_nm sht_ep7
rename sch_cd sch_cd_ep7
rename sch_nm sch_ep7
rename 身分證號 id_nat_ep7

rename 對應學年度 cor_ayr_ep7
rename 對應學期 cor_sem_ep7
rename 課程代碼 crs_cd_ep7
rename 科目名稱 crs_ep7
rename 對應年級 cor_gr_ep7
rename 修課學分 cr_ep7
rename 身分別 trftyp_ep7
rename 抵免後成績 wv_sc_ep7
rename 成績及格 ps_ep7
rename 是否採計學分 sc_ct_ep7
rename 質性文字描述 desc_ep7

/*改上傳學年度為西元年，並查看分布狀況*/
changeAD upl_ayr_ep7

/*合併學校代碼與學校名稱為學校名稱*/
replace sch_ep7 = sch_cd_ep7 + "_" + sch_ep7
drop sch_cd_ep7

tab sch_ep7
drop if sch_ep7 == "000000_測試高中" | sch_ep7 == "000001_國教署" | sch_ep7 == "000005_資科司"
tab sch_ep7 if ustrregexm(sch_ep7, "進修部") == 1 
//374 obs 進修部

/*改對應學年度為西元年，並查看分布狀況*/
changeAD cor_ayr_ep7

/*檢查對應學期與對應年級*/
tab cor_sem_ep7, missing
tab cor_gr_ep7, missing

/*身分別、抵免後分數與分數及格*/
tab trftyp_ep7, missing
destring wv_sc_ep7, replace
tab wv_sc_ep7 trftyp_ep7, missing //無校外抵免修

changeBV ps_ep7
tab wv_sc_ep7 ps_ep7, missing //38 obs 沒有抵免後成績但過了，13 obs 0 分也過了
tostring wv_sc_ep7, replace

/*分數是否列入計算*/
tab sc_ct_ep7, missing 
tab sc_ct_ep7 trftyp_ep7, missing //239 obs sc_ct_ep7 = 3 但無人 trftyp_ep7 = 5, 6, 7 

/*文字描述前後加上 " " */
protect desc_ep7

save "data\dta\ep7_1082", replace
export delimited using "data\ep7_1082.csv", replace

//109_1_學生成績名冊_轉學轉科成績
import delimited "data-raw\109_1_學生成績名冊_轉學轉科成績.csv", bindquote(strict) stringcols(_all) clear

rename sch_year upl_ayr_ep7
rename semester upl_sem_ep7
rename book bk_nb_ep7
rename book_nm bk_ep7
rename sheet_nm sht_ep7
rename sch_cd sch_cd_ep7
rename sch_nm sch_ep7
rename 身分證號 id_nat_ep7

rename 對應學年度 cor_ayr_ep7
rename 對應學期 cor_sem_ep7
rename 課程代碼 crs_cd_ep7
rename 科目名稱 crs_ep7
rename 對應年級 cor_gr_ep7
rename 修課學分 cr_ep7
rename 身分別 trftyp_ep7
rename 抵免後成績 wv_sc_ep7
rename 成績及格 ps_ep7
rename 是否採計學分 sc_ct_ep7
rename 質性文字描述 desc_ep7

/*改上傳學年度為西元年，並查看分布狀況*/
changeAD upl_ayr_ep7

/*合併學校代碼與學校名稱為學校名稱*/
replace sch_ep7 = sch_cd_ep7 + "_" + sch_ep7
drop sch_cd_ep7
tab sch_ep7
tab sch_ep7 if ustrregexm(sch_ep7, "進修部") == 1 
//792 obs 進修部

/*改對應學年度為西元年，並查看分布狀況*/
changeAD cor_ayr_ep7

/*檢查對應學期與對應年級*/
tab cor_sem_ep7, missing
tab cor_gr_ep7, missing

/*身分別、抵免後分數與分數及格*/
tab trftyp_ep7, missing
destring wv_sc_ep7, replace
tab wv_sc_ep7 trftyp_ep7, missing //無校外抵免修

changeBV ps_ep7
tab wv_sc_ep7 ps_ep7, missing //3 obs 沒有抵免後成績但過了，23 obs 0 分也過了
tostring wv_sc_ep7, replace

/*分數是否列入計算*/
tab sc_ct_ep7, missing 
tab sc_ct_ep7 trftyp_ep7, missing //149 obs sc_ct_ep7 = 3 但無人 trftyp_ep7 = 5, 6, 7

/*文字描述前後加上 " " */
protect desc_ep7

save "data\dta\ep7_1091", replace
export delimited using "data\ep7_1091.csv", replace