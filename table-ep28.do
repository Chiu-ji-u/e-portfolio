import delimited "data-raw\108_0_學生自填多元表現名冊_其他多元表現紀錄.csv", bindquote(strict) stringcols(1 2 3 6 13) clear

rename sch_year upl_ayr_ep28
rename semester upl_sem_ep28
rename book bk_nb_ep28
rename book_nm bk_ep28
rename sheet_nm sht_ep28
rename sch_cd sch_cd_ep28
rename sch_nm sch_ep28
rename 身分證號 id_nat_ep28

rename 名稱 act_ep28
rename 主辦單位 loc_ep28
rename 開始日期 stymd_ep28
rename 結束日期 edymd_ep28
rename 時數 hr_ep28
rename 內容簡述 desc_ep28

/*改上傳學年度為西元年，並查看分布狀況*/
changeAD upl_ayr_ep28

/*合併學校代碼與學校名稱為學校名稱*/
replace sch_ep28 = sch_cd_ep28 + "_" + sch_ep28
drop sch_cd_ep28

tab sch_ep28

/*將開始日期刪去上（下）午和時分秒*/
split stymd_ep28, parse(" ")
drop stymd_ep28 stymd_ep282 stymd_ep283
rename stymd_ep281 stymd_ep28
order stymd_ep28, after(loc_ep28)

/*將結束日期刪去上（下）午和時分秒*/
split edymd_ep28, parse(" ")
drop edymd_ep28 edymd_ep282 edymd_ep283
rename edymd_ep281 edymd_ep28
order edymd_ep28, after(stymd_ep28)

/*活動名稱*/
count if act_ep28 == ""

/*主辦單位*/
count if loc_ep28 == ""
//11266 obs 沒有主辦單位

/*活動時數*/
destring hr_ep28, replace
tab hr_ep28, missing

tab act_ep28 if hr_ep28 == -1 //171 obs
//tab act_ep28 if hr_ep28 == 0 //43,008 obs
tostring hr_ep28, replace

/*內容簡述前後加上 " " */
protect desc_ep28

save "data\dta\ep28", replace
export delimited using "data\ep28.csv", replace