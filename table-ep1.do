//108_1_學生資料名冊_學生資料_de
import delimited "data-raw\108_1_學生資料名冊_學生資料_de.csv", bindquote(strict) encoding(UTF-8) stringcols(_all) clear

rename sch_year upl_ayr_ep1
rename semester upl_sem_ep1
rename book bk_nb_ep1
rename book_nm bk_ep1
rename sheet_nm sht_ep1
rename sch_cd sch_cd_ep1
rename sch_nm sch_ep1
rename 身分證號 id_nat_ep1

rename 性別代碼 sex_ep1
rename 群別代碼 grp
rename 科班學程別代碼 dep
rename 部別代碼 schtyp_ep1
rename 班別 clstyp_ep1
rename 年級 gr_ep1
rename 班級名稱 cls_ep1
rename 座號 nb_ep1
rename 特殊身分別 sttyp
rename 原住民族別 idg_ep1
rename 原住民身分別 idgloc_ep1
rename 族語認證報考方言 idglg_ep1
rename 報考年度 tstyr_ep1
rename 族語認證有效日期 idglg_expymd_ep1
rename 實驗班名稱 expcls_ep1
rename 入學方式 admchan_ep1
rename 學籍狀態 sts_ep1
rename 學籍異動日期 sts_chgymd_ep1
rename 出生日期 bymd_ep1

order bymd_ep1, after(sex_ep1)

/*改上傳學年度為西元年，並查看分布狀況*/
changeAD upl_ayr_ep1

/*合併學校代碼與學校名稱為學校名稱*/
replace sch_ep1 = sch_cd_ep1 + "_" + sch_ep1
drop sch_cd_ep1

tab sch_ep1, missing
drop if sch_ep1 == "000000_測試高中" | sch_ep1 == "000001_國教署" | sch_ep1 == "000B00_測試學校(進修部)" | sch_ep1 == "000005_資科司"

/*性別重新編碼*/
changeBV sex_ep1

save "data\dta\ep1_1081", replace

/*學群代碼加上中文解釋後綴*/
do "program\code_type.do" //產生學群、科/班/學程別、特殊身分別代碼

use "data\dta\ep1_1081", replace

/*合併學群代碼的中文解釋*/
merge m:1 grp using "program\grp_cd.dta" 
drop if _merge ==  2  //去除沒有對應到的學群
sort _merge real_grp
tab real_grp, missing //172 obs 沒有學群
tab sch_ep1 if _merge == 1, missing 
drop grp _merge
order real_grp, before(dep) //換上新值
rename real_grp grp_ep1

save "data\dta\ep1_1081", replace

/*科/班/學程別代碼加上中文解釋後綴*/
use "data\dta\ep1_1081", replace

merge m:1 dep using "program\dep_cd.dta"
drop if _merge ==  2  //去除沒有對應到的科/班/學程別
sort _merge real_dep 
tab real_dep, missing //2686 obs 沒有科/班/學程別
tab sch_ep1 if _merge == 1, missing
drop dep _merge
order real_dep, after(grp_ep1) //換上新值
rename real_dep dep_ep1

/*部別代碼*/
destring schtyp_ep1, replace
tab schtyp_ep1, missing //介於1~7, normal
tostring schtyp_ep1, replace

/*班別加上中文解釋後綴，若為進修部，再加上前綴 C*/
replace clstyp_ep1 = clstyp_ep1 + "_日間部(一般班)" if clstyp_ep1 == "1"
replace clstyp_ep1 = clstyp_ep1 + "_夜間部(一般班)" if clstyp_ep1 == "2"
replace clstyp_ep1 = clstyp_ep1 + "_實用技能學程(一般班)" if clstyp_ep1 == "3"
replace clstyp_ep1 = clstyp_ep1 + "_建教班" if clstyp_ep1 == "4"
replace clstyp_ep1 = clstyp_ep1 + "_產學訓合作計畫班(產學合作班)" if clstyp_ep1 == "6"
replace clstyp_ep1 = clstyp_ep1 + "_雙軌訓練旗艦計畫班(臺德菁英班)" if clstyp_ep1 == "7"
replace clstyp_ep1 = clstyp_ep1 + "_建教僑生專班" if clstyp_ep1 == "8"
replace clstyp_ep1 = clstyp_ep1 + "_實驗班" if clstyp_ep1 == "9"
replace clstyp_ep1 = "C" + clstyp_ep1 + "_進修部(核定班)" if clstyp_ep1 == "01"
replace clstyp_ep1 = "C" + clstyp_ep1 + "_進修部(員工進修班)" if clstyp_ep1 == "04"
replace clstyp_ep1 = "C" + clstyp_ep1 + "_非班混齡" if clstyp_ep1 == "n"
replace clstyp_ep1 = "C" + clstyp_ep1 + "_班混齡" if clstyp_ep1 == "y"

tab clstyp_ep1, missing //無空值, normal

/*年級*/
tab gr_ep1, missing //4 obs 年級為 6
list if gr_ep1 == "6" //060322_國立興大附中 

/*去除座號*/
drop nb_ep1

/*保留特殊身分別，並改名為(原單位)特殊身份別*/
gen sttyp_raw_ep1 = sttyp
protect sttyp_raw_ep1

/*分拆特殊身分別，並加上中文解釋後綴，一般生為0_一般生*/
tab sttyp

//確保 sttyp1 < sttyp2 < ... < sttypn
replace sttyp = "" if sttyp == ","
replace sttyp = "1" if sttyp == ",1" | sttyp == "1," | sttyp == "1,1"
replace sttyp = "1,4" if sttyp == "4,1" 
replace sttyp = "1,4,24" if sttyp == "4,1,24" 
replace sttyp = "1,10" if sttyp == "10,1" 
replace sttyp = "1,11" if sttyp == "11,1" 
replace sttyp = "1,24" if sttyp == "24,1" 
replace sttyp = "11,24" if sttyp == "24,11"
replace sttyp = "11,27" if sttyp == "27,11"
replace sttyp = "4" if sttyp == "4," 
replace sttyp = "4,24" if sttyp == "24,4" 
replace sttyp = "4,24,27" if sttyp == "24,27,4" 

tab sttyp, missing

split sttyp, parse(,) //查看分拆情況
sort sttyp_raw_ep1

tab sttyp1, missing
replace sttyp1 = "" if sttyp1 == "0" //將一般生代碼統一

tab sttyp2, missing
tab sttyp3, missing

tab sttyp1 sttyp2, missing
tab sttyp2 sttyp3, missing
tab sttyp3 sttyp1, missing //確保沒有重複

merge m:1 sttyp1 using "program\sttyp_cd.dta"
drop if _merge == 2
drop sttyp1 _merge
rename real_sttyp sttyp1_ep1

tab sttyp1_ep1, missing

merge m:1 sttyp2 using "program\sttyp_cd.dta"
drop if _merge == 2 
drop sttyp2 _merge 
rename real_sttyp sttyp2_ep1

tab sttyp2_ep1, missing

merge m:1 sttyp3 using "program\sttyp_cd.dta"
drop if _merge == 2 
drop sttyp3 _merge 
rename real_sttyp sttyp3_ep1

tab sttyp3_ep1, missing

forvalues i = 2/3 {
	replace sttyp`i'_ep1 = "" if sttyp`i'_ep1 == "0_一般生" 
} //如果僅有1種身分別，第2、3種身分別欄應為空白

drop sttyp sttyp1 sttyp2
order sttyp1_ep1 sttyp2_ep1 sttyp3_ep1 sttyp_raw_ep1, before(idg_ep1)

/*原住民族別*/
tab idg_ep1, missing
tab idg_ep1
replace idg_ep1 = "" if idg_ep1 == "無" //統一非原住民標註格式

count if idg_ep1 == "" & (sttyp1_ep1 == "1_原住民生") 
//155 obs 有原住民特殊身分，但無填報原住民族別

count if idg_ep1 != "" & (sttyp1_ep1 != "1_原住民生")

tab idg_ep1 if sttyp1_ep1 != "1_原住民生"
//2050 obs 有填報原住民族別，但無原住民特殊身分
//原住民認定應以特殊身分別，還是原民會借接資料為主？

/*原住民身分別*/
tab idgloc_ep1, missing
tab idgloc_ep1

count if sttyp1_ep1 == "1_原住民生" //8522 obs 
tab idg_ep1 //10417 obs
tab idgloc_ep1 //10428 obs
//具原住民特殊身分、有填報原住民族別和有原住民身分別者，三者數目不一致

tab idg_ep1 idgloc_ep1, missing
//31 obs 無填報原住民族別，卻有山原身分
//34 obs 無填報原住民族別，卻有平原身分

tab idgloc_ep1 if sttyp1_ep1 == "1_原住民生", missing
//118 obs 有原住民特殊身分，但無填報原住民身分別

tab idgloc_ep1 if sttyp1_ep1 != "1_原住民生"
//2024 obs 無原住民特殊身分，卻填了原住民身分別

/*報考語言*/
tab idglg_ep1 if sttyp1_ep1 != "1_原住民生"
//1183 obs 不具有原住民特殊身分，卻報考原住民語 (just normal as taking a foreign language test)

tab idglg_ep1 if sttyp1_ep1 != "1_原住民生" & idg_ep1 != ""
//1166 obs 不具有原住民特殊身分，卻報考原住民語，填報原住民族別

tab idglg_ep1 if sttyp1_ep1 == "1_原住民生", missing
//2656 obs 有原住民特殊身分，但沒有報考原住民語

/*改報考年度為西元年*/
tab tstyr_ep1, missing //482 obs 填0

tab sch_ep1 if tstyr_ep1 == "0" 
//報考年度為0者為市立啟聰學校、市立啟明學校、臺商子女學校，皆為特殊學校
//於是將無報考年度者統一

replace tstyr_ep1 = "" if tstyr_ep1 == "0"

changeAD tstyr_ep1

tab tstyr_ep1
tab tstyr_ep1 if idglg_ep1 != ""
tab tstyr_ep1 if idglg_ep1 == "", missing 
//語言別與報考年度一致

/*族語認證有效日期*/
sort tstyr_ep1 idglg_expymd_ep1
tab tstyr_ep1 idglg_expymd_ep1, missing
tab tstyr_ep1 idglg_expymd_ep1 if tstyr_ep1 != "", missing

replace idglg_expymd_ep1 = "999" if idglg_expymd_ep1 == "" & tstyr_ep1 != "" //將有報考年度，但有效日期未填報者給予新值999

replace idglg_expymd_ep1 = ustrregexrf(idglg_expymd_ep1, "103", "2014")
replace idglg_expymd_ep1 = ustrregexrf(idglg_expymd_ep1, "104", "2015")
replace idglg_expymd_ep1 = ustrregexrf(idglg_expymd_ep1, "105", "2016")
replace idglg_expymd_ep1 = ustrregexrf(idglg_expymd_ep1, "106", "2017") //將民國年改成西元年

tab tstyr_ep1 idglg_expymd_ep1, missing

/*實驗班名稱*/
tab expcls_ep1, missing
tab expcls_ep1 clstyp_ep1, missing

//沒有 obs 有實驗班名稱，但無實驗班註記
//367 obs 就讀實驗班，但未註記名稱

/*入學方式*/
tab admchan_ep1, missing
replace admchan_ep1 = "" if admchan_ep1 == "無註記"
replace admchan_ep1 = "免試入學—就學區免試入學" if admchan_ep1 == ""
replace admchan_ep1 = "免試入學—就學區免試入學" if admchan_ep1 == "分區免試"
replace admchan_ep1 = "免試入學—就學區免試入學—免試入學續招" if admchan_ep1 == "免試續招"

replace admchan_ep1 = "免試入學—優先免試入學" if admchan_ep1 == "優先免試入學"
replace admchan_ep1 = "免試入學—試辦學習區完全免試入學" if admchan_ep1 == "學習區完全免試入學" | admchan_ep1 == "試辦學習區完全免試入學" 
replace admchan_ep1 = "免試入學—直升入學" if admchan_ep1 == "直升入學" | admchan_ep1 == "直升"
replace admchan_ep1 = "免試入學—技優甄審入學" if admchan_ep1 == "技優甄審"
replace admchan_ep1 = "免試入學—其他免試入學—園區生免試入學、實驗教育" if admchan_ep1 == "園區生獨招、實驗教育"
replace admchan_ep1 = "免試入學—其他免試入學—宜蘭區專長生" if admchan_ep1 == "宜蘭區專長生"
replace admchan_ep1 = "免試入學—其他免試入學—基北區產業特殊需求類科" if admchan_ep1 == "基北區產特"
replace admchan_ep1 = "免試入學—其他免試入學—屏東區離島生" if admchan_ep1 == "屏東區離島生" | admchan_ep1 == "離島生"

replace admchan_ep1 = "免試入學—其他免試入學—原住民藝能班" if admchan_ep1 == "原住民藝能班"
replace admchan_ep1 = "免試入學—其他免試入學—原住民藝能班、原住民教育實驗專班" if admchan_ep1 == "原住民藝能班、實驗班"

replace admchan_ep1 = "免試入學—其他免試入學—技術型及單科型單獨辦理免試招生" if admchan_ep1 == "技術型及單科型"
replace admchan_ep1 = "免試入學—其他免試入學—進修學校非應屆獨招" if admchan_ep1 == "進修學校非應屆獨招" | admchan_ep1 == "進修部非應屆獨招" | admchan_ep1 == "進校(部)非應屆獨招"

replace admchan_ep1 = "特色招生—科學班甄選入學" if admchan_ep1 == "甄選入學(科學班)"
replace admchan_ep1 = "特色招生—藝才班甄選入學" if admchan_ep1 == "甄選入學(藝才班-甄選入學)" | admchan_ep1 == "甄選入學(藝才班-競賽表現)"
replace admchan_ep1 = "特色招生—體育班甄選入學" if admchan_ep1 == "甄選入學(體育班)"

replace admchan_ep1 = "未受補助私校單獨招生" if admchan_ep1 == "未受補助私校"

replace admchan_ep1 = "其他—實用技能學程" if admchan_ep1 == "實用技能學程" | admchan_ep1 == "實用技能班"
replace admchan_ep1 = "其他—建教合作班" if admchan_ep1 == "建教班"
replace admchan_ep1 = "其他—身心障礙適性輔導就學安置" if admchan_ep1 == "身障適性輔導就學安置"

replace admchan_ep1 = "其他—臺商子弟專案" if admchan_ep1 == "臺商子弟專案"

//不確定如何分類
tab sch_ep1 clstyp_ep1 if admchan_ep1 == "甄試入學"
//73 obs all from 801M01_私立東莞台商子弟學校 & 1_日間部(一般班)
list if admchan_ep1 == "聯招生" //1 obs  801M02_私立華東臺商子女學校  
list if admchan_ep1 == "復學" //1 obs  801M01_私立東莞台商子弟學校 
tab sch_ep1 clstyp_ep1 if admchan_ep1 == "免試入學" // 68  obs 801M01_私立東莞台商子弟學校 

/*學籍狀態*/
tab sts_ep1, missing

/*學籍異動日期*/
//將學籍異動日期刪去上（下）午和時分秒
split sts_chgymd_ep1, parse(" ")
drop sts_chgymd_ep1 sts_chgymd_ep12 sts_chgymd_ep13
rename sts_chgymd_ep11 sts_chgymd_ep1
order sts_chgymd_ep1, before(de_stuid)

tab sts_chgymd_ep1 sts_ep1, missing
tab sts_chgymd_ep1 sts_ep1
//8555 obs 在學且有學籍異動日期

save "data\dta\ep1_1081", replace
export delimited using "data\ep1_1081.csv", replace

//id 重複
duplicates tag id_nat_ep1, gen(id_nat_rep_ep1)
tab id_nat_rep_ep1 //635 obs 重複 id 
keep if id_nat_rep_ep1 > 0

gen sts_chgymd_date_ep1 = date(sts_chgymd_ep1, "YMD")
sort id_nat_rep_ep1 id_nat_ep1 sts_chgymd_date_ep1 //按照學籍變更日期排列
drop sts_chgymd_date_ep1

duplicates tag id_nat_ep1 sch_ep1, gen(idsch_rep_ep1)
tab idsch_rep_ep1 //沒有 obs 重複 id 和學校

duplicates tag id_nat_ep1 sts_ep1, gen(idsts_rep_ep1)
tab idsts_rep_ep1 //316 obs 重複 id 和學籍狀態
list if idsts_rep_ep1 == 1

duplicates tag id_nat_ep1 sch_ep1 sts_ep1, gen(idschsts_rep_ep1)
tab idschsts_rep_ep1 //沒有 obs 重複 id、學校和學籍狀態

drop id_nat_rep_ep1 idsch_rep_ep1 idsts_rep_ep1 idschsts_rep_ep1
//----------------------------------------------------------

//108_2_學生資料名冊_學生資料_de
import delimited "data-raw\108_2_學生資料名冊_學生資料_de.csv", bindquote(strict) encoding(UTF-8) stringcols(_all) clear

rename sch_year upl_ayr_ep1
rename semester upl_sem_ep1
rename book bk_nb_ep1
rename book_nm bk_ep1
rename sheet_nm sht_ep1
rename sch_cd sch_cd_ep1
rename sch_nm sch_ep1
rename 身分證號 id_nat_ep1

rename 性別代碼 sex_ep1
rename 群別代碼 grp
rename 科班學程別代碼 dep
rename 部別代碼 schtyp_ep1
rename 班別 clstyp_ep1
rename 年級 gr_ep1
rename 班級名稱 cls_ep1
rename 座號 nb_ep1
rename 特殊身分別 sttyp
rename 原住民族別 idg_ep1
rename 原住民身分別 idgloc_ep1
rename 族語認證報考方言 idglg_ep1
rename 報考年度 tstyr_ep1
rename 族語認證有效日期 idglg_expymd_ep1
rename 實驗班名稱 expcls_ep1
rename 入學方式 admchan_ep1
rename 學籍狀態 sts_ep1
rename 學籍異動日期 sts_chgymd_ep1
rename 出生日期 bymd_ep1

order bymd_ep1, after(sex_ep1)

/*改上傳學年度為西元年，並查看分布狀況*/
changeAD upl_ayr_ep1

/*合併學校代碼與學校名稱為學校名稱*/
replace sch_ep1 = sch_cd_ep1 + "_" + sch_ep1
drop sch_cd_ep1

tab sch_ep1, missing
drop if sch_ep1 == "000000_測試高中" | sch_ep1 == "000001_國教署" | sch_ep1 == "000B00_測試學校(進修部)" | sch_ep1 == "000005_資科司"

/*性別重新編碼*/
changeBV sex_ep1

save "data\dta\ep1_1081", replace

/*學群代碼加上中文解釋後綴*/
do "program\code_type.do" //產生學群、科/班/學程別、特殊身分別代碼

use "data\dta\ep1_1081", replace

/*合併學群代碼的中文解釋*/
merge m:1 grp using "program\grp_cd.dta" 
drop if _merge ==  2  //去除沒有對應到的學群
sort _merge real_grp
tab real_grp, missing //32 obs 沒有學群
tab sch_ep1 if _merge == 1, missing 
drop grp _merge
order real_grp, before(dep) //換上新值
rename real_grp grp_ep1

save "data\dta\ep1_1081", replace

/*科/班/學程別代碼加上中文解釋後綴*/
use "data\dta\ep1_1081", replace

merge m:1 dep using "program\dep_cd.dta"
drop if _merge ==  2  //去除沒有對應到的科/班/學程別
sort _merge real_dep 
tab real_dep, missing //250 obs 沒有科/班/學程別
tab sch_ep1 if _merge == 1, missing
drop dep _merge
order real_dep, after(grp_ep1) //換上新值
rename real_dep dep_ep1

/*部別代碼*/
destring schtyp_ep1, replace
tab schtyp_ep1, missing //介於1~7, normal
tostring schtyp_ep1, replace

/*班別加上中文解釋後綴，若為進修部，再加上前綴 C*/
replace clstyp_ep1 = clstyp_ep1 + "_日間部(一般班)" if clstyp_ep1 == "1"
replace clstyp_ep1 = clstyp_ep1 + "_夜間部(一般班)" if clstyp_ep1 == "2"
replace clstyp_ep1 = clstyp_ep1 + "_實用技能學程(一般班)" if clstyp_ep1 == "3"
replace clstyp_ep1 = clstyp_ep1 + "_建教班" if clstyp_ep1 == "4"
replace clstyp_ep1 = clstyp_ep1 + "_產學訓合作計畫班(產學合作班)" if clstyp_ep1 == "6"
replace clstyp_ep1 = clstyp_ep1 + "_雙軌訓練旗艦計畫班(臺德菁英班)" if clstyp_ep1 == "7"
replace clstyp_ep1 = clstyp_ep1 + "_建教僑生專班" if clstyp_ep1 == "8"
replace clstyp_ep1 = clstyp_ep1 + "_實驗班" if clstyp_ep1 == "9"
replace clstyp_ep1 = "C" + clstyp_ep1 + "_進修部(核定班)" if clstyp_ep1 == "01"
replace clstyp_ep1 = "C" + clstyp_ep1 + "_進修部(員工進修班)" if clstyp_ep1 == "04"
replace clstyp_ep1 = "C" + clstyp_ep1 + "_非班混齡" if clstyp_ep1 == "n"
replace clstyp_ep1 = "C" + clstyp_ep1 + "_班混齡" if clstyp_ep1 == "y"

tab clstyp_ep1, missing //無空值, normal

/*年級*/
tab gr_ep1, missing

/*去除座號*/
drop nb_ep1

/*保留特殊身分別，並改名為(原單位)特殊身份別*/
gen sttyp_raw_ep1 = sttyp
tab sttyp_raw_ep1, missing //normal
protect sttyp_raw_ep1

/*分拆特殊身分別，並加上中文解釋後綴，一般生為0_一般生*/
tab sttyp

//確保 sttyp1 < sttyp2 < ... < sttypn
replace sttyp = "1" if sttyp == ",1" | sttyp == "1,1"
replace sttyp = "1,4" if sttyp == "4,1"
replace sttyp = "1,4,24" if sttyp == "24,1,4"
replace sttyp = "1,10" if sttyp == "10,1"
replace sttyp = "1,11" if sttyp == "11,1"
replace sttyp = "1,24" if sttyp == "24,1"
replace sttyp = "4,24" if sttyp == "24,4"
replace sttyp = "4,24,27" if sttyp == "24,27,4"
replace sttyp = "24" if sttyp == ",24"

tab sttyp

split sttyp, parse(,) //查看分拆情況
sort sttyp_raw_ep1

replace sttyp1 = sttyp2 if sttyp1 == "" & sttyp2 != ""
replace sttyp2 = "" if sttyp1 == sttyp2

tab sttyp1, missing
replace sttyp1 = "" if sttyp1 == "0" //將一般生代碼統一

tab sttyp2, missing
tab sttyp3, missing

tab sttyp1 sttyp2, missing
tab sttyp2 sttyp3, missing
tab sttyp3 sttyp1, missing //確保沒有重複

merge m:1 sttyp1 using "program\sttyp_cd.dta"
drop if _merge == 2
drop sttyp1 _merge
rename real_sttyp sttyp1_ep1

tab sttyp1_ep1, missing

merge m:1 sttyp2 using "program\sttyp_cd.dta"
drop if _merge == 2 
drop sttyp2 _merge 
rename real_sttyp sttyp2_ep1

tab sttyp2_ep1, missing

merge m:1 sttyp3 using "program\sttyp_cd.dta"
drop if _merge == 2 
drop sttyp3 _merge 
rename real_sttyp sttyp3_ep1

tab sttyp3_ep1, missing

forvalues i = 2/3 {
	replace sttyp`i'_ep1 = "" if sttyp`i'_ep1 == "0_一般生" 
} //如果僅有1種身分別，第2、3種身分別欄位應為空值

drop sttyp sttyp1 sttyp2
order sttyp1_ep1 sttyp2_ep1 sttyp3_ep1 sttyp_raw_ep1, before(idg_ep1)

/*原住民族別*/
tab idg_ep1, missing
tab idg_ep1
replace idg_ep1 = "" if idg_ep1 == "無" //統一非原住民標註格式

count if idg_ep1 == "" & sttyp1_ep1 == "1_原住民生"
//82 obs 有原住民特殊身分，但無填報原住民族別

count if idg_ep1 != "" & sttyp1_ep1 != "1_原住民生"

tab idg_ep1 if sttyp1_ep1 != "1_原住民生"
//1486 obs 有填報原住民族別，但無原住民特殊身分
//原住民認定應以特殊身分別，還是原民會借接資料為主？

/*原住民身分別*/
tab idgloc_ep1, missing
tab idgloc_ep1

count if sttyp1_ep1 == "1_原住民生" //6376 obs 
tab idg_ep1 //7780 obs
tab idgloc_ep1 //7782 obs
//具有原住民特殊身分者、有填報原住民族別和有原住民身分別者，三者數目不一致

tab idg_ep1 idgloc_ep1, missing
//18 obs 無填報原住民族別，卻有山原身分
//24 obs 無填報原住民族別，卻有平原身分

tab idgloc_ep1 if sttyp1_ep1 == "1_原住民生", missing
//65 obs 有原住民特殊身分，但無填報原住民身分別

tab idgloc_ep1 if sttyp1_ep1 != "1_原住民生"
//1471 obs 無原住民特殊身分，卻填了原住民身分別

/*報考語言*/
tab idglg_ep1 if sttyp1_ep1 != "1_原住民生"
//845 obs 不具有原住民特殊身分，卻報考原住民語 (just normal as taking a foreign language test)

tab idglg_ep1 if sttyp1_ep1 != "1_原住民生" & idg_ep1 != ""
//832 obs 不具有原住民特殊身分，卻報考原住民語，填報原住民族別

tab idglg_ep1 if sttyp1_ep1 == "1_原住民生" , missing
//6376 obs 有原住民特殊身分，但沒有報考原住民語

/*改報考年度為西元年*/
tab tstyr_ep1, missing //525 obs 填0

tab sch_ep1 if tstyr_ep1 == "0" 
//報考年度為0者為市立啟聰學校、市立啟明學校、臺商子女學校，皆為特殊學校
//於是將無報考年度者統一

replace tstyr_ep1 = "" if tstyr_ep1 == "0"

changeAD tstyr_ep1

tab tstyr_ep1
tab tstyr_ep1 if idglg_ep1 != ""
tab tstyr_ep1 if idglg_ep1 == "", missing 
//語言別與報考年度一致

/*族語認證有效日期*/
sort tstyr_ep1 idglg_expymd_ep1
tab tstyr_ep1 idglg_expymd_ep1, missing
tab tstyr_ep1 idglg_expymd_ep1 if tstyr_ep1 != "", missing

replace idglg_expymd_ep1 = "999" if idglg_expymd_ep1 == "" & tstyr_ep1 != "" //將有報考年度，但有效日期未填報者給予新值999

replace idglg_expymd_ep1 = ustrregexrf(idglg_expymd_ep1, "103", "2014")
replace idglg_expymd_ep1 = ustrregexrf(idglg_expymd_ep1, "104", "2015")
replace idglg_expymd_ep1 = ustrregexrf(idglg_expymd_ep1, "105", "2016")
replace idglg_expymd_ep1 = ustrregexrf(idglg_expymd_ep1, "106", "2017") //將民國年改成西元年

tab tstyr_ep1 idglg_expymd_ep1, missing

/*實驗班名稱*/
tab expcls_ep1, missing
tab expcls_ep1 clstyp_ep1, missing

//沒有 obs 有實驗班名稱，但無實驗班註記
//276 obs 就讀實驗班，但未註記名稱

/*入學方式*/
tab admchan_ep1, missing
replace admchan_ep1 = "" if admchan_ep1 == "無註記"
replace admchan_ep1 = "免試入學—就學區免試入學" if admchan_ep1 == ""
replace admchan_ep1 = "免試入學—就學區免試入學" if admchan_ep1 == "分區免試"
replace admchan_ep1 = "免試入學—就學區免試入學—免試入學續招" if admchan_ep1 == "免試續招"

replace admchan_ep1 = "免試入學—優先免試入學" if admchan_ep1 == "優先免試入學"
replace admchan_ep1 = "免試入學—試辦學習區完全免試入學" if admchan_ep1 == "學習區完全免試入學" | admchan_ep1 == "試辦學習區完全免試入學" 
replace admchan_ep1 = "免試入學—直升入學" if admchan_ep1 == "直升入學" | admchan_ep1 == "直升"
replace admchan_ep1 = "免試入學—技優甄審入學" if admchan_ep1 == "技優甄審"
replace admchan_ep1 = "免試入學—其他免試入學—園區生免試入學、實驗教育" if admchan_ep1 == "園區生獨招、實驗教育"
replace admchan_ep1 = "免試入學—其他免試入學—宜蘭區專長生" if admchan_ep1 == "宜蘭區專長生"
replace admchan_ep1 = "免試入學—其他免試入學—基北區產業特殊需求類科" if admchan_ep1 == "基北區產特"
replace admchan_ep1 = "免試入學—其他免試入學—屏東區離島生" if admchan_ep1 == "屏東區離島生" | admchan_ep1 == "離島生"

replace admchan_ep1 = "免試入學—其他免試入學—原住民藝能班" if admchan_ep1 == "原住民藝能班"
replace admchan_ep1 = "免試入學—其他免試入學—原住民藝能班、原住民教育實驗專班" if admchan_ep1 == "原住民藝能班、實驗班"

replace admchan_ep1 = "免試入學—其他免試入學—技術型及單科型單獨辦理免試招生" if admchan_ep1 == "技術型及單科型"
replace admchan_ep1 = "免試入學—其他免試入學—進修學校非應屆獨招" if admchan_ep1 == "進修學校非應屆獨招" | admchan_ep1 == "進修部非應屆獨招" | admchan_ep1 == "進校(部)非應屆獨招"

replace admchan_ep1 = "特色招生—科學班甄選入學" if admchan_ep1 == "甄選入學(科學班)"
replace admchan_ep1 = "特色招生—藝才班甄選入學" if admchan_ep1 == "甄選入學(藝才班-甄選入學)" | admchan_ep1 == "甄選入學(藝才班-競賽表現)"
replace admchan_ep1 = "特色招生—體育班甄選入學" if admchan_ep1 == "甄選入學(體育班)"

replace admchan_ep1 = "未受補助私校單獨招生" if admchan_ep1 == "未受補助私校"

replace admchan_ep1 = "其他—實用技能學程" if admchan_ep1 == "實用技能學程" | admchan_ep1 == "實用技能班"
replace admchan_ep1 = "其他—建教合作班" if admchan_ep1 == "建教班"
replace admchan_ep1 = "其他—身心障礙適性輔導就學安置" if admchan_ep1 == "身障適性輔導就學安置"

tab admchan_ep1, missing

replace admchan_ep1 = "其他—臺商子弟專案" if admchan_ep1 == "臺商子弟專案"

//不確定如何分類
tab sch_ep1 clstyp_ep1 if admchan_ep1 == "甄試入學"
//73 obs all from 801M01_私立東莞台商子弟學校 & 1_日間部(一般班)
list if admchan_ep1 == "聯招生" //3 obs  801M02_私立華東臺商子女學校  
list if admchan_ep1 == "復學" //1 obs  801M01_私立東莞台商子弟學校 
tab sch_ep1 clstyp_ep1 if admchan_ep1 == "免試入學" // 68  obs 801M01_私立東莞台商子弟學校 
list if admchan_ep1 == "轉入"
//2 obs 801M01_私立東莞台商子弟學校

/*學籍狀態*/
tab sts_ep1, missing

/*學籍異動日期*/
//將學籍異動日期刪去上（下）午和時分秒
split sts_chgymd_ep1, parse(" ")
drop sts_chgymd_ep1 sts_chgymd_ep12 sts_chgymd_ep13
rename sts_chgymd_ep11 sts_chgymd_ep1
order sts_chgymd_ep1, before(de_stuid)

tab sts_chgymd_ep1 sts_ep1, missing
tab sts_chgymd_ep1 sts_ep1
//6527 obs 在學且有學籍異動日期

save "data\dta\ep1_1082", replace
export delimited using "data\ep1_1082.csv", replace

//id 重複
duplicates tag id_nat_ep1, gen(id_nat_rep_ep1)
tab id_nat_rep_ep1 //2116 obs 重複 id
keep if id_nat_rep_ep1 > 0

gen sts_chgymd_date_ep1 = date(sts_chgymd_ep1, "YMD")
sort id_nat_rep_ep1 id_nat_ep1 sts_chgymd_date_ep1 //按照學籍變更日期排列
drop sts_chgymd_date_ep1

duplicates tag id_nat_ep1 sch_ep1, gen(idsch_rep_ep1)
tab idsch_rep_ep1 //沒有 obs 重複 id 和學校

duplicates tag id_nat_ep1 sts_ep1, gen(idsts_rep_ep1)
tab idsts_rep_ep1 //18 obs 重複 id 和學籍狀態
sort idsts_rep_ep1 id_nat_ep1

duplicates tag id_nat_ep1 sch_ep1 sts_ep1, gen(idschsts_rep_ep1)
tab idschsts_rep_ep1 //沒有 obs 重複 id、學校和學籍狀態

drop id_nat_rep_ep1 idsch_rep_ep1 idschsts_rep_ep1 idsts_rep_ep1

//有一個人出現學籍變更日期(2019/11/20)和學期(2)不一致的情況
//先 191305_私立新民高中，後 801M02_私立華東臺商子女學校，
//生日 2002/12/18

//----------------------------------------------------------

//109_1_學生資料名冊_學生資料_de
import delimited "data-raw\109_1_學生資料名冊_學生資料_de.csv", bindquote(strict) encoding(UTF-8) stringcols(_all) clear

rename sch_year upl_ayr_ep1
rename semester upl_sem_ep1
rename book bk_nb_ep1
rename book_nm bk_ep1
rename sheet_nm sht_ep1
rename sch_cd sch_cd_ep1
rename sch_nm sch_ep1
rename 身分證號 id_nat_ep1

rename 性別代碼 sex_ep1
rename 群別代碼 grp
rename 科班學程別代碼 dep
rename 部別代碼 schtyp_ep1
rename 班別 clstyp_ep1
rename 年級 gr_ep1
rename 班級名稱 cls_ep1
rename 座號 nb_ep1
rename 特殊身分別 sttyp
rename 原住民族別 idg_ep1
rename 原住民身分別 idgloc_ep1
rename 族語認證報考方言 idglg_ep1
rename 報考年度 tstyr_ep1
rename 族語認證有效日期 idglg_expymd_ep1
rename 實驗班名稱 expcls_ep1
rename 入學方式 admchan_ep1
rename 學籍狀態 sts_ep1
rename 學籍異動日期 sts_chgymd_ep1
rename 出生日期 bymd_ep1

order bymd_ep1, after(sex_ep1)

/*改上傳學年度為西元年，並查看分布狀況*/
changeAD upl_ayr_ep1

/*合併學校代碼與學校名稱為學校名稱*/
replace sch_ep1 = sch_cd_ep1 + "_" + sch_ep1
drop sch_cd_ep1

tab sch_ep1, missing
drop if sch_ep1 == "000000_測試高中" | sch_ep1 == "000001_國教署" | sch_ep1 == "000B00_測試學校(進修部)" | sch_ep1 == "000005_資科司"

/*性別重新編碼*/
changeBV sex_ep1

save "data\dta\ep1_1091", replace

/*學群代碼加上中文解釋後綴*/
do "program\code_type.do" //產生學群、科/班/學程別、特殊身分別代碼

use "data\dta\ep1_1091", replace

/*合併學群代碼的中文解釋*/
merge m:1 grp using "program\grp_cd.dta" 
drop if _merge ==  2  //去除沒有對應到的學群
sort _merge real_grp
tab real_grp, missing //277 obs 沒有學群
tab sch_ep1 if _merge == 1, missing 
drop grp _merge
order real_grp, before(dep) //換上新值
rename real_grp grp_ep1

save "data\dta\ep1_1091", replace

/*科/班/學程別代碼加上中文解釋後綴*/
use "data\dta\ep1_1091", replace

merge m:1 dep using "program\dep_cd.dta"
drop if _merge ==  2  //去除沒有對應到的科/班/學程別
sort _merge real_dep 
tab real_dep, missing //458 obs 沒有科/班/學程別
tab sch_ep1 if _merge == 1, missing
drop dep _merge
order real_dep, after(grp_ep1) //換上新值
rename real_dep dep_ep1

/*部別代碼*/
destring schtyp_ep1, replace
tab schtyp_ep1, missing //介於1~7, normal
tostring schtyp_ep1, replace

/*班別加上中文解釋後綴，若為進修部，再加上前綴 C*/
replace clstyp_ep1 = clstyp_ep1 + "_日間部(一般班)" if clstyp_ep1 == "1"
replace clstyp_ep1 = clstyp_ep1 + "_夜間部(一般班)" if clstyp_ep1 == "2"
replace clstyp_ep1 = clstyp_ep1 + "_實用技能學程(一般班)" if clstyp_ep1 == "3"
replace clstyp_ep1 = clstyp_ep1 + "_建教班" if clstyp_ep1 == "4"
replace clstyp_ep1 = clstyp_ep1 + "_產學訓合作計畫班(產學合作班)" if clstyp_ep1 == "6"
replace clstyp_ep1 = clstyp_ep1 + "_雙軌訓練旗艦計畫班(臺德菁英班)" if clstyp_ep1 == "7"
replace clstyp_ep1 = clstyp_ep1 + "_建教僑生專班" if clstyp_ep1 == "8"
replace clstyp_ep1 = clstyp_ep1 + "_實驗班" if clstyp_ep1 == "9"
replace clstyp_ep1 = "C" + clstyp_ep1 + "_進修部(核定班)" if clstyp_ep1 == "01"
replace clstyp_ep1 = "C" + clstyp_ep1 + "_進修部(員工進修班)" if clstyp_ep1 == "04"
replace clstyp_ep1 = "C" + clstyp_ep1 + "_非班混齡" if clstyp_ep1 == "n"
replace clstyp_ep1 = "C" + clstyp_ep1 + "_班混齡" if clstyp_ep1 == "y"

tab clstyp_ep1, missing //無空值, normal

/*年級*/
tab gr_ep1, missing

/*去除座號*/
drop nb_ep1

/*保留特殊身分別，並改名為(原單位)特殊身份別*/
gen sttyp_raw_ep1 = sttyp
tab sttyp_raw_ep1, missing //normal
protect sttyp_raw_ep1

/*分拆特殊身分別，並加上中文解釋後綴，一般生為0_一般生*/
tab sttyp

//確保 sttyp1 < sttyp2 < ... < sttypn
replace sttyp = "1" if sttyp == ",1" | sttyp == "1,1"
replace sttyp = "1,4" if sttyp == "4,1"
replace sttyp = "1,4,24" if sttyp == "24,1,4"
replace sttyp = "1,10" if sttyp == "10,1"
replace sttyp = "1,11" if sttyp == "11,1"
replace sttyp = "1,24" if sttyp == "24,1"
replace sttyp = "4" if sttyp == ",4"
replace sttyp = "4,24" if sttyp == "24,4"
replace sttyp = "4,24,27" if sttyp == "24,27,4"
replace sttyp = "26" if sttyp == ",26"

tab sttyp

split sttyp, parse(,) //查看分拆情況
sort sttyp

tab sttyp1, missing
replace sttyp1 = "" if sttyp1 == "0" //將一般生代碼統一

tab sttyp2, missing
tab sttyp3, missing

tab sttyp1 sttyp2, missing
tab sttyp2 sttyp3, missing
tab sttyp3 sttyp1, missing //確保沒有重複

merge m:1 sttyp1 using "program\sttyp_cd.dta"
drop if _merge == 2
drop sttyp1 _merge
rename real_sttyp sttyp1_ep1

tab sttyp1_ep1, missing

merge m:1 sttyp2 using "program\sttyp_cd.dta"
drop if _merge == 2 
drop sttyp2 _merge 
rename real_sttyp sttyp2_ep1

tab sttyp2_ep1, missing

merge m:1 sttyp3 using "program\sttyp_cd.dta"
drop if _merge == 2 
drop sttyp3 _merge 
rename real_sttyp sttyp3_ep1

tab sttyp3_ep1, missing

forvalues i = 2/3 {
	replace sttyp`i'_ep1 = "" if sttyp`i'_ep1 == "0_一般生" 
} //如果僅有1種身分別，第2、3種身分別欄應為空白

drop sttyp sttyp1 sttyp2
order sttyp1_ep1 sttyp2_ep1 sttyp3_ep1 sttyp_raw_ep1, before(idg_ep1)

/*原住民族別*/
tab idg_ep1, missing
tab idg_ep1
replace idg_ep1 = "" if idg_ep1 == "無" //統一非原住民標註格式

count if idg_ep1 == "" & (sttyp1_ep1 == "1_原住民生" | sttyp2_ep1 == "1_原住民生" | sttyp3_ep1 == "1_原住民生") 
//177 obs 有原住民特殊身分，但無填報原住民族別

count if idg_ep1 != "" & (sttyp1_ep1 != "1_原住民生" & sttyp2_ep1 != "1_原住民生" & sttyp3_ep1 != "1_原住民生")

tab idg_ep1 if sttyp1_ep1 != "1_原住民生" & sttyp2_ep1 != "1_原住民生" & sttyp3_ep1 != "1_原住民生"
//2663 obs 有填報原住民族別，但無原住民特殊身分
//原住民認定應以特殊身分別，還是原民會借接資料為主？

/*原住民身分別*/
tab idgloc_ep1, missing
tab idgloc_ep1

count if sttyp1_ep1 == "1_原住民生" //12695 obs 
tab idg_ep1 //15181 obs
tab idgloc_ep1 //15185 obs
//具有原住民特殊身分者、有填報原住民族別和有原住民身分別者，三者數目不一致

tab idg_ep1 idgloc_ep1, missing
//26 obs 無填報原住民族別，卻有山原身分
//26 obs 無填報原住民族別，卻有平原身分

tab idgloc_ep1 if sttyp1_ep1 == "1_原住民生", missing
//169 obs 有原住民特殊身分，但無填報原住民身分別

tab idgloc_ep1 if sttyp1_ep1 != "1_原住民生"
//2659 obs 無原住民特殊身分，卻填了原住民身分別

/*報考語言*/
tab idglg_ep1 if sttyp1_ep1 != "1_原住民生"
//1678 obs 不具有原住民特殊身分，卻報考原住民語 (just normal as taking a foreign language test)

tab idglg_ep1 if sttyp1_ep1 != "1_原住民生" & idg_ep1 != ""
//1515 obs 不具有原住民特殊身分，卻報考原住民語，填報原住民族別

tab idglg_ep1 if sttyp1_ep1 == "1_原住民生", missing
//4317 obs 有原住民特殊身分，但沒有報考原住民語

/*改報考年度為西元年*/
tab tstyr_ep1, missing //965 obs 填0

tab sch_ep1 if tstyr_ep1 == "0" 
//報考年度為0者為市立啟聰學校、市立啟明學校、臺商子女學校，皆為特殊學校
//於是將無報考年度者統一

replace tstyr_ep1 = "" if tstyr_ep1 == "0"

changeAD tstyr_ep1

tab tstyr_ep1
tab tstyr_ep1 if idglg_ep1 != ""
tab tstyr_ep1 if idglg_ep1 == "", missing 
//語言別與報考年度一致

/*族語認證有效日期*/
sort tstyr_ep1 idglg_expymd_ep1
tab tstyr_ep1 idglg_expymd_ep1, missing
tab tstyr_ep1 idglg_expymd_ep1 if tstyr_ep1 != "", missing

replace idglg_expymd_ep1 = "999" if idglg_expymd_ep1 == "" & tstyr_ep1 != "" //將有報考年度，但有效日期未填報者給予新值999

replace idglg_expymd_ep1 = ustrregexrf(idglg_expymd_ep1, "103", "2014")
replace idglg_expymd_ep1 = ustrregexrf(idglg_expymd_ep1, "104", "2015")
replace idglg_expymd_ep1 = ustrregexrf(idglg_expymd_ep1, "105", "2016")
replace idglg_expymd_ep1 = ustrregexrf(idglg_expymd_ep1, "106", "2017") //將民國年改成西元年

tab tstyr_ep1 idglg_expymd_ep1, missing

/*實驗班名稱*/
tab expcls_ep1, missing
tab expcls_ep1 clstyp_ep1, missing

//沒有 obs 有實驗班名稱，但無實驗班註記
//276 obs 就讀實驗班，但未註記名稱

tab sch_ep1 if expcls_ep1 == "原住民族實驗教育班"
tab sch_ep1 if expcls_ep1 == "原住民教育實驗專班"
tab sch_ep1 if expcls_ep1 == "原住民族實驗教育專班"

replace expcls_ep1 = "原住民族實驗教育班" if expcls_ep1 == "原住民教育實驗專班" | expcls_ep1 == "原住民族實驗教育專班"

/*入學方式*/
tab admchan_ep1, missing
replace admchan_ep1 = "" if admchan_ep1 == "無註記"
replace admchan_ep1 = "免試入學—就學區免試入學" if admchan_ep1 == ""
replace admchan_ep1 = "免試入學—就學區免試入學" if admchan_ep1 == "分區免試"
replace admchan_ep1 = "免試入學—就學區免試入學—免試入學續招" if admchan_ep1 == "免試續招"

replace admchan_ep1 = "免試入學—優先免試入學" if admchan_ep1 == "優先免試入學"
replace admchan_ep1 = "免試入學—試辦學習區完全免試入學" if admchan_ep1 == "學習區完全免試入學" | admchan_ep1 == "試辦學習區完全免試入學" 
replace admchan_ep1 = "免試入學—直升入學" if admchan_ep1 == "直升入學" | admchan_ep1 == "直升"
replace admchan_ep1 = "免試入學—技優甄審入學" if admchan_ep1 == "技優甄審"
replace admchan_ep1 = "免試入學—其他免試入學—園區生免試入學、實驗教育" if admchan_ep1 == "園區生獨招、實驗教育"
replace admchan_ep1 = "免試入學—其他免試入學—宜蘭區專長生" if admchan_ep1 == "宜蘭區專長生"
replace admchan_ep1 = "免試入學—其他免試入學—基北區產業特殊需求類科" if admchan_ep1 == "基北區產特"
replace admchan_ep1 = "免試入學—其他免試入學—屏東區離島生" if admchan_ep1 == "屏東區離島生" | admchan_ep1 == "離島生"

replace admchan_ep1 = "免試入學—其他免試入學—原住民藝能班" if admchan_ep1 == "原住民藝能班"
replace admchan_ep1 = "免試入學—其他免試入學—原住民藝能班、原住民教育實驗專班" if admchan_ep1 == "原住民藝能班、實驗班"

replace admchan_ep1 = "免試入學—其他免試入學—技術型及單科型單獨辦理免試招生" if admchan_ep1 == "技術型及單科型"
replace admchan_ep1 = "免試入學—其他免試入學—進修學校非應屆獨招" if admchan_ep1 == "進修學校非應屆獨招" | admchan_ep1 == "進修部非應屆獨招" | admchan_ep1 == "進校(部)非應屆獨招"

replace admchan_ep1 = "特色招生—科學班甄選入學" if admchan_ep1 == "甄選入學(科學班)"
replace admchan_ep1 = "特色招生—藝才班甄選入學" if admchan_ep1 == "甄選入學(藝才班-甄選入學)" | admchan_ep1 == "甄選入學(藝才班-競賽表現)"
replace admchan_ep1 = "特色招生—體育班甄選入學" if admchan_ep1 == "甄選入學(體育班)"

replace admchan_ep1 = "未受補助私校單獨招生" if admchan_ep1 == "未受補助私校"

replace admchan_ep1 = "其他—實用技能學程" if admchan_ep1 == "實用技能學程" | admchan_ep1 == "實用技能班"
replace admchan_ep1 = "其他—建教合作班" if admchan_ep1 == "建教班"
replace admchan_ep1 = "其他—身心障礙適性輔導就學安置" if admchan_ep1 == "身障適性輔導就學安置"

tab admchan_ep1, missing

replace admchan_ep1 = "其他—臺商子弟專案" if admchan_ep1 == "臺商子弟專案"
tab sch_ep1 clstyp_ep1 if admchan_ep1 == "其他—臺商子弟專案"

//不確定如何分類
tab sch_ep1 clstyp_ep1 if admchan_ep1 == "甄試入學"
//142 obs all from 801M01_私立東莞台商子弟學校 & 1_日間部(一般班)
list if admchan_ep1 == "聯招生" //7 obs  801M02_私立華東臺商子女學校  
list if admchan_ep1 == "復學" //1 obs  801M01_私立東莞台商子弟學校 
tab sch_ep1 clstyp_ep1 if admchan_ep1 == "免試入學" // 112  obs 801M01_私立東莞台商子弟學校 
list if admchan_ep1 == "轉入生"
//7 obs 801M01_私立東莞台商子弟學校
replace admchan_ep1 = "轉入" if admchan_ep1 == "轉入生"

/*學籍狀態*/
tab sts_ep1, missing

/*學籍異動日期*/
//將學籍異動日期刪去上（下）午和時分秒
split sts_chgymd_ep1, parse(" ")
drop sts_chgymd_ep1 sts_chgymd_ep12 sts_chgymd_ep13
rename sts_chgymd_ep11 sts_chgymd_ep1
order sts_chgymd_ep1, before(de_stuid)

tab sts_chgymd_ep1 sts_ep1, missing
tab sts_chgymd_ep1 sts_ep1
//11612 obs 在學且有學籍異動日期

save "data\dta\ep1_1091", replace
export delimited using "data\ep1_1091.csv", replace

//id 重複
duplicates tag id_nat_ep1, gen(id_nat_rep_ep1)
tab id_nat_rep_ep1 //1596 obs 重複 id
keep if id_nat_rep_ep1 > 0

gen sts_chgymd_date_ep1 = date(sts_chgymd_ep1, "YMD")
sort id_nat_rep_ep1 id_nat_ep1 sts_chgymd_date_ep1 //按照學籍變更日期排列
drop sts_chgymd_date_ep1

duplicates tag id_nat_ep1 sch_ep1, gen(idsch_rep_ep1)
tab idsch_rep_ep1 //10 obs 重複 id 和學校
sort idsch_rep_ep1 id_nat_ep1
order idsch_rep_ep1, before(id_nat_ep1)
list if idsch_rep_ep1 == 1

duplicates tag id_nat_ep1 sts_ep1, gen(idsts_rep_ep1)
tab idsts_rep_ep1 //38 obs 重複 id 和學籍狀態
sort idsts_rep_ep1 id_nat_ep1
order idsts_rep_ep1, before(id_nat_ep1)  //學校都不一樣
list if idsts_rep_ep1 == 1

duplicates tag id_nat_ep1 sch_ep1 sts_ep1, gen(idschsts_rep_ep1)
tab idschsts_rep_ep1 //2 obs 重複 id、學校和學籍狀態
list if idschsts_rep_ep1 == 1
//只有生日不一樣，應為重複值

drop id_nat_rep_ep1 idsch_rep_ep1 idsts_rep_ep1 idschsts_rep_ep1

