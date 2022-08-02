import delimited "data-raw\108_0_學生自填多元表現名冊_作品成果紀錄.csv", bindquote(strict) varnames(1) maxquotedrows(100) stringcols(1 2 3) clear 

rename sch_year upl_ayr_ep26
rename semester upl_sem_ep26
rename book bk_nb_ep26
rename book_nm bk_ep26
rename sheet_nm sht_ep26
rename sch_cd sch_cd_ep26
rename sch_nm sch_ep26
rename 身分證號 id_nat_ep26

rename 名稱 pf_ep26
rename 日期 cpymd_ep26
rename 內容簡述 desc_ep26

/*改上傳學年度為西元年，並查看分布狀況*/
changeAD upl_ayr_ep26

/*合併學校代碼與學校名稱為學校名稱*/
replace sch_ep26 = sch_cd_ep26 + "_" + sch_ep26
drop sch_cd_ep26

tab sch_ep26

/*將完成或發表日期刪去上（下）午和時分秒*/
split cpymd_ep26, parse(" ")
drop cpymd_ep26 cpymd_ep262 cpymd_ep263
rename cpymd_ep261 cpymd_ep26
order cpymd_ep26, before(desc_ep26)

/*作品名稱*/
count if pf_ep26 == "" //0 obs 空值

/*內容簡述前後加上 " " */
protect desc_ep26

save "data\dta\ep26", replace
export delimited using "data\ep26.csv", replace