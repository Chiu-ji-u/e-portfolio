import delimited "data-raw\108_0_學生課程學習成果名冊_重修課程學習成果.csv", bindquote(strict) stringcols(_all) clear 

rename sch_year upl_ayr_ep15
rename semester upl_sem_ep15
rename book bk_nb_ep15
rename book_nm bk_ep15
rename sheet_nm sht_ep15
rename sch_cd sch_cd_ep15
rename sch_nm sch_ep15
rename 身分證號 id_nat_ep15

rename 原修課學年度 ori_ayr_ep15
rename 原修課學期 ori_sem_ep15
rename 實際修課學期 actl_sem_ep15
rename 原修課課程代碼 ori_crs_cd_ep15
rename 原修課科目名稱 ori_crs_ep15
rename 原修課開課年級 ori_stgr_ep15
rename 原修課修課學分 ori_cr_ep15
rename 重修方式 typ_ep15
rename 成果簡述 desc_ep15

drop sch_cd_ep15

/*創造實際修課學年度*/
gen actl_ayr_ep15 = upl_ayr_ep15
order actl_ayr_ep15, before(actl_sem_ep15)

/*文字描述前後加上 " " */
protect desc_ep15

save "data\dta\ep15", replace
export delimited using "data\ep15.csv", replace