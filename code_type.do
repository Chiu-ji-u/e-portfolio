/*將學群代碼存成dta檔以便合併*/
import excel "program\code_type.xlsx", sheet("學群代碼") clear
rename A grp //unique key
rename B real_grp
save "program\grp_cd", replace

/*將科_班_學程別代碼存成dta檔以便合併*/
import excel "program\code_type.xlsx", sheet("科_班_學程別代碼") clear
rename A dep //unique key
rename B real_dep
save "program\dep_cd", replace

/*將特殊身分別存成dta檔以便合併*/
import excel "program\code_type.xlsx", sheet("特殊身分別") clear
gen C = A //多製作2個 unique key，因為預設3欄特殊身分別
gen D = A
rename A sttyp1  
rename C sttyp2
rename D sttyp3
rename B real_sttyp 
tostring sttyp?, replace
forvalues i = 1/3 {
	replace sttyp`i' = "" if sttyp`i' == "0"
}  //為一般生修正
save "program\sttyp_cd", replace

/*增設unique key，以便合併學生借讀資料*/
//use "program\grp_cd.dta", replace
//gen grp_ts = grp
//save "program\grp_cd", replace

//use "program\dep_cd.dta", replace
//gen dep_ts = dep
//save "program\dep_cd", replace

