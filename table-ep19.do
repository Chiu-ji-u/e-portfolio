import delimited "data-raw\108_0_學生自填多元表現名冊_幹部經歷暨事蹟紀錄.csv", bindquote(strict) stringcols(1 2 3 14) clear 

rename sch_year upl_ayr_ep19
rename semester upl_sem_ep19
rename book bk_nb_ep19
rename book_nm bk_ep19
rename sheet_nm sht_ep19
rename sch_cd sch_cd_ep19
rename sch_nm sch_ep19
rename 身分證號 id_nat_ep19

rename 單位名稱 loc_ep19
rename 開始日期 stymd_ep19
rename 結束日期 edymd_ep19
rename 擔任職務 jb_ep19
rename 內容簡述 desc_ep19
rename 幹部等級 lv_ep19

/*改上傳學年度為西元年，並查看分布狀況*/
changeAD upl_ayr_ep19

/*合併學校代碼與學校名稱為學校名稱*/
replace sch_ep19 = sch_cd_ep19 + "_" + sch_ep19
drop sch_cd_ep19

tab sch_ep19
drop if sch_ep19 == "000B00_測試學校(進修部)"

/*將開始日期刪去上（下）午和時分秒*/
split stymd_ep19, parse(" ")
drop stymd_ep19 stymd_ep192 stymd_ep193
rename stymd_ep191 stymd_ep19
order stymd_ep19, after(loc_ep19)

/*將結束日期刪去上（下）午和時分秒*/
split edymd_ep19, parse(" ")
drop edymd_ep19 edymd_ep192 edymd_ep193
rename edymd_ep191 edymd_ep19
order edymd_ep19, after(stymd_ep19)

/*幹部等級*/
tab lv_ep19, missing

/*內容簡述前後加上 " " */
protect desc_ep19

save "data\dta\ep19", replace
export delimited using "data\ep19.csv", replace