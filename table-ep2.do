//108_1_學生資料名冊_學生借讀資料
import delimited "data-raw\108_1_學生資料名冊_學生借讀資料.csv", stringcols(_all) clear

rename sch_year upl_ayr_ep2
rename semester upl_sem_ep2
rename book bk_nb_ep2
rename book_nm bk_ep2
rename sheet_nm sht_ep2
rename sch_cd sch_cd_ep2
rename sch_nm sch_ep2
rename 身分證號 id_nat_ep2

rename 所屬學校代碼 ori_sch_cd_ep2
rename 借讀學校代碼 ts_sch_cd_ep2
rename 群別 ts_grp_ep2
rename 借讀科班學程別 ts_dep_ep2
rename 借讀代碼 ts_cd_ep2
rename 申請開始日期 stymd_ep2 
rename 申請結束日期 edymd_ep2

save "data\dta\ep2_1081", replace

//108_2_學生資料名冊_學生借讀資料
import delimited "data-raw\108_2_學生資料名冊_學生借讀資料.csv", stringcols(_all) clear

rename sch_year upl_ayr_ep2
rename semester upl_sem_ep2
rename book bk_nb_ep2
rename book_nm bk_ep2
rename sheet_nm sht_ep2
rename sch_cd sch_cd_ep2
rename sch_nm sch_ep2
rename 身分證號 id_nat_ep2

rename 所屬學校代碼 ori_sch_cd_ep2
rename 借讀學校代碼 ts_sch_cd_ep2
rename 群別 ts_grp_ep2
rename 借讀科班學程別 ts_dep_ep2
rename 借讀代碼 ts_cd_ep2
rename 申請開始日期 stymd_ep2 
rename 申請結束日期 edymd_ep2

save "data\dta\ep2_1082", replace

//109_1_學生資料名冊_學生借讀資料
import delimited "data-raw\109_1_學生資料名冊_學生借讀資料.csv", stringcols(_all) clear

rename sch_year upl_ayr_ep2
rename semester upl_sem_ep2
rename book bk_nb_ep2
rename book_nm bk_ep2
rename sheet_nm sht_ep2
rename sch_cd sch_cd_ep2
rename sch_nm sch_ep2
rename 身分證號 id_nat_ep2

rename 所屬學校代碼 ori_sch_cd_ep2
rename 借讀學校代碼 ts_sch_cd_ep2
rename 群別 ts_grp_ep2
rename 借讀科班學程別 ts_dep_ep2
rename 借讀代碼 ts_cd_ep2
rename 申請開始日期 stymd_ep2 
rename 申請結束日期 edymd_ep2

save "data\dta\ep2_1091", replace

//合併三學期學生借讀資料
use data\dta\ep2_1081, replace
append using data\dta\ep2_1082
append using data\dta\ep2_1091

save "data\dta\ep2", replace

//將合併完檔案刪除
local ep2_list: dir "data/dta" files "ep2_*.dta"
display `ep2_list'
foreach i in `ep2_list' {
    erase "data/dta/`i'"
}

export delimited using "data\ep2.csv", replace

