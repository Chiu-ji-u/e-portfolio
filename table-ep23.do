import delimited "data-raw\108_0_學生自填多元表現名冊_彈性學習時間紀錄.csv", bindquote(strict) varnames(1) maxquotedrows(100) stringcols(1 2 3 6 9 12 13 14 15) clear

rename sch_year upl_ayr_ep23
rename semester upl_sem_ep23
rename book bk_nb_ep23
rename book_nm bk_ep23
rename sheet_nm sht_ep23
rename sch_cd sch_cd_ep23
rename sch_nm sch_ep23
rename 身分證號 id_nat_ep23

rename 彈性學習時間類別種類代碼 typ_ep23
rename 內容開設名稱 altlrn_ep23
rename 開設單位 loc_ep23
rename 開設學年度 actl_ayr_ep23
rename 開設學期 actl_sem_ep23
rename 每週節數 unprwk_ep23
rename 開設週數 wk_ep23
rename 內容簡述 desc_ep23

/*改上傳學年度為西元年，並查看分布狀況*/
changeAD upl_ayr_ep23

/*合併學校代碼與學校名稱為學校名稱*/
replace sch_ep23 = sch_cd_ep23 + "_" + sch_ep23
drop sch_cd_ep23

tab sch_ep23

/*開設單位*/
tab loc_ep23, missing

/*改開設學年度為西元年，並查看分布狀況*/
changeAD actl_ayr_ep23

/*每周節數*/
tab wk_ep23, missing

/*開設週數*/
tab unprwk_ep23, missing  //575 obs 0 unit per week

/*內容簡述前後加上 " " */
protect desc_ep23

save "data\dta\ep23", replace
export delimited using "data\ep23.csv", replace