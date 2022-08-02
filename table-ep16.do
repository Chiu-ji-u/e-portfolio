import delimited "data-raw\108_0_學生課程學習成果名冊_重讀課程學習成果.csv", bindquote(strict) stringcols(_all) clear

rename sch_year upl_ayr_ep16
rename semester upl_sem_ep16
rename book bk_nb_ep16
rename book_nm bk_ep16
rename sheet_nm sht_ep16
rename sch_cd sch_cd_ep16
rename sch_nm sch_ep16
rename 身分證號 id_nat_ep16

rename 實際修課學期 actl_sem_ep16
rename 課程代碼 crs_cd_ep16
rename 科目名稱 crs_ep16
rename 開課年級 stgr_ep16
rename 修課學分 cr_ep16
rename 成果簡述 desc_ep16

drop sch_cd_ep16

/*創造實際修課學年度*/
gen actl_ayr_ep16 = upl_ayr_ep16
order actl_ayr_ep16, before(actl_sem_ep16)

/*文字描述前後加上 " */
protect desc_ep16

save "data\dta\ep16", replace
export delimited using "data\ep16.csv", replace