//108_1_學生重修重讀成績名冊_重修成績
import delimited "data-raw\108_1_學生重修重讀成績名冊_重修成績.csv", bindquote(strict) stringcols(_all) clear

rename sch_year upl_ayr_ep8
rename semester upl_sem_ep8
rename book bk_nb_ep8
rename book_nm bk_ep8
rename sheet_nm sht_ep8
rename sch_cd sch_cd_ep8
rename sch_nm sch_ep8
rename 身分證號 id_nat_ep8

rename 原修課學年度 ori_ayr_ep8
rename 原修課學期 ori_sem_ep8
rename 原修課課程代碼 ori_crs_cd_ep8
rename 原修課科目名稱 ori_crs_ep8
rename 原修課開課年級 ori_stgr_ep8
rename 原修課修課學分 ori_cr_ep8
rename 重修方式 typ_ep8
rename 重修成績 sc_ep8
rename 重修及格 ps_ep8
rename 質性文字描述 desc_ep8

/*改上傳學年度為西元年，並查看分布狀況*/
changeAD upl_ayr_ep8

/*合併學校代碼與學校名稱為學校名稱*/
replace sch_ep8 = sch_cd_ep8 + "_" + sch_ep8
drop sch_cd_ep8

tab sch_ep8
drop if sch_ep8 == "000001_國教署"
tab sch_ep8 if ustrregexm(sch_ep8, "進修部") == 1 
//0 obs 進修部

/*改原修課學年度為西元年，並查看分布狀況*/
changeAD ori_ayr_ep8

/*原修課學期、開課年級*/
tab ori_sem_ep8, missing
tab ori_stgr_ep8, missing

/*重修方式*/
tab typ_ep8, missing

/*重修成績、重修及格*/
destring sc_ep8, replace
changeBV ps_ep8
tab sc_ep8 ps_ep8, missing
tostring sc_ep8, replace
 
/*文字描述前後加上 " " */
protect desc_ep8

save "data\dta\ep8_1081", replace
export delimited using "data\ep8_1081.csv", replace

//108_2_學生重修重讀成績名冊_重修成績
import delimited "data-raw\108_2_學生重修重讀成績名冊_重修成績.csv", bindquote(strict) stringcols(_all) clear

rename sch_year upl_ayr_ep8
rename semester upl_sem_ep8
rename book bk_nb_ep8
rename book_nm bk_ep8
rename sheet_nm sht_ep8
rename sch_cd sch_cd_ep8
rename sch_nm sch_ep8
rename 身分證號 id_nat_ep8

rename 原修課學年度 ori_ayr_ep8
rename 原修課學期 ori_sem_ep8
rename 原修課課程代碼 ori_crs_cd_ep8
rename 原修課科目名稱 ori_crs_ep8
rename 原修課開課年級 ori_stgr_ep8
rename 原修課修課學分 ori_cr_ep8
rename 重修方式 typ_ep8
rename 重修成績 sc_ep8
rename 重修及格 ps_ep8
rename 質性文字描述 desc_ep8

/*改上傳學年度為西元年，並查看分布狀況*/
changeAD upl_ayr_ep8

/*合併學校代碼與學校名稱為學校名稱*/
replace sch_ep8 = sch_cd_ep8 + "_" + sch_ep8
drop sch_cd_ep8

tab sch_ep8
drop if sch_ep8 == "000001_國教署"
tab sch_ep8 if ustrregexm(sch_ep8, "進修部") == 1 
//271 obs 進修部

/*改原修課學年度為西元年，並查看分布狀況*/
changeAD ori_ayr_ep8

/*原修課學期、開課年級*/
tab ori_sem_ep8, missing
tab ori_stgr_ep8, missing

/*重修方式*/
tab typ_ep8, missing

/*重修成績、重修及格*/
destring sc_ep8, replace
changeBV ps_ep8
tab sc_ep8 ps_ep8, missing
tostring sc_ep8, replace
 
/*文字描述前後加上 " " */
protect desc_ep8

save "data\dta\ep8_1082", replace
export delimited using "data\ep8_1082.csv", replace

//109_1_學生重修重讀成績名冊_重修成績
import delimited "data-raw\109_1_學生重修重讀成績名冊_重修成績.csv", bindquote(strict) stringcols(_all) clear

rename sch_year upl_ayr_ep8
rename semester upl_sem_ep8
rename book bk_nb_ep8
rename book_nm bk_ep8
rename sheet_nm sht_ep8
rename sch_cd sch_cd_ep8
rename sch_nm sch_ep8
rename 身分證號 id_nat_ep8

rename 原修課學年度 ori_ayr_ep8
rename 原修課學期 ori_sem_ep8
rename 原修課課程代碼 ori_crs_cd_ep8
rename 原修課科目名稱 ori_crs_ep8
rename 原修課開課年級 ori_stgr_ep8
rename 原修課修課學分 ori_cr_ep8
rename 重修方式 typ_ep8
rename 重修成績 sc_ep8
rename 重修及格 ps_ep8
rename 質性文字描述 desc_ep8

/*改上傳學年度為西元年，並查看分布狀況*/
changeAD upl_ayr_ep8

/*合併學校代碼與學校名稱為學校名稱*/
replace sch_ep8 = sch_cd_ep8 + "_" + sch_ep8
drop sch_cd_ep8

tab sch_ep8
tab sch_ep8 if ustrregexm(sch_ep8, "進修部") == 1 
//352 obs 進修部

/*改原修課學年度為西元年，並查看分布狀況*/
changeAD ori_ayr_ep8

/*原修課學期、開課年級*/
tab ori_sem_ep8, missing
tab ori_stgr_ep8, missing

/*重修方式*/
tab typ_ep8, missing

/*重修成績、重修及格*/
destring sc_ep8, replace
changeBV ps_ep8
tab sc_ep8 ps_ep8, missing
list if sc_ep8 == 0 & ps_ep8 == "1" //3 obs 0 分但過了
tostring sc_ep8, replace
 
/*文字描述前後加上 " " */
protect desc_ep8

save "data\dta\ep8_1091", replace
export delimited using "data\ep8_1091.csv", replace