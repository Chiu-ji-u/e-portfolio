import delimited "data-raw\108_0_學生自填多元表現名冊_檢定證照紀錄.csv", bindquote(strict) stringcols(1 2 3 6 10 11) maxquotedrows(100) clear

rename sch_year upl_ayr_ep21
rename semester upl_sem_ep21
rename book bk_nb_ep21
rename book_nm bk_ep21
rename sheet_nm sht_ep21
rename sch_cd sch_cd_ep21
rename sch_nm sch_ep21
rename 身分證號 id_nat_ep21

rename 證照代碼 cert_cd_ep21
rename 註1 typ1_ep21
rename 分數 totsc_ep21
rename 分項結果 subjsc_ep21
rename 取得證照日期 gtymd_ep21
rename 證照字號 nb_ep21
rename 檢定組別 grp_ep21
rename 內容簡述 desc_ep21

/*改上傳學年度為西元年，並查看分布狀況*/
changeAD upl_ayr_ep21

/*合併學校代碼與學校名稱為學校名稱*/
replace sch_ep21 = sch_cd_ep21 + "_" + sch_ep21
drop sch_cd_ep21

tab sch_ep21

/*證照類別*/
tab typ1_ep21, missing

/*證照總分*/
tab totsc_ep21, missing //43 obs totsc = -1，19069 obs totsc = 0

/*以雙引號保護各項目成績*/
protect subjsc_ep21

/*將取得證照日期刪去上（下）午和時分秒*/
split gtymd_ep21, parse(" ")
drop gtymd_ep21 gtymd_ep212 gtymd_ep213
rename gtymd_ep211 gtymd_ep21
order gtymd_ep21, after(subjsc_ep21)

/*內容簡述前後加上 " " */
protect desc_ep21

save "data\dta\ep21", replace

/*將證照代碼對照表的欄位重新命名並存成dta以便合併*/
import excel "data-raw-excel\證照代碼.xlsx", sheet("工作表1") firstrow allstring clear

rename 國內國外 for_ep21
rename 證照類別 typ2_ep21
rename 發照單位 loc_ep21
rename 證照名稱 nm_ep21
rename 級數分數 lv_ep21
rename 證照代碼 cert_cd_ep21

save "data\dta\ep21_cd", replace

use "data\dta\ep21", clear
merge m:1 cert_cd_ep21 using "data\dta\ep21_cd"

drop if _merge == 2
sort _merge
//有1 ob 證照代碼出錯應為4230，而非4286

/*調動變數順序*/
drop _merge
order nb_ep21, before(cert_cd_ep21)
order nm_ep21 for_ep21 loc_ep21, after(cert_cd_ep21)
order typ2_ep21 lv_ep21, after(typ1_ep21)

/*清除變數標籤*/
label variable nm_ep21 ""
label variable for_ep21 ""
label variable loc_ep21 ""
label variable typ2_ep21 ""
label variable lv_ep21 ""

save "data\dta\ep21", replace
export delimited using "data\ep21.csv", replace