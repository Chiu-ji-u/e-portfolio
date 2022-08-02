import delimited "data-raw\108_0_學生自填多元表現名冊_大學及技專校院先修課程紀錄.csv", bindquote(strict) stringcols(1 2 3 14 15) clear 

rename sch_year upl_ayr_ep27
rename semester upl_sem_ep27
rename book bk_nb_ep27
rename book_nm bk_ep27
rename sheet_nm sht_ep27
rename sch_cd sch_cd_ep27
rename sch_nm sch_ep27
rename 身分證號 id_nat_ep27

rename 計畫專案 pln_ep27
rename 開設單位 loc_ep27
rename 課程名稱 ap_ep27
rename 開始日期 stymd_ep27
rename 結束日期 edymd_ep27
rename 學分數 cr_ep27
rename 總時數 hr_ep27
rename 內容簡述 desc_ep27

/*改上傳學年度為西元年，並查看分布狀況*/
changeAD upl_ayr_ep27

/*合併學校代碼與學校名稱為學校名稱*/
replace sch_ep27 = sch_cd_ep27 + "_" + sch_ep27
drop sch_cd_ep27

tab sch_ep27

/*轉換開始日期格式，民國年3碼，月日各2碼*/
split stymd_ep27, parse(" ")
drop stymd_ep27 stymd_ep272 stymd_ep273
rename stymd_ep271 stymd_ep27
order stymd_ep27, after(ap_ep27)

/*轉換結束日期格式，民國年3碼，月日各2碼*/
split edymd_ep27, parse(" ")
drop edymd_ep27 edymd_ep272 edymd_ep273
rename edymd_ep271 edymd_ep27
order edymd_ep27, after(stymd_ep27)

/*課程計畫、修課地點前後加上 " " */
protect pln_ep27
protect loc_ep27

/*學分數*/
tab cr_ep27, missing

/*修課總時數*/
tab hr_ep27, missing /*3 obs -1 hr, 683 obs 0 hr*/

/*內容簡述前後加上 " " */
protect desc_ep27

save "data\dta\ep27", replace
export delimited using "data\ep27.csv", replace