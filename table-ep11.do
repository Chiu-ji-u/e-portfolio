//108_1_進修部(學校)學生成績名冊_補考成績
import delimited "data-raw\108_1_進修部(學校)學生成績名冊_補考成績.csv", bindquote(strict) stringcols(_all) clear

rename sch_year upl_ayr_ep11
rename semester upl_sem_ep11
rename book bk_nb_ep11
rename book_nm bk_ep11
rename sheet_nm sht_ep11
rename sch_cd sch_cd_ep11
rename sch_nm sch_ep11
rename 身分證號 id_nat_ep11

rename 課程代碼 crs_cd_ep11
rename 科目名稱 crs_ep11
rename 開課年級 stgr_ep11
rename 第一學期開設修課節數 fstsem_un_ep11
rename 第二學期開設修課節數 sndsem_un_ep11
rename 第一次補考成績 fst_sc_ep11
rename 第一次及格 fst_ps_ep11
rename 第二次補考成績 snd_sc_ep11
rename 第二次及格 snd_ps_ep11

/*改上傳學年度為西元年，並查看分布狀況*/
changeAD upl_ayr_ep11

/*合併學校代碼與學校名稱為學校名稱*/
replace sch_ep11 = sch_cd_ep11 + "_" + sch_ep11
drop sch_cd_ep11

tab sch_ep11
tab sch_ep11 if ustrregexm(sch_ep11, "進修") == 0 
//皆為進修

/*開課年級*/
tab stgr_ep11, missing

/*開設節數*/
tab fstsem_un_ep11, missing
tab sndsem_un_ep11, missing

/*第一次補考*/
destring fst_sc_ep11, replace
tab fst_sc_ep11 fst_ps_ep11, missing

changeBV fst_ps_ep11

//38 obs fst_sc_ep11 = -1, fst_ps_ep11 = 1

/*第二次補考*/
destring snd_sc_ep11, replace
tab snd_sc_ep11 snd_ps_ep11, missing

//225 obs snd_sc_ep11 = -1
//45 obs snd_sc_ep11 = -1, snd_ps_ep11 = 1

tostring fst_sc_ep11, replace
tostring snd_sc_ep11, replace

/*第一與第二次補考*/
tab snd_sc_ep11 snd_ps_ep11 if fst_sc_ep11 == "-1" & fst_ps_ep11 == "1" //38 obs snd_sc_ep11 = -1, snd_ps_ep11 = 1
tab fst_sc_ep11 fst_ps_ep11 if snd_sc_ep11 == "-1" & snd_ps_ep11 == "1" 
//38 obs fst_sc_ep11 = -1, fst_ps_ep11 = 1
//7 obs fst_sc_ep11 = 60, fst_ps_ep11 = 1

tab snd_sc_ep11 if fst_ps_ep11 == "1" & snd_ps_ep11 == "-1" //no obs
tab snd_sc_ep11 if fst_ps_ep11 == "0" & snd_ps_ep11 == "-1" //no obs

tab fst_ps_ep11 snd_ps_ep11, missing

tab fst_sc_ep11 snd_sc_ep11 if fst_ps_ep11 == "1" & snd_ps_ep11 == "1", missing
//38 obs fst_sc_ep11 = -1, snd_ps_ep11 = -1
//7 obs fst_sc_ep11 = 60, snd_ps_ep11 = -1
//為什麼補考沒有成績但及格了？

save "data\dta\ep11_1081", replace
export delimited using "data\ep11_1081.csv", replace

//108_2_進修部(學校)學生成績名冊_補考成績
import delimited "data-raw\108_2_進修部(學校)學生成績名冊_補考成績.csv", bindquote(strict) stringcols(_all) clear

rename sch_year upl_ayr_ep11
rename semester upl_sem_ep11
rename book bk_nb_ep11
rename book_nm bk_ep11
rename sheet_nm sht_ep11
rename sch_cd sch_cd_ep11
rename sch_nm sch_ep11
rename 身分證號 id_nat_ep11

rename 課程代碼 crs_cd_ep11
rename 科目名稱 crs_ep11
rename 開課年級 stgr_ep11
rename 第一學期開設修課節數 fstsem_un_ep11
rename 第二學期開設修課節數 sndsem_un_ep11
rename 第一次補考成績 fst_sc_ep11
rename 第一次及格 fst_ps_ep11
rename 第二次補考成績 snd_sc_ep11
rename 第二次及格 snd_ps_ep11

/*改上傳學年度為西元年，並查看分布狀況*/
changeAD upl_ayr_ep11

/*合併學校代碼與學校名稱為學校名稱*/
replace sch_ep11 = sch_cd_ep11 + "_" + sch_ep11
drop sch_cd_ep11

tab sch_ep11
tab sch_ep11 if ustrregexm(sch_ep11, "進修") == 0 
//皆為進修

/*開課年級*/
tab stgr_ep11, missing

/*開設節數*/
tab fstsem_un_ep11, missing
tab sndsem_un_ep11, missing

/*第一次補考*/
destring fst_sc_ep11, replace
tab fst_sc_ep11 fst_ps_ep11, missing
tostring fst_sc_ep11, replace

changeBV fst_ps_ep11

//205 obs fst_sc_ep11 = -1, fst_ps_ep11 = 1

/*第二次補考*/
destring snd_sc_ep11, replace
tab snd_sc_ep11 snd_ps_ep11, missing
tostring snd_sc_ep11, replace

//3811 obs snd_sc_ep11 = -1
//381 obs snd_sc_ep11 = -1, snd_ps_ep11 = 0
//175 obs snd_sc_ep11 = -1, snd_ps_ep11 = 1 (?)

/*第一與第二次補考*/
tab snd_sc_ep11 snd_ps_ep11 if fst_sc_ep11 == "-1" & fst_ps_ep11 == "0"

tab fst_sc_ep11 fst_ps_ep11 if snd_sc_ep11 == "-1" & snd_ps_ep11 == "0" //269 obs fst_ps_ep11 = 1 (?)

tab snd_sc_ep11 if fst_ps_ep11 == "1" & snd_ps_ep11 == "-1"
tab snd_sc_ep11 if fst_ps_ep11 == "0" & snd_ps_ep11 == "-1"

tab fst_ps_ep11 snd_ps_ep11, missing
//299 obs fst_ps_ep11 = 1, snd_ps_ep11 = 0
//309 obs fst_ps_ep11 = 1, snd_ps_ep11 = 1
tab fst_sc_ep11 snd_sc_ep11 if fst_ps_ep11 == "1" & snd_ps_ep11 == "0", missing
tab fst_sc_ep11 snd_sc_ep11 if fst_ps_ep11 == "1" & snd_ps_ep11 == "1", missing

save "data\dta\ep11_1082", replace
export delimited using "data\ep11_1082.csv", replace

//109_1_進修部(學校)學生成績名冊_補考成績
import delimited "data-raw\109_1_進修部(學校)學生成績名冊_補考成績.csv", bindquote(strict) stringcols(_all) clear

rename sch_year upl_ayr_ep11
rename semester upl_sem_ep11
rename book bk_nb_ep11
rename book_nm bk_ep11
rename sheet_nm sht_ep11
rename sch_cd sch_cd_ep11
rename sch_nm sch_ep11
rename 身分證號 id_nat_ep11

rename 課程代碼 crs_cd_ep11
rename 科目名稱 crs_ep11
rename 開課年級 stgr_ep11
rename 第一學期開設修課節數 fstsem_un_ep11
rename 第二學期開設修課節數 sndsem_un_ep11
rename 第一次補考成績 fst_sc_ep11
rename 第一次及格 fst_ps_ep11
rename 第二次補考成績 snd_sc_ep11
rename 第二次及格 snd_ps_ep11

/*改上傳學年度為西元年，並查看分布狀況*/
changeAD upl_ayr_ep11

/*合併學校代碼與學校名稱為學校名稱*/
replace sch_ep11 = sch_cd_ep11 + "_" + sch_ep11
drop sch_cd_ep11

tab sch_ep11
tab sch_ep11 if ustrregexm(sch_ep11, "進修") == 0 
//皆為進修

/*開課年級*/
tab stgr_ep11, missing

/*開設節數*/
tab fstsem_un_ep11, missing
tab sndsem_un_ep11, missing

/*第一次補考*/
destring fst_sc_ep11, replace
tab fst_sc_ep11 fst_ps_ep11, missing
tostring fst_sc_ep11, replace

changeBV fst_ps_ep11

/*第二次補考*/
destring snd_sc_ep11, replace
tab snd_sc_ep11 snd_ps_ep11, missing
tostring snd_sc_ep11, replace

//318 obs snd_sc_ep11 = -1
//8 obs snd_sc_ep11 = -1, snd_ps_ep11 = -1
//12 obs snd_sc_ep11 = -1, snd_ps_ep11 = 0
//298 obs snd_sc_ep11 = -1, snd_ps_ep11 = 1 (?)

/*第一與第二次補考*/
tab fst_sc_ep11 fst_ps_ep11 if snd_sc_ep11 == "-1" & snd_ps_ep11 == "0" //12 obs fst_ps_ep11 = 1 (?)

tab snd_sc_ep11 if fst_ps_ep11 == "1" & snd_ps_ep11 == "-1"
tab snd_sc_ep11 if fst_ps_ep11 == "0" & snd_ps_ep11 == "-1" //no obs

tab fst_ps_ep11 snd_ps_ep11, missing
//12 obs fst_ps_ep11 = 1, snd_ps_ep11 = 0
//39 obs fst_ps_ep11 = 1, snd_ps_ep11 = 1
tab fst_sc_ep11 snd_sc_ep11 if fst_ps_ep11 == "1" & snd_ps_ep11 == "0", missing
tab fst_sc_ep11 snd_sc_ep11 if fst_ps_ep11 == "1" & snd_ps_ep11 == "1", missing

save "data\dta\ep11_1091", replace
export delimited using "data\ep11_1091.csv", replace