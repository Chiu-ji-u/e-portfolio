//108_1_進修部(學校)學生成績名冊_學期成績
import delimited "data-raw\108_1_進修部(學校)學生成績名冊_學期成績.csv", bindquote(strict) stringcols(_all) clear

rename sch_year upl_ayr_ep10
rename semester upl_sem_ep10
rename book bk_nb_ep10
rename book_nm bk_ep10
rename sheet_nm sht_ep10
rename sch_cd sch_cd_ep10
rename sch_nm sch_ep10
rename 身分證號 id_nat_ep10

rename 課程代碼 crs_cd_ep10
rename 科目名稱 crs_ep10
rename 開課年級 stgr_ep10
rename 修課節數 un_ep10
rename 學期學業成績 sem_sc_ep10
rename 成績及格 ps_ep10
rename 學年學業成績 ayr_sc_ep10
rename 學年及格 ayr_ps_ep10
rename 是否採計學時 sc_ct_ep10
rename 質性文字描述 desc_ep10

/*改上傳學年度為西元年，並查看分布狀況*/
changeAD upl_ayr_ep10

/*合併學校代碼與學校名稱為學校名稱*/
replace sch_ep10 = sch_cd_ep10 + "_" + sch_ep10
drop sch_cd_ep10

tab sch_ep10
drop if sch_ep10 == "000B00_測試學校(進修部)"
tab sch_ep10 if ustrregexm(sch_ep10, "進修") == 0 
//皆為進修

/*開課年級*/
tab stgr_ep10, missing

/*學期學業成績與成績及格*/
destring sem_sc_ep10, replace
tab sem_sc_ep10, missing

tab ps_ep10, missing
tab sem_sc_ep10 ps_ep10, missing
tostring sem_sc_ep10, replace

changeBV ps_ep10

/*學年學業成績*/
destring ayr_sc_ep10, replace
tab ayr_sc_ep10, missing
tab ayr_ps_ep10, missing
tab ayr_sc_ep10 ayr_ps_ep10, missing
tostring ayr_sc_ep10, replace

/*文字描述前後加上 " " */
protect desc_ep10

save "data\dta\ep10_1081", replace
export delimited using "data\ep10_1081.csv", replace

//108_2_進修部(學校)學生成績名冊_學期成績
import delimited "data-raw\108_2_進修部(學校)學生成績名冊_學期成績.csv", bindquote(strict) stringcols(_all) clear

rename sch_year upl_ayr_ep10
rename semester upl_sem_ep10
rename book bk_nb_ep10
rename book_nm bk_ep10
rename sheet_nm sht_ep10
rename sch_cd sch_cd_ep10
rename sch_nm sch_ep10
rename 身分證號 id_nat_ep10

rename 課程代碼 crs_cd_ep10
rename 科目名稱 crs_ep10
rename 開課年級 stgr_ep10
rename 修課節數 un_ep10
rename 學期學業成績 sem_sc_ep10
rename 成績及格 ps_ep10
rename 學年學業成績 ayr_sc_ep10
rename 學年及格 ayr_ps_ep10
rename 是否採計學時 sc_ct_ep10
rename 質性文字描述 desc_ep10

/*改上傳學年度為西元年，並查看分布狀況*/
changeAD upl_ayr_ep10

/*合併學校代碼與學校名稱為學校名稱*/
replace sch_ep10 = sch_cd_ep10 + "_" + sch_ep10
drop sch_cd_ep10

tab sch_ep10
drop if sch_ep10 == "000B00_測試學校(進修部)"
tab sch_ep10 if ustrregexm(sch_ep10, "進修") == 0 
//皆為進修

/*開課年級*/
tab stgr_ep10, missing

/*學期學業成績與成績及格*/
destring sem_sc_ep10, replace
tab sem_sc_ep10, missing

tab ps_ep10, missing
tab sem_sc_ep10 ps_ep10, missing
tostring sem_sc_ep10, replace

changeBV ps_ep10

/*學年學業成績*/
destring ayr_sc_ep10, replace
tab ayr_sc_ep10, missing
tab ayr_ps_ep10, missing
tab ayr_sc_ep10 ayr_ps_ep10, missing
tostring ayr_sc_ep10, replace

/*文字描述前後加上 " " */
protect desc_ep10

save "data\dta\ep10_1082", replace
export delimited using "data\ep10_1082.csv", replace
 
//合併108學年
append using  "data\dta\ep10_1081"
sort id_nat_ep10 crs_ep10 upl_sem_ep10
save "data\dta\ep10_108", replace

//109_1_進修部(學校)學生成績名冊_學期成績
import delimited "data-raw\109_1_進修部(學校)學生成績名冊_學期成績.csv", bindquote(strict) stringcols(_all) clear

rename sch_year upl_ayr_ep10
rename semester upl_sem_ep10
rename book bk_nb_ep10
rename book_nm bk_ep10
rename sheet_nm sht_ep10
rename sch_cd sch_cd_ep10
rename sch_nm sch_ep10
rename 身分證號 id_nat_ep10

rename 課程代碼 crs_cd_ep10
rename 科目名稱 crs_ep10
rename 開課年級 stgr_ep10
rename 修課節數 un_ep10
rename 學期學業成績 sem_sc_ep10
rename 成績及格 ps_ep10
rename 學年學業成績 ayr_sc_ep10
rename 學年及格 ayr_ps_ep10
rename 是否採計學時 sc_ct_ep10
rename 質性文字描述 desc_ep10

/*改上傳學年度為西元年，並查看分布狀況*/
changeAD upl_ayr_ep10

/*合併學校代碼與學校名稱為學校名稱*/
replace sch_ep10 = sch_cd_ep10 + "_" + sch_ep10
drop sch_cd_ep10

tab sch_ep10
tab sch_ep10 if ustrregexm(sch_ep10, "進修") == 0 
//皆為進修

/*開課年級*/
tab stgr_ep10, missing

/*學期學業成績與成績及格*/
destring sem_sc_ep10, replace
tab sem_sc_ep10, missing

tab ps_ep10, missing
tab sem_sc_ep10 ps_ep10, missing
tostring sem_sc_ep10, replace

changeBV ps_ep10

/*學年學業成績*/
destring ayr_sc_ep10, replace
tab ayr_sc_ep10, missing
tab ayr_ps_ep10, missing
tab ayr_sc_ep10 ayr_ps_ep10, missing
tostring ayr_sc_ep10, replace

/*文字描述前後加上 " " */
protect desc_ep10

save "data\dta\ep10_1091", replace
export delimited using "data\ep10_1091.csv", replace