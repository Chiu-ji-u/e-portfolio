clear all
set more off
capture log close

cd C:/Users/chihyu.tsou/Desktop/EP_v1.0.0/

mkdir data/dta

/*changeAD 將上傳年改西元年*/
program define changeAD
   args `1'
   destring `1', replace
   replace `1' = `1' + 1911 if `1' != .
   tostring  `1', replace
   replace `1' = "" if `1' ==  "." 
   tab  `1', missing
end

/*changeBV 將(1, 2)或(True, False)轉換成(0,1)*/
program define changeBV
    replace `1' = "0" if `1' == "1" |  `1' == "False"
	replace `1' = "1" if `1' == "2" |  `1' == "True"
end

/*protect 前後加上 " "*/
program define protect
    replace `1' = ustrregexra(`1', `"""', `""""')
    replace `1' = ustrregexra(`1', `"'"', `"''"')
    replace `1' =  `"""' + `1' + `"""' if `1' != ""
end

do "program\table-ep1.do"
do "program\table-ep2.do"
do "program\table-ep3.do"
do "program\table-ep4.do"
do "program\table-ep5.do"
do "program\table-ep6.do"
do "program\table-ep7.do"
do "program\table-ep8.do"
do "program\table-ep9.do"
do "program\table-ep10.do"
do "program\table-ep11.do"
do "program\table-ep12.do"
do "program\table-ep13.do"
do "program\table-ep14.do"
do "program\table-ep15.do"
do "program\table-ep16.do"
do "program\table-ep17.do"
do "program\table-ep18.do"
do "program\table-ep19.do"
do "program\table-ep20.do"
do "program\table-ep21.do"
do "program\table-ep22.do"
do "program\table-ep23.do"
do "program\table-ep24.do"
do "program\table-ep25.do"
do "program\table-ep26.do"
do "program\table-ep27.do"
do "program\table-ep28.do"