//108_1_學生成績名冊_補修成績
import delimited "data-raw\108_1_學生成績名冊_補修成績.csv", bindquote(strict) stringcols(_all) clear 

rename sch_year upl_ayr_ep6
rename semester upl_sem_ep6
rename book bk_nb_ep6
rename book_nm bk_ep6
rename sheet_nm sht_ep6
rename sch_cd sch_cd_ep6
rename sch_nm sch_ep6
rename 身分證號 id_nat_ep6

rename 應修課學年度 skd_ayr_ep6
rename 應修課學期 skd_sem_ep6
rename 課程代碼 crs_cd_ep6
rename 科目名稱 crs_ep6
rename 開課年級 stgr_ep6
rename 修課學分 cr_ep6
rename 補修成績 sc_ep6
rename 補修及格 ps_ep6
rename 補考成績 me_sc_ep6
rename 補考及格 me_ps_ep6
rename 補修方式 typ_ep6
rename 是否採計學分 sc_ct_ep6
rename 質性文字描述 desc_ep6

/*改上傳學年度為西元年，並查看分布狀況*/
changeAD upl_ayr_ep6

/*合併學校代碼與學校名稱為學校名稱*/
replace sch_ep6 = sch_cd_ep6 + "_" + sch_ep6
drop sch_cd_ep6

tab sch_ep6
drop if sch_ep6 == "000000_測試高中" | sch_ep6 == "000001_國教署"

//0 obs

save "data\dta\ep6_1081", replace
export delimited using "data\ep6_1081.csv", replace

//108_2_學生成績名冊_補修成績
import delimited "data-raw\108_2_學生成績名冊_補修成績.csv", bindquote(strict) stringcols(_all) clear 

rename sch_year upl_ayr_ep6
rename semester upl_sem_ep6
rename book bk_nb_ep6
rename book_nm bk_ep6
rename sheet_nm sht_ep6
rename sch_cd sch_cd_ep6
rename sch_nm sch_ep6
rename 身分證號 id_nat_ep6

rename 應修課學年度 skd_ayr_ep6
rename 應修課學期 skd_sem_ep6
rename 課程代碼 crs_cd_ep6
rename 科目名稱 crs_ep6
rename 開課年級 stgr_ep6
rename 修課學分 cr_ep6
rename 補修成績 sc_ep6
rename 補修及格 ps_ep6
rename 補考成績 me_sc_ep6
rename 補考及格 me_ps_ep6
rename 補修方式 typ_ep6
rename 是否採計學分 sc_ct_ep6
rename 質性文字描述 desc_ep6

/*改上傳學年度為西元年，並查看分布狀況*/
changeAD upl_ayr_ep6

/*合併學校代碼與學校名稱為學校名稱*/
replace sch_ep6 = sch_cd_ep6 + "_" + sch_ep6
drop sch_cd_ep6

tab sch_ep6
drop if sch_ep6 == "000000_測試高中" | sch_ep6 == "000001_國教署" | sch_ep6 == "000005_資科司"
tab sch_ep6 if ustrregexm(sch_ep6, "進修部") == 1 
//0 obs 進修部

/*改應修學年度為西元年，並查看分布狀況*/
changeAD skd_ayr_ep6

/*應修學期*/
tab skd_sem_ep6, missing

/*開課年級*/
tab stgr_ep6, missing

/*補修成績、補修分數及格*/
destring sc_ep6, replace
changeBV ps_ep6

tab sc_ep6 ps_ep6, missing
tostring sc_ep6, replace

/*補考成績、補考及格*/
tab me_sc_ep6 me_ps_ep6, missing
//0分是以缺考還是沒有成績處理？
//17 obs 0分但標沒有成績，4 obs 卻標沒過
tab me_sc_ep6 me_ps_ep6 if ps_ep6 == "1", missing
//7 obs 過了，但補考標0分然後沒有成績
tostring me_sc_ep6, replace

/*補修方式*/
tab typ_ep6, missing

/*分數是否列入計算*/
tab sc_ct_ep6, missing

destring sc_ep6, replace
tab sc_ep6 ps_ep6 if sc_ct_ep6 == "3", missing
tostring sc_ep6, replace

/*文字描述前後加上 " " */
protect desc_ep6

save "data\dta\ep6_1082", replace
export delimited using "data\ep6_1082.csv", replace

//109_1_學生成績名冊_補修成績
import delimited "data-raw\109_1_學生成績名冊_補修成績.csv", bindquote(strict) stringcols(_all) clear 

rename sch_year upl_ayr_ep6
rename semester upl_sem_ep6
rename book bk_nb_ep6
rename book_nm bk_ep6
rename sheet_nm sht_ep6
rename sch_cd sch_cd_ep6
rename sch_nm sch_ep6
rename 身分證號 id_nat_ep6

rename 應修課學年度 skd_ayr_ep6
rename 應修課學期 skd_sem_ep6
rename 課程代碼 crs_cd_ep6
rename 科目名稱 crs_ep6
rename 開課年級 stgr_ep6
rename 修課學分 cr_ep6
rename 補修成績 sc_ep6
rename 補修及格 ps_ep6
rename 補考成績 me_sc_ep6
rename 補考及格 me_ps_ep6
rename 補修方式 typ_ep6
rename 是否採計學分 sc_ct_ep6
rename 質性文字描述 desc_ep6

/*改上傳學年度為西元年，並查看分布狀況*/
changeAD upl_ayr_ep6

/*合併學校代碼與學校名稱為學校名稱*/
replace sch_ep6 = sch_cd_ep6 + "_" + sch_ep6
drop sch_cd_ep6

tab sch_ep6
tab sch_ep6 if ustrregexm(sch_ep6, "進修部") == 1 
//0 obs 進修部

/*改應修學年度為西元年，並查看分布狀況*/
changeAD skd_ayr_ep6

/*應修學期*/
tab skd_sem_ep6, missing

/*開課年級*/
tab stgr_ep6, missing

/*補修成績、補修分數及格*/
destring sc_ep6, replace
changeBV ps_ep6

tab sc_ep6 ps_ep6, missing
list if sc_ep6 == 0 & ps_ep6 == "1" //自學輔導，0 分卻及格

tostring sc_ep6, replace

/*補考成績、補考及格*/
tab me_sc_ep6 me_ps_ep6, missing

tab me_sc_ep6 me_ps_ep6 if ps_ep6 == "1", missing
//7 obs 已經過了，但2 obs 補考0分然後沒過，3 obs 補考60分過了

/*補修方式*/
tab typ_ep6, missing

/*分數是否列入計算*/
tab sc_ct_ep6, missing

destring sc_ep6, replace
tab sc_ep6 ps_ep6 if sc_ct_ep6 == "3", missing
tostring sc_ep6, replace

/*文字描述前後加上 " " */
protect desc_ep6

save "data\dta\ep6_1091", replace
export delimited using "data\ep6_1091.csv", replace