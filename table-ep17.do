//進修部
import delimited "data-raw\108_0_進修部(學校)學生課程學習成果名冊_轉學轉科課程學習成果.csv", bindquote(strict) stringcols(1 2 3 9 10 11 14 15) clear

rename sch_year upl_ayr_ep17
rename semester upl_sem_ep17
rename book bk_nb_ep17
rename book_nm bk_ep17
rename sheet_nm sht_ep17
rename sch_cd sch_cd_ep17
rename sch_nm sch_ep17
rename 身分證號 id_nat_ep17

rename 原修課學校代碼 ori_sch_cd_ep17
rename 原修課學年度 ori_ayr_ep17
rename 原修課學期 ori_sem_ep17
rename 原修課課程代碼 ori_crs_cd_ep17
rename 原修課科目名稱 ori_crs_ep17
rename 原修課開課年級 ori_stgr_ep17
rename 原修課修課節數 ori_cr_ep17
rename 成果簡述 desc_ep17

/*改上傳學年度為西元年，並查看分布狀況*/
changeAD upl_ayr_ep17

/*合併學校代碼與學校名稱為學校名稱*/
replace sch_ep17 = sch_cd_ep17 + "_" + sch_ep17
drop sch_cd_ep17

tab sch_ep17

/*原修課學年度改西元年*/
changeAD ori_ayr_ep17

//原修課學年度須不大於上傳學年度
destring upl_ayr_ep17, replace
destring ori_ayr_ep17, replace
capture assert ori_ayr_ep17 <= upl_ayr_ep17 //True

tostring upl_ayr_ep17, replace
tostring ori_ayr_ep17, replace

/*文字描述前後加上 " " */
protect desc_ep17

save "data\dta\ep17_cedu", replace

//非進修部
import delimited "data-raw\108_0_學生課程學習成果名冊_轉學轉科課程學習成果.csv", bindquote(strict) stringcols(1 2 3 10 11 14 15) clear 

rename sch_year upl_ayr_ep17
rename semester upl_sem_ep17
rename book bk_nb_ep17
rename book_nm bk_ep17
rename sheet_nm sht_ep17
rename sch_cd sch_cd_ep17
rename sch_nm sch_ep17
rename 身分證號 id_nat_ep17

rename 原修課學校代碼 ori_sch_cd_ep17
rename 原修課學年度 ori_ayr_ep17
rename 原修課學期 ori_sem_ep17
rename 原修課課程代碼 ori_crs_cd_ep17
rename 原修課科目名稱 ori_crs_ep17
rename 原修課開課年級 ori_stgr_ep17
rename 原修課修課學分 ori_cr_ep17
rename 成果簡述 desc_ep17

/*改上傳學年度為西元年，並查看分布狀況*/
changeAD upl_ayr_ep17

/*合併學校代碼與學校名稱為學校名稱*/
replace sch_ep17 = sch_cd_ep17 + "_" + sch_ep17
drop sch_cd_ep17

tab sch_ep17

/*原修課學年度改西元年*/
changeAD ori_ayr_ep17

//原修課學年度須不大於上傳學年度
destring upl_ayr_ep17, replace
destring ori_ayr_ep17, replace
capture assert ori_ayr_ep17 <= upl_ayr_ep17 //True

tostring upl_ayr_ep17, replace
tostring ori_ayr_ep17, replace

/*文字描述前後加上 " " */
protect desc_ep17

//合併進修與非進修部
append using "data\dta\ep17_cedu"
erase data\dta\ep17_cedu.dta

save "data\dta\ep17", replace
export delimited using "data\ep17.csv", replace
