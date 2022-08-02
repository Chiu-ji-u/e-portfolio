//108_1_課程代碼
import excel "data-raw-excel\課程代碼(1081-1091).xlsx", sheet("1081") firstrow allstring clear

rename 學校代碼 sch_cd_ep4
rename 學年度 upl_ayr_ep4 
rename 學期 upl_sem_ep4
rename 課程代碼 crs_cd_ep4
rename 適用入學年度 ayr_appl_ep4
rename 開課年級 stgr_ep4
rename 修課學分 cr_ep4
rename 科目名稱 subj_ep4
rename 科目名稱代碼 subj_cd_ep4
rename 課程類型代碼 pgtyp_cd_ep4
rename 課程類型 pgtyp_ep4
rename 班群代碼 currtyp_cd_ep4
rename 班群 currtyp_ep4
rename 群別代碼 grp_cd_ep4
rename 群別 grp_ep4
rename 科別代碼 dep_cd_ep4
rename 科班學程別 dep_ep4
rename 課程類別代碼 crstyp_cd_ep4
rename 課程類別 crstyp_ep4
rename 開課方式代碼 enroltyp_cd_ep4
rename 開課方式 enroltyp_ep4
rename 科目屬性代碼 crsattr_cd_ep4 
rename 科目屬性 crsattr_ep4
rename 領域名稱代碼 fld_cd_ep4 
rename 領域名稱 fld_ep4
rename 學分轉換 cr_tr_ep4

order upl_ayr_ep4 upl_sem_ep4, before(sch_cd_ep4)
order pgtyp_cd_ep4 pgtyp_ep4 grp_cd_ep4 grp_ep4 dep_cd_ep4 dep_ep4 currtyp_cd_ep4 currtyp_ep4 crstyp_cd_ep4 crstyp_ep4 enroltyp_cd_ep4 enroltyp_ep4 crsattr_cd_ep4 crsattr_ep4 fld_cd_ep4 fld_ep4 subj_cd_ep4  subj_ep4 stgr_ep4 cr_ep4 cr_tr_ep4, after(ayr_appl_ep4)

/*改學年度與適用入學年度為西元年*/
changeAD upl_ayr_ep4
changeAD ayr_appl_ep4

/*去除測試值*/
drop if sch_cd_ep4 == "000000" | sch_cd_ep4 == "000001"| sch_cd_ep4 == "000005" | sch_cd_ep4 == "00000A"

save "data\dta\ep4_1081", replace

/*
/*產生學校代碼名稱對照表*/
use "data\dta\ep1_1081", clear
keep sch_ep1
split sch_ep1, parse(_)
drop sch_ep1
rename sch_ep11 sch_cd_ep4
rename sch_ep12 sch_nm_ep4
duplicates drop
save "data\dta\sch_1081", replace

/*與課程代碼合併*/
use "data\dta\ep4_1081", clear
merge m:1 sch_cd_ep4 using "data\dta\sch_1081"

tab sch_cd_ep4 if _merge == 1
drop if sch_cd_ep4 == "000000" | sch_cd_ep4 == "000001"| sch_cd_ep4 == "000005" | sch_cd_ep4 == "00000A"

tab sch_nm_ep4 if _merge == 2
*/

//108_2_課程代碼
import excel "data-raw-excel\課程代碼(1081-1091).xlsx", sheet("1082") firstrow allstring clear

rename 學校代碼 sch_cd_ep4
rename 學年度 upl_ayr_ep4 
rename 學期 upl_sem_ep4
rename 課程代碼 crs_cd_ep4
rename 適用入學年度 ayr_appl_ep4
rename 開課年級 stgr_ep4
rename 修課學分 cr_ep4
rename 科目名稱 subj_ep4
rename 科目名稱代碼 subj_cd_ep4
rename 課程類型代碼 pgtyp_cd_ep4
rename 課程類型 pgtyp_ep4
rename 班群代碼 currtyp_cd_ep4
rename 班群 currtyp_ep4
rename 群別代碼 grp_cd_ep4
rename 群別 grp_ep4
rename 科別代碼 dep_cd_ep4
rename 科班學程別 dep_ep4
rename 課程類別代碼 crstyp_cd_ep4
rename 課程類別 crstyp_ep4
rename 開課方式代碼 enroltyp_cd_ep4
rename 開課方式 enroltyp_ep4
rename 科目屬性代碼 crsattr_cd_ep4 
rename 科目屬性 crsattr_ep4
rename 領域名稱代碼 fld_cd_ep4 
rename 領域名稱 fld_ep4
rename 學分轉換 cr_tr_ep4

order upl_ayr_ep4 upl_sem_ep4, before(sch_cd_ep4)
order pgtyp_cd_ep4 pgtyp_ep4 grp_cd_ep4 grp_ep4 dep_cd_ep4 dep_ep4 currtyp_cd_ep4 currtyp_ep4 crstyp_cd_ep4 crstyp_ep4 enroltyp_cd_ep4 enroltyp_ep4 crsattr_cd_ep4 crsattr_ep4 fld_cd_ep4 fld_ep4 subj_cd_ep4  subj_ep4 stgr_ep4 cr_ep4 cr_tr_ep4, after(ayr_appl_ep4)

/*改學年度與適用入學年度為西元年*/
changeAD upl_ayr_ep4
changeAD ayr_appl_ep4

/*去除測試值*/
drop if sch_cd_ep4 == "000000" | sch_cd_ep4 == "000001"| sch_cd_ep4 == "000005" | sch_cd_ep4 == "00000A"

save "data\dta\ep4_1082", replace

/*
/*產生學校代碼名稱對照表*/
use "data\dta\ep1_1082", clear
keep sch_ep1
split sch_ep1, parse(_)
drop sch_ep1
rename sch_ep11 sch_cd_ep4
rename sch_ep12 sch_nm_ep4
duplicates drop
save "data\dta\sch_1082", replace

/*與課程代碼合併*/
use "data\dta\ep4_1082", clear
merge m:1 sch_cd_ep4 using "data\dta\sch_1082"

tab sch_cd_ep4 if _merge == 1
drop if sch_cd_ep4 == "000000" | sch_cd_ep4 == "000001"| sch_cd_ep4 == "000005" | sch_cd_ep4 == "00000A"

tab sch_nm_ep4 if _merge == 2
*/

//109_1_課程代碼
import excel "data-raw-excel\課程代碼(1081-1091).xlsx", sheet("1091") firstrow allstring clear

rename 學校代碼 sch_cd_ep4
rename 學年度 upl_ayr_ep4 
rename 學期 upl_sem_ep4
rename 課程代碼 crs_cd_ep4
rename 適用入學年度 ayr_appl_ep4
rename 開課年級 stgr_ep4
rename 修課學分 cr_ep4
rename 科目名稱 subj_ep4
rename 科目名稱代碼 subj_cd_ep4
rename 課程類型代碼 pgtyp_cd_ep4
rename 課程類型 pgtyp_ep4
rename 班群代碼 currtyp_cd_ep4
rename 班群 currtyp_ep4
rename 群別代碼 grp_cd_ep4
rename 群別 grp_ep4
rename 科別代碼 dep_cd_ep4
rename 科班學程別 dep_ep4
rename 課程類別代碼 crstyp_cd_ep4
rename 課程類別 crstyp_ep4
rename 開課方式代碼 enroltyp_cd_ep4
rename 開課方式 enroltyp_ep4
rename 科目屬性代碼 crsattr_cd_ep4 
rename 科目屬性 crsattr_ep4
rename 領域名稱代碼 fld_cd_ep4 
rename 領域名稱 fld_ep4
rename 學分轉換 cr_tr_ep4

order upl_ayr_ep4 upl_sem_ep4, before(sch_cd_ep4)
order pgtyp_cd_ep4 pgtyp_ep4 grp_cd_ep4 grp_ep4 dep_cd_ep4 dep_ep4 currtyp_cd_ep4 currtyp_ep4 crstyp_cd_ep4 crstyp_ep4 enroltyp_cd_ep4 enroltyp_ep4 crsattr_cd_ep4 crsattr_ep4 fld_cd_ep4 fld_ep4 subj_cd_ep4  subj_ep4 stgr_ep4 cr_ep4 cr_tr_ep4, after(ayr_appl_ep4)

/*改學年度與適用入學年度為西元年*/
changeAD upl_ayr_ep4
changeAD ayr_appl_ep4

/*去除測試值*/
drop if sch_cd_ep4 == "000000" | sch_cd_ep4 == "000001"| sch_cd_ep4 == "000005" | sch_cd_ep4 == "00000A"

save "data\dta\ep4_1091", replace

/*產生學校代碼名稱對照表*/
use "data\dta\ep1_1091", clear
keep sch_ep1
split sch_ep1, parse(_)
drop sch_ep1
rename sch_ep11 sch_cd_ep4
rename sch_ep12 sch_nm_ep4
duplicates drop
save "data\dta\sch_1091", replace

/*與課程代碼合併*/
use "data\dta\ep4_1091", clear
merge m:1 sch_cd_ep4 using "data\dta\sch_1091"

tab sch_cd_ep4 if _merge == 1
drop if sch_cd_ep4 == "000000" | sch_cd_ep4 == "000001"| sch_cd_ep4 == "000005" | sch_cd_ep4 == "00000A"

tab sch_nm_ep4 if _merge == 2


