//108_1_校內幹部經歷名冊_幹部經歷紀錄
import delimited "data-raw\108_1_校內幹部經歷名冊_幹部經歷紀錄.csv",  stringcols(1 2 3 6 13) clear

rename sch_year upl_ayr_ep3
rename semester upl_sem_ep3
rename book bk_nb_ep3
rename book_nm bk_ep3
rename sheet_nm sht_ep3
rename sch_cd sch_cd_ep3
rename sch_nm sch_ep3
rename 身分證號 id_nat_ep3

rename 單位名稱 loc_ep3
rename 開始日期 stymd_ep3
rename 結束日期 edymd_ep3
rename 擔任職務 jb_ep3
rename 幹部等級 lv_ep3

drop if sch_ep3 == "測試學校(進修部)"

/*改上傳學年度為西元年，並查看分布狀況*/
changeAD upl_ayr_ep3

/*合併學校代碼與學校名稱為學校名稱*/
replace sch_ep3 = sch_cd_ep3 + "_" + sch_ep3
drop sch_cd_ep3

/*開始日期刪去上（下）午和時分秒*/
split stymd_ep3, parse(" ")
drop  stymd_ep3  stymd_ep32  stymd_ep33
rename  stymd_ep31  stymd_ep3

/*結束日期格式刪去上（下）午和時分秒*/
split edymd_ep3, parse(" ")
drop  edymd_ep3  edymd_ep32  edymd_ep33
rename  edymd_ep31  edymd_ep3

order stymd_ep3 edymd_ep3, before(jb_ep3)

/*幹部等級*/
tab lv_ep3, missing //無不合理值，皆在1-3
tab jb_ep3, missing

save "data\dta\ep3_1081", replace
export delimited using "data\ep3_1081.csv", replace

//108_2_校內幹部經歷名冊_幹部經歷紀錄
import delimited "data-raw\108_2_校內幹部經歷名冊_幹部經歷紀錄.csv",  stringcols(1 2 3 6 13) bindquote(strict) clear

rename sch_year upl_ayr_ep3
rename semester upl_sem_ep3
rename book bk_nb_ep3
rename book_nm bk_ep3
rename sheet_nm sht_ep3 
rename sch_cd sch_cd_ep3
rename sch_nm sch_ep3
rename 身分證號 id_nat_ep3

rename 單位名稱 loc_ep3
rename 開始日期 stymd_ep3
rename 結束日期 edymd_ep3
rename 擔任職務 jb_ep3
rename 幹部等級 lv_ep3

drop if sch_ep3 == "測試學校(進修部)"
drop if sch_ep3 == "資科司"

/*改上傳學年度為西元年，並查看分布狀況*/
changeAD upl_ayr_ep3

/*合併學校代碼與學校名稱為學校名稱*/
replace sch_ep3 = sch_cd_ep3 + "_" + sch_ep3
drop sch_cd_ep3

/*開始日期刪去上（下）午和時分秒*/
split stymd_ep3, parse(" ")
drop  stymd_ep3  stymd_ep32  stymd_ep33
rename  stymd_ep31  stymd_ep3

/*結束日期格式刪去上（下）午和時分秒*/
split edymd_ep3, parse(" ")
drop  edymd_ep3  edymd_ep32  edymd_ep33
rename  edymd_ep31  edymd_ep3

order stymd_ep3 edymd_ep3, before(jb_ep3)

/*幹部等級*/
tab lv_ep3, missing //無不合理值，皆在1-3
tab jb_ep3, missing

save "data\dta\ep3_1082", replace
export delimited using "data\ep3_1082.csv", replace

//109_1_校內幹部經歷名冊_幹部經歷紀錄
import delimited "data-raw\109_1_校內幹部經歷名冊_幹部經歷紀錄.csv",  stringcols(1 2 3 6 13) bindquote(strict) clear

rename sch_year upl_ayr_ep3
rename semester upl_sem_ep3
rename book bk_nb_ep3
rename book_nm bk_ep3
rename sheet_nm sht_ep3 
rename sch_cd sch_cd_ep3
rename sch_nm sch_ep3
rename 身分證號 id_nat_ep3

rename 單位名稱 loc_ep3
rename 開始日期 stymd_ep3
rename 結束日期 edymd_ep3
rename 擔任職務 jb_ep3
rename 幹部等級 lv_ep3

drop if sch_ep3 == "測試學校(進修部)"
drop if sch_ep3 == "資科司"

/*改上傳學年度為西元年，並查看分布狀況*/
changeAD upl_ayr_ep3

/*合併學校代碼與學校名稱為學校名稱*/
replace sch_ep3 = sch_cd_ep3 + "_" + sch_ep3
drop sch_cd_ep3

/*開始日期刪去上（下）午和時分秒*/
split stymd_ep3, parse(" ")
drop  stymd_ep3  stymd_ep32  stymd_ep33
rename  stymd_ep31  stymd_ep3

/*結束日期格式刪去上（下）午和時分秒*/
split edymd_ep3, parse(" ")
drop  edymd_ep3  edymd_ep32  edymd_ep33
rename  edymd_ep31  edymd_ep3

order stymd_ep3 edymd_ep3, before(jb_ep3)

/*幹部等級*/
tab lv_ep3, missing //無不合理值，皆在1-3
tab jb_ep3, missing

save "data\dta\ep3_1091", replace
export delimited using "data\ep3_1091.csv", replace
