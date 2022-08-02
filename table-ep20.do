import delimited "data-raw\108_0_學生自填多元表現名冊_競賽參與紀錄.csv", bindquote(strict) stringcols(1 2 3 6 11 15) maxquotedrows(100) clear

rename sch_year upl_ayr_ep20
rename semester upl_sem_ep20
rename book bk_nb_ep20
rename book_nm bk_ep20
rename sheet_nm sht_ep20
rename sch_cd sch_cd_ep20
rename sch_nm sch_ep20
rename 身分證號 id_nat_ep20

rename 競賽名稱 comp_ep20
rename 項目 grp_ep20
rename 競賽等級代碼 lv_ep20
rename 獎項 prz_ep20
rename 結果公布日期 rymd_ep20
rename 內容簡述 desc_ep20
rename 團體參與代碼 tm_ep20

/*改上傳學年度為西元年，並查看分布狀況*/
changeAD upl_ayr_ep20

/*合併學校代碼與學校名稱為學校名稱*/
replace sch_ep20 = sch_cd_ep20 + "_" + sch_ep20
drop sch_cd_ep20

tab sch_ep20
drop if sch_ep20 == "000B00_測試學校(進修部)"

/*競賽等級*/
tab lv_ep20, missing

/*將結果公布日期刪去上（下）午和時分秒*/
split rymd_ep20, parse(" ")
drop rymd_ep20 rymd_ep202 rymd_ep203
rename rymd_ep201 rymd_ep20
order rymd_ep20, after(prz_ep20)

/*轉換是否團體參加數值*/
changeBV tm_ep20
tab tm_ep20, missing

/*內容簡述前後加上 " " */
protect desc_ep20

save "data\dta\ep20", replace
export delimited using "data\ep20.csv", replace