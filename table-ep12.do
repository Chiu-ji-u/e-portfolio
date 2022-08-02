//108_1_進修部(學校)學生成績名冊_轉學轉科成績
import delimited "data-raw\108_1_進修部(學校)學生成績名冊_轉學轉科成績.csv", bindquote(strict) stringcols(_all) clear

rename sch_year upl_ayr_ep12
rename semester upl_sem_ep12
rename book bk_nb_ep12
rename book_nm bk_ep12
rename sheet_nm sht_ep12
rename sch_cd sch_cd_ep12
rename sch_nm sch_ep12
rename 身分證號 id_nat_ep12

rename 對應學年度 cor_ayr_ep12
rename 對應學期 cor_sem_ep12
rename 課程代碼 crs_cd_ep12
rename 科目名稱 crs_ep12
rename 對應年級 cor_gr_ep12
rename 修課節數 un_ep12
rename 身分別 trftyp_ep12
rename 抵免後成績 wv_sc_ep12
rename 成績及格 ps_ep12
rename 是否採計學時 sc_ct_ep12
rename 質性文字描述 desc_ep12

drop sch_cd_ep12

/*文字描述前後加上 " " */
protect desc_ep12

save "data\dta\ep12_1081", replace
export delimited using "data\ep12_1081.csv", replace

//108_2_進修部(學校)學生成績名冊_轉學轉科成績
import delimited "data-raw\108_2_進修部(學校)學生成績名冊_轉學轉科成績.csv", bindquote(strict) stringcols(_all) clear

rename sch_year upl_ayr_ep12
rename semester upl_sem_ep12
rename book bk_nb_ep12
rename book_nm bk_ep12
rename sheet_nm sht_ep12
rename sch_cd sch_cd_ep12
rename sch_nm sch_ep12
rename 身分證號 id_nat_ep12

rename 對應學年度 cor_ayr_ep12
rename 對應學期 cor_sem_ep12
rename 課程代碼 crs_cd_ep12
rename 科目名稱 crs_ep12
rename 對應年級 cor_gr_ep12
rename 修課節數 un_ep12
rename 身分別 trftyp_ep12
rename 抵免後成績 wv_sc_ep12
rename 成績及格 ps_ep12
rename 是否採計學時 sc_ct_ep12
rename 質性文字描述 desc_ep12

/*改上傳學年度為西元年，並查看分布狀況*/
changeAD upl_ayr_ep12

/*合併學校代碼與學校名稱為學校名稱*/
replace sch_ep12 = sch_cd_ep12 + "_" + sch_ep12
drop sch_cd_ep12

tab sch_ep12
tab sch_ep12 if ustrregexm(sch_ep12, "進修") == 0 
//皆為進修

/*改對應學年度為西元年，並查看分布狀況*/
changeAD cor_ayr_ep12

/*查看對應年級、修課節數與轉學轉科身分別的分布狀況*/
tab cor_gr_ep12, missing
tab un_ep12, missing
tab trftyp_ep12, missing

/*將抵免後分數及格由True/False改為0/1*/
changeBV ps_ep12

/*抵免後分數*/
destring wv_sc_ep12, replace
tab wv_sc_ep12 ps_ep12, missing 
tab wv_sc_ep12 sc_ct_ep12, missing
//7 obs  wv_sc_ep12 = -1, ps_ep12 = 1, sc_ct_ep12 = 3
//10 obs wv_sc_ep12 = 0, ps_ep12 = 1, sc_ct_ep12 = 1
tostring wv_sc_ep12, replace

/*文字描述前後加上 " " */
protect desc_ep12

save "data\dta\ep12_1082", replace
export delimited using "data\ep12_1082.csv", replace

//109_1_進修部(學校)學生成績名冊_轉學轉科成績
import delimited "data-raw\109_1_進修部(學校)學生成績名冊_轉學轉科成績.csv", bindquote(strict) stringcols(_all) clear

rename sch_year upl_ayr_ep12
rename semester upl_sem_ep12
rename book bk_nb_ep12
rename book_nm bk_ep12
rename sheet_nm sht_ep12
rename sch_cd sch_cd_ep12
rename sch_nm sch_ep12
rename 身分證號 id_nat_ep12

rename 對應學年度 cor_ayr_ep12
rename 對應學期 cor_sem_ep12
rename 課程代碼 crs_cd_ep12
rename 科目名稱 crs_ep12
rename 對應年級 cor_gr_ep12
rename 修課節數 un_ep12
rename 身分別 trftyp_ep12
rename 抵免後成績 wv_sc_ep12
rename 成績及格 ps_ep12
rename 是否採計學時 sc_ct_ep12
rename 質性文字描述 desc_ep12

/*改上傳學年度為西元年，並查看分布狀況*/
changeAD upl_ayr_ep12

/*合併學校代碼與學校名稱為學校名稱*/
replace sch_ep12 = sch_cd_ep12 + "_" + sch_ep12
drop sch_cd_ep12

tab sch_ep12
tab sch_ep12 if ustrregexm(sch_ep12, "進修") == 0 
//皆為進修

/*改對應學年度為西元年，並查看分布狀況*/
changeAD cor_ayr_ep12

/*查看對應年級、修課節數與轉學轉科身分別的分布狀況*/
tab cor_gr_ep12, missing
tab un_ep12, missing
tab trftyp_ep12, missing

/*將抵免後分數及格由True/False改為0/1*/
changeBV ps_ep12

/*抵免後分數*/
destring wv_sc_ep12, replace
tab wv_sc_ep12 ps_ep12, missing 
tab wv_sc_ep12 sc_ct_ep12, missing
//4 obs  wv_sc_ep12 = -1, ps_ep12 = 0, sc_ct_ep12 = 3
//10 obs wv_sc_ep12 = 0, ps_ep12 = 1, sc_ct_ep12 = 1
tostring wv_sc_ep12, replace

/*文字描述前後加上 " " */
protect desc_ep12

save "data\dta\ep12_1091", replace
export delimited using "data\ep12_1091.csv", replace