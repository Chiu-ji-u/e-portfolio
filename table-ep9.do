//108_1_學生重修重讀成績名冊_重讀成績
import delimited "data-raw\108_1_學生重修重讀成績名冊_重讀成績.csv", bindquote(strict) stringcols(_all) clear

rename sch_year upl_ayr_ep9
rename semester upl_sem_ep9
rename book bk_nb_ep9
rename book_nm bk_ep9
rename sheet_nm sht_ep9
rename sch_cd sch_cd_ep9
rename sch_nm sch_ep9
rename 身分證號 id_nat_ep9

rename 課程代碼 crs_cd_ep9
rename 科目名稱 crs_ep9
rename 開課年級 stgr_ep9
rename 修課學分 cr_ep9
rename 重讀成績 sc_ep9
rename 成績及格 ps_ep9
rename 補考成績 me_sc_ep9
rename 補考及格 me_ps_ep9
rename 重讀註記 expt_ep9
rename 是否採計學分 sc_ct_ep9
rename 質性文字描述 desc_ep9

/*改上傳學年度為西元年，並查看分布狀況*/
changeAD upl_ayr_ep9

/*合併學校代碼與學校名稱為學校名稱*/
replace sch_ep9 = sch_cd_ep9 + "_" + sch_ep9
drop sch_cd_ep9

tab sch_ep9
drop if sch_ep9 == "000001_國教署"
tab sch_ep9 if ustrregexm(sch_ep9, "進修部") == 1 
//0 obs 進修部

/*開課年級與修課學分*/
tab stgr_ep9, missing
tab cr_ep9, missing
list if cr_ep9 == "0" //不是說團體活動時間和彈性學習時間不會再出現在成績名冊了嗎？ 2 obs 課名各 1

/*重讀成績和成績及格*/
destring sc_ep9, replace
changeBV ps_ep9

tab sc_ep9 ps_ep9, missing
tostring sc_ep9, replace
//剛好就是那兩個團體活動時間和彈性學習時間沒有成績但過了

/*補考成績和補考及格*/
destring me_sc_ep9, replace
changeBV me_ps_ep9

tab me_sc_ep9 me_ps_ep9, missing
tab me_sc_ep9 me_ps_ep9 if ps_ep9 != "1", missing
list if ps_ep9 != "1" & me_sc_ep9 == 60 & me_ps_ep9 == "0"
//去除一開始就過的，2 obs 補考 60 分卻沒過，課名皆為英語文
//學校各為 341302_私立大同高中、191305_私立新民高中
tab me_sc_ep9 me_ps_ep9 if ps_ep9 == "1", missing 
//normal
tostring sc_ep9, replace

/*重讀註記*/
tab expt_ep9, missing
replace expt_ep9 = "0" if expt_ep9 == "1"
replace expt_ep9 = "1" if expt_ep9 == "2"

/*是否採計學分*/
tab sc_ct_ep9, missing

/*文字描述前後加上 " " */
protect desc_ep9

save "data\dta\ep9_1081", replace
export delimited using "data\ep9_1081.csv", replace

//108_2_學生重修重讀成績名冊_重讀成績
import delimited "data-raw\108_2_學生重修重讀成績名冊_重讀成績.csv", bindquote(strict) stringcols(_all) clear

rename sch_year upl_ayr_ep9
rename semester upl_sem_ep9
rename book bk_nb_ep9
rename book_nm bk_ep9
rename sheet_nm sht_ep9
rename sch_cd sch_cd_ep9
rename sch_nm sch_ep9
rename 身分證號 id_nat_ep9

rename 課程代碼 crs_cd_ep9
rename 科目名稱 crs_ep9
rename 開課年級 stgr_ep9
rename 修課學分 cr_ep9
rename 重讀成績 sc_ep9
rename 成績及格 ps_ep9
rename 補考成績 me_sc_ep9
rename 補考及格 me_ps_ep9
rename 重讀註記 expt_ep9
rename 是否採計學分 sc_ct_ep9
rename 質性文字描述 desc_ep9

/*改上傳學年度為西元年，並查看分布狀況*/
changeAD upl_ayr_ep9

/*合併學校代碼與學校名稱為學校名稱*/
replace sch_ep9 = sch_cd_ep9 + "_" + sch_ep9
drop sch_cd_ep9

tab sch_ep9
tab sch_ep9 if ustrregexm(sch_ep9, "進修部") == 1 
//0 obs 進修部

/*開課年級與修課學分*/
tab stgr_ep9, missing
tab cr_ep9, missing

/*重讀成績和成績及格*/
destring sc_ep9, replace
changeBV ps_ep9

tab sc_ep9 ps_ep9, missing
tostring sc_ep9, replace

/*補考成績和補考及格*/
destring me_sc_ep9, replace
changeBV me_ps_ep9

tab me_sc_ep9 me_ps_ep9, missing
tab me_sc_ep9 me_ps_ep9 if ps_ep9 != "1", missing 
list if ps_ep9 != "1" & me_sc_ep9 == 60 & me_ps_ep9 == "0"
//去除一開始就過的，1 obs 補考60分卻沒過
//課名為化學，學校為 341302_私立大同高中
tab me_sc_ep9 me_ps_ep9 if ps_ep9 == "1", missing
//normal
tostring sc_ep9, replace

/*重讀註記*/
tab expt_ep9, missing
replace expt_ep9 = "0" if expt_ep9 == "1"
replace expt_ep9 = "1" if expt_ep9 == "2"

/*是否採計學分*/
tab sc_ct_ep9, missing
list if sc_ct_ep9 == "2"
//1 ob 有學分，沒過，不列入成績

/*文字描述前後加上 " " */
protect desc_ep9

save "data\dta\ep9_1082", replace
export delimited using "data\ep9_1082.csv", replace

//109_1_學生重修重讀成績名冊_重讀成績
import delimited "data-raw\109_1_學生重修重讀成績名冊_重讀成績.csv", bindquote(strict) stringcols(_all) clear

rename sch_year upl_ayr_ep9
rename semester upl_sem_ep9
rename book bk_nb_ep9
rename book_nm bk_ep9
rename sheet_nm sht_ep9
rename sch_cd sch_cd_ep9
rename sch_nm sch_ep9
rename 身分證號 id_nat_ep9

rename 課程代碼 crs_cd_ep9
rename 科目名稱 crs_ep9
rename 開課年級 stgr_ep9
rename 修課學分 cr_ep9
rename 重讀成績 sc_ep9
rename 成績及格 ps_ep9
rename 補考成績 me_sc_ep9
rename 補考及格 me_ps_ep9
rename 重讀註記 expt_ep9
rename 是否採計學分 sc_ct_ep9
rename 質性文字描述 desc_ep9

/*改上傳學年度為西元年，並查看分布狀況*/
changeAD upl_ayr_ep9

/*合併學校代碼與學校名稱為學校名稱*/
replace sch_ep9 = sch_cd_ep9 + "_" + sch_ep9
drop sch_cd_ep9

tab sch_ep9
tab sch_ep9 if ustrregexm(sch_ep9, "進修部") == 1 
//2 obs 進修部

/*開課年級與修課學分*/
tab stgr_ep9, missing
tab cr_ep9, missing

/*重讀成績和成績及格*/
destring sc_ep9, replace
changeBV ps_ep9

tab sc_ep9 ps_ep9, missing
tostring sc_ep9, replace

/*補考成績和補考及格*/
destring me_sc_ep9, replace
changeBV me_ps_ep9

tab me_sc_ep9 me_ps_ep9, missing
tab me_sc_ep9 me_ps_ep9 if ps_ep9 != "1", missing 
list if ps_ep9 != "1" & me_sc_ep9 == 60 & me_ps_ep9 == "0"
tab sch_ep9 crs_ep9 if ps_ep9 != "1" & me_sc_ep9 == 60 & me_ps_ep9 == "0"
//去除一開始就過的，50 obs 補考60分卻沒過

tab me_sc_ep9 me_ps_ep9 if ps_ep9 == "1", missing
//9 obs 過了卻跑來補考
tostring sc_ep9, replace

/*重讀註記*/
tab expt_ep9, missing
replace expt_ep9 = "0" if expt_ep9 == "1"
replace expt_ep9 = "1" if expt_ep9 == "2"

/*是否採計學分*/
tab sc_ct_ep9, missing
list if sc_ct_ep9 == "2"
//5 ob 有學分，沒過，不列入成績

/*文字描述前後加上 " " */
protect desc_ep9

save "data\dta\ep9_1091", replace
export delimited using "data\ep9_1091.csv", replace