//進修部
import delimited "data-raw\108_0_進修部(學校)學生課程學習成果名冊_借讀課程學習成果.csv", bindquote(strict) stringcols(1 2 3 9 10 11 14 15) clear

rename sch_year upl_ayr_ep18
rename semester upl_sem_ep18
rename book bk_nb_ep18
rename book_nm bk_ep18
rename sheet_nm sht_ep18
rename sch_cd sch_cd_ep18
rename sch_nm sch_ep18
rename 身分證號 id_nat_ep18

rename 借讀學校代碼 ts_sch_cd_ep18
rename 借讀修課學年度 ts_ayr_ep18
rename 借讀修課學期 ts_sem_ep18
rename 借讀校課程代碼 ts_crs_cd_ep18
rename 借讀校科目名稱 ts_crs_ep18
rename 借讀校開課年級 ts_stgr_ep18
rename 借讀校修課節數 ts_cr_ep18
rename 成果簡述 desc_ep18

/*文字描述前後加上 " " */
protect desc_ep18

save "data\dta\ep18_cedu", replace

//非進修部
import delimited "data-raw\108_0_學生課程學習成果名冊_借讀課程學習成果.csv", bindquote(strict) stringcols(1 2 3 6 9 10 11 14 15) clear 

rename sch_year upl_ayr_ep18
rename semester upl_sem_ep18
rename book bk_nb_ep18
rename book_nm bk_ep18
rename sheet_nm sht_ep18
rename sch_cd sch_cd_ep18
rename sch_nm sch_ep18
rename 身分證號 id_nat_ep18

rename 借讀學校代碼 ts_sch_cd_ep18
rename 借讀修課學年度 ts_ayr_ep18
rename 借讀修課學期 ts_sem_ep18
rename 借讀校課程代碼 ts_crs_cd_ep18
rename 借讀校科目名稱 ts_crs_ep18
rename 借讀校開課年級 ts_stgr_ep18
rename 借讀校修課學分 ts_cr_ep18
rename 成果簡述 desc_ep18

/*文字描述前後加上 " " */
protect desc_ep18

//合併進修與非進修部
append using "data\dta\ep18_cedu"
erase data\dta\ep18_cedu.dta

save "data\dta\ep18", replace
export delimited using "data\ep18.csv", replace