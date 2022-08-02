import delimited "data-raw\108_0_學生課程學習成果名冊_補修課程學習成果.csv", bindquote(strict) stringcols(_all) clear 

rename sch_year upl_ayr_ep14
rename semester upl_sem_ep14
rename book bk_nb_ep14
rename book_nm bk_ep14
rename sheet_nm sht_ep14
rename sch_cd sch_cd_ep14
rename sch_nm sch_ep14
rename 身分證號 id_nat_ep14

rename 應修課學年度 skd_ayr_ep14
rename 應修課學期 skd_sem_ep14
rename 實際修課學期 actl_sem_ep14
rename 課程代碼 crs_cd_ep14
rename 科目名稱 crs_ep14
rename 開課年級 stgr_ep14
rename 修課學分 cr_ep14
rename 補修方式 typ_ep14
rename 成果簡述 desc_ep14

drop sch_cd_ep14

/*創造實際修課學年度*/
gen actl_ayr_ep14 = upl_ayr_ep14
order actl_ayr_ep14, before(actl_sem_ep14)

/*文字描述前後加上 "  */
protect desc_ep14

save "data\dta\ep14", replace
export delimited using "data\ep14.csv", replace