//進修部
import delimited "data-raw\108_0_進修部(學校)學生課程學習成果名冊_學期課程學習成果.csv", bindquote(strict) stringcols(_all) clear

rename sch_year upl_ayr_ep13
rename semester upl_sem_ep13
rename book bk_nb_ep13
rename book_nm bk_ep13
rename sheet_nm sht_ep13
rename sch_cd sch_cd_ep13
rename sch_nm sch_ep13
rename 身分證號 id_nat_ep13

rename 實際修課學期 actl_sem_ep13
rename 課程代碼 crs_cd_ep13
rename 科目名稱 crs_ep13
rename 開課年級 stgr_ep13
rename 修課節數 cr_ep13
rename 成果簡述 desc_ep13

/*改上傳學年度為西元年，並查看分布狀況*/
changeAD upl_ayr_ep13

/*合併學校代碼與學校名稱為學校名稱*/
replace sch_ep13 = sch_cd_ep13 + "_" + sch_ep13
drop sch_cd_ep13

tab sch_ep13

/*創造實際修課學年度*/
gen actl_ayr_ep13 = upl_ayr_ep13
order actl_ayr_ep13, before(actl_sem_ep13)

/*開課年級*/
tab stgr_ep13, missing

/*文字描述前後加上 " " */
protect desc_ep13 

save "data\dta\ep13_cedu", replace

//非進修部
import delimited "data-raw\108_0_學生課程學習成果名冊_學期課程學習成果.csv", bindquote(strict) stringcols(_all) maxquotedrows(100) clear

rename sch_year upl_ayr_ep13
rename semester upl_sem_ep13
rename book bk_nb_ep13
rename book_nm bk_ep13
rename sheet_nm sht_ep13
rename sch_cd sch_cd_ep13
rename sch_nm sch_ep13
rename 身分證號 id_nat_ep13

rename 實際修課學期 actl_sem_ep13
rename 課程代碼 crs_cd_ep13
rename 科目名稱 crs_ep13
rename 開課年級 stgr_ep13
rename 修課學分 cr_ep13
rename 成果簡述 desc_ep13

/*改上傳學年度為西元年，並查看分布狀況*/
changeAD upl_ayr_ep13

/*合併學校代碼與學校名稱為學校名稱*/
replace sch_ep13 = sch_cd_ep13 + "_" + sch_ep13
drop sch_cd_ep13

tab sch_ep13

/*創造實際修課學年度*/
gen actl_ayr_ep13 = upl_ayr_ep13
order actl_ayr_ep13, before(actl_sem_ep13)

/*開課年級*/
tab stgr_ep13, missing

/*文字描述前後加上 " " */
protect desc_ep13

//合併進修和非進修部
append using "data\dta\ep13_cedu"
erase data\dta\ep13_cedu.dta

save "data\dta\ep13", replace
export delimited using "data\ep13.csv", replace