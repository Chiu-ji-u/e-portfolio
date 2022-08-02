import delimited "data-raw\108_0_學生自填多元表現名冊_職場學習紀錄.csv", bindquote(strict) varnames(1) stringcols(1 2 3 9 14) clear

rename sch_year upl_ayr_ep25
rename semester upl_sem_ep25
rename book bk_nb_ep25
rename book_nm bk_ep25
rename sheet_nm sht_ep25
rename sch_cd sch_cd_ep25
rename sch_nm sch_ep25
rename 身分證號 id_nat_ep25

rename 職場學習類別代碼 typ_ep25
rename 職場學習單位 loc_ep25
rename 職場學習職稱 pos_ep25
rename 開始日期 stymd_ep25
rename 結束日期 edymd_ep25
rename 時數 hr_ep25
rename 內容簡述 desc_ep25

/*改上傳學年度為西元年，並查看分布狀況*/
changeAD upl_ayr_ep25

/*合併學校代碼與學校名稱為學校名稱*/
replace sch_ep25 = sch_cd_ep25 + "_" + sch_ep25
drop sch_cd_ep25

tab sch_ep25

/*職場學習類別與職稱*/
tab typ_ep25, missing
tab pos_ep25, missing
tab pos_ep25 typ_ep25, missing

/*職場學習單位*/
tab loc_ep25, missing
protect loc_ep25

/*將開始日期刪去上（下）午和時分秒*/
split stymd_ep25, parse(" ")
drop stymd_ep25 stymd_ep252 stymd_ep253
rename stymd_ep251 stymd_ep25
order stymd_ep25, after(pos_ep25)

/*將結束日期刪去上（下）午和時分秒*/
split edymd_ep25, parse(" ")
drop edymd_ep25 edymd_ep252 edymd_ep253
rename edymd_ep251 edymd_ep25
order edymd_ep25, after(stymd_ep25)

/*參與時數*/
tab hr_ep25, missing //15 obs -1 hr, 2,176 obs 0 hr

/*內容簡述前後加上 " " */
protect desc_ep25

save "data\dta\ep25", replace
export delimited using "data\ep25.csv", replace