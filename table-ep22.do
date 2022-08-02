import delimited "data-raw\108_0_學生自填多元表現名冊_服務學習紀錄.csv", bindquote(strict) stringcols(1 2 3 6 13) clear

rename sch_year upl_ayr_ep22
rename semester upl_sem_ep22
rename book bk_nb_ep22
rename book_nm bk_ep22
rename sheet_nm sht_ep22
rename sch_cd sch_cd_ep22
rename sch_nm sch_ep22
rename 身分證號 id_nat_ep22

rename 服務名稱 svc_ep22
rename 服務單位 loc_ep22
rename 開始日期 stymd_ep22
rename 結束日期 edymd_ep22
rename 時數 hr_ep22
rename 內容簡述 desc_ep22

/*改上傳學年度為西元年，並查看分布狀況*/
changeAD upl_ayr_ep22

/*合併學校代碼與學校名稱為學校名稱*/
replace sch_ep22 = sch_cd_ep22 + "_" + sch_ep22
drop sch_cd_ep22

tab sch_ep22

/*將開始日期刪去上（下）午和時分秒*/
split stymd_ep22, parse(" ")
drop stymd_ep22 stymd_ep222 stymd_ep223
rename stymd_ep221 stymd_ep22
order stymd_ep22, after(loc_ep22)

/*將結束日期刪去上（下）午和時分秒*/
split edymd_ep22, parse(" ")
drop edymd_ep22 edymd_ep222 edymd_ep223
rename edymd_ep221 edymd_ep22
order edymd_ep22, after(stymd_ep22)

/*服務時數*/
tab hr_ep22, missing
list if hr_ep22 == "0.000" //308 obs

/*內容簡述前後加上 " " */
protect desc_ep22

save "data\dta\ep22", replace
export delimited using "data\ep22.csv", replace