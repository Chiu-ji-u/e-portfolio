import delimited "data-raw\108_0_學生自填多元表現名冊_團體活動時間紀錄.csv", bindquote(strict) varnames(1) stringcols(1 2 3 6 9 12 13 14) clear

rename sch_year upl_ayr_ep24
rename semester upl_sem_ep24
rename book bk_nb_ep24
rename book_nm bk_ep24
rename sheet_nm sht_ep24
rename sch_cd sch_cd_ep24
rename sch_nm sch_ep24
rename 身分證號 id_nat_ep24

rename 團體活動時間類別代碼 typ_ep24
rename 辦理單位 loc_ep24
rename 團體活動內容名稱 tmact_ep24
rename 活動學年度 actl_ayr_ep24
rename 活動學期 actl_sem_ep24
rename 節數 un_ep24
rename 內容簡述 desc_ep24

/*改上傳學年度為西元年，並查看分布狀況*/
changeAD upl_ayr_ep24

/*合併學校代碼與學校名稱為學校名稱*/
replace sch_ep24 = sch_cd_ep24 + "_" + sch_ep24
drop sch_cd_ep24

tab sch_ep24

/*開設單位*/
tab loc_ep24, missing

/*改開設學年度為西元年，並查看分布狀況*/
changeAD actl_ayr_ep24

/*活動學期與節數*/
tab actl_sem_ep24, missing
destring un_ep24, replace
tab un_ep24, missing //somehow unreasonable values
sort un_ep24
tostring un_ep24, replace

/*內容簡述前後加上 " " */
protect desc_ep24 

save "data\dta\ep24", replace
export delimited using "data\ep24.csv", replace