//108_1_學生成績名冊_學期成績
import delimited "data-raw\108_1_學生成績名冊_學期成績.csv", bindquote(strict) stringcols(_all) clear

rename sch_year upl_ayr_ep5
rename semester upl_sem_ep5
rename book bk_nb_ep5
rename book_nm bk_ep5
rename sheet_nm sht_ep5
rename sch_cd sch_cd_ep5
rename sch_nm sch_ep5
rename 身分證號 id_nat_ep5

rename 課程代碼 crs_cd_ep5
rename 科目名稱 crs_ep5
rename 開課年級 stgr_ep5
rename 修課學分 cr_ep5
rename 學期學業成績 sc_ep5
rename 成績及格 ps_ep5
rename 補考成績 me_sc_ep5
rename 補考及格 me_ps_ep5
rename 是否採計學分 sc_ct_ep5
rename 質性文字描述 desc_ep5

/*改上傳學年度為西元年，並查看分布狀況*/
changeAD upl_ayr_ep5

/*合併學校代碼與學校名稱為學校名稱*/
replace sch_ep5 = sch_cd_ep5 + "_" + sch_ep5
drop sch_cd_ep5

tab sch_ep5
drop if sch_ep1 == "000000_測試高中" | sch_ep1 == "000001_國教署" | sch_ep1 == "000B00_測試學校(進修部)" | sch_ep1 == "000005_資科司"
tab sch_ep5 if ustrregexm(sch_ep5, "進修部") == 1 
//8915 obs 進修部, but shouldn't they be in ep10_1081?

/*開課年級*/
tab stgr_ep5, missing

/*修課學分*/
tab cr_ep5, missing
tab crs_ep5 if cr_ep5 == "0"
//暨大說團體活動時間和彈性學習時間會從成績名冊剔除？
tab crs_ep5 if ustrregexm(crs_ep5, "彈性") == 1 | ustrregexm(crs_ep5, "團體") == 1, missing
tab crs_ep5 cr_ep5 if (ustrregexm(crs_ep5, "彈性") == 1 | ustrregexm(crs_ep5, "團體") == 1) & cr_ep5 != "0", missing
//9423 obs 彈性學習時間和團體活動時間有學分

tab crs_ep5 if  (ustrregexm(crs_ep5, "彈性") == 1 | ustrregexm(crs_ep5, "團體") == 1) & (ustrpos(crs_cd_ep5, "9", 17) == 17 & ustrpos(crs_cd_ep5, "D", 19) == 19) & cr_ep5 != "0", missing
//有 4642 obs 符合規定 (9+D)

tab crs_ep5 cr_ep5 if (ustrregexm(crs_ep5, "彈性") == 1 | ustrregexm(crs_ep5, "團體") == 1) & (ustrpos(crs_cd_ep5, "9", 17) != 17 | ustrpos(crs_cd_ep5, "D", 19) != 19) & cr_ep5 != "0", missing
//4781 obs 不合規定，名字直接是團體活動時間、 彈性學習時間

tab sch_ep5 crs_ep5 if (ustrregexm(crs_ep5, "彈性") == 1 | ustrregexm(crs_ep5, "團體") == 1) & (ustrpos(crs_cd_ep5, "9", 17) != 17 | ustrpos(crs_cd_ep5, "D", 19) != 19) & cr_ep5 != "0", missing
//看看這4781 obs來自那些學校

tab crs_ep5 if cr_ep5 == "T"
tab sch_ep5 if cr_ep5 == "T"
//115 obs T學分，基礎訓練，秀水高中

/*學期學業成績、分數及格*/
destring sc_ep5, replace
changeBV ps_ep5
tab sc_ep5 ps_ep5, missing

tab sc_ep5 ps_ep5 if (ustrregexm(crs_ep5, "彈性") != 1 & ustrregexm(crs_ep5, "團體") != 1) |  ((ustrregexm(crs_ep5, "彈性") == 1 | ustrregexm(crs_ep5, "團體") == 1) & (ustrpos(crs_cd_ep5, "9", 17) == 17 & ustrpos(crs_cd_ep5, "D", 19) == 19) & cr_ep5 != "0"), missing
//把不合規定的彈性學習時間去掉，還是有42 obs 0分但過了

tab crs_ep5 if sc_ep5 == 0 & ps_ep5 == "1"

tostring sc_ep5, replace

/*補考成績、補考及格*/
destring me_sc_ep5, replace
tab me_sc_ep5 me_ps_ep5, missing 
//4 obs 0 分，沒有成績，120 obs 0 分但過了

tab me_sc_ep5 me_ps_ep5 if ps_ep5 == "1"
//11264 obs 已經過了還來考補考
//65 obs 0分沒過，120 obs 0分過了，5397 obs 1 分過了，5410 obs 60分過了

tab sch_ep5 if me_sc_ep5 != -1 & ps_ep5 == "1"
//看看這11264 obs來自那些學校
tostring me_sc_ep5, replace 

/*分數是否列入計算*/
tab sc_ct_ep5, missing
tab sc_ct_ep5 if ustrregexm(crs_ep5, "彈性") == 1 | ustrregexm(crs_ep5, "團體") == 1, missing
//5121 obs 為1，25758 obs 為2，10111 obs 為3

tab sch_ep5 if sc_ct_ep5 == "1" & (ustrregexm(crs_ep5, "彈性") == 1 | ustrregexm(crs_ep5, "團體") == 1), missing
tab sch_ep5 if sc_ct_ep5 == "2" & (ustrregexm(crs_ep5, "彈性") == 1 | ustrregexm(crs_ep5, "團體") == 1), missing
tab sch_ep5 if sc_ct_ep5 == "3" & (ustrregexm(crs_ep5, "彈性") == 1 | ustrregexm(crs_ep5, "團體") == 1), missing
 
/*文字描述前後加上 " " */
protect desc_ep5

save "data\dta\ep5_1081", replace
export delimited using "data\ep5_1081.csv", replace

//108_2_學生成績名冊_學期成績
import delimited "data-raw\108_2_學生成績名冊_學期成績.csv", bindquote(strict) stringcols(_all) clear

rename sch_year upl_ayr_ep5
rename semester upl_sem_ep5
rename book bk_nb_ep5
rename book_nm bk_ep5
rename sheet_nm sht_ep5
rename sch_cd sch_cd_ep5
rename sch_nm sch_ep5
rename 身分證號 id_nat_ep5

rename 課程代碼 crs_cd_ep5
rename 科目名稱 crs_ep5
rename 開課年級 stgr_ep5
rename 修課學分 cr_ep5
rename 學期學業成績 sc_ep5
rename 成績及格 ps_ep5
rename 補考成績 me_sc_ep5
rename 補考及格 me_ps_ep5
rename 是否採計學分 sc_ct_ep5
rename 質性文字描述 desc_ep5

/*改上傳學年度為西元年，並查看分布狀況*/
changeAD upl_ayr_ep5

/*合併學校代碼與學校名稱為學校名稱*/
replace sch_ep5 = sch_cd_ep5 + "_" + sch_ep5
drop sch_cd_ep5

tab sch_ep5
drop if sch_ep5 == "000000_測試高中" | sch_ep5 == "000001_國教署" | sch_ep5 == "000B00_測試學校(進修部)" | sch_ep5 == "000005_資科司"
tab sch_ep5 if ustrregexm(sch_ep5, "進修部") == 1 
//7747 obs 進修部, but shouldn't they be in ep10_1082?

/*開課年級*/
tab stgr_ep5, missing

/*修課學分*/
tab cr_ep5, missing
tab crs_ep5 if cr_ep5 == "0"
//暨大說團體活動時間和彈性學習時間會從成績名冊剔除？
tab crs_ep5 cr_ep5 if (ustrregexm(crs_ep5, "彈性") == 1 | ustrregexm(crs_ep5, "團體") == 1) & cr_ep5 != "0", missing
//11494 obs 彈性學習時間和團體活動時間有學分

tab crs_ep5 if  (ustrregexm(crs_ep5, "彈性") == 1 | ustrregexm(crs_ep5, "團體") == 1) & (ustrpos(crs_cd_ep5, "9", 17) == 17 & ustrpos(crs_cd_ep5, "D", 19) == 19) & cr_ep5 != "0", missing
//有 4225 obs 符合規定 (9+D)

tab crs_ep5 cr_ep5 if (ustrregexm(crs_ep5, "彈性") == 1 | ustrregexm(crs_ep5, "團體") == 1) & (ustrpos(crs_cd_ep5, "9", 17) != 17 | ustrpos(crs_cd_ep5, "D", 19) != 19) & cr_ep5 != "0", missing
//7269 obs 不合規定，名字直接是團體活動時間、 彈性學習時間

tab sch_ep5 crs_ep5 if (ustrregexm(crs_ep5, "彈性") == 1 | ustrregexm(crs_ep5, "團體") == 1) & (ustrpos(crs_cd_ep5, "9", 17) != 17 | ustrpos(crs_cd_ep5, "D", 19) != 19) & cr_ep5 != "0", missing
//看看這7269 obs來自那些學校

/*學期學業成績和分數及格*/
destring sc_ep5, replace
changeBV ps_ep5
tab sc_ep5 ps_ep5, missing

tab sc_ep5 ps_ep5 if (ustrregexm(crs_ep5, "彈性") != 1 & ustrregexm(crs_ep5, "團體") != 1) |  ((ustrregexm(crs_ep5, "彈性") == 1 | ustrregexm(crs_ep5, "團體") == 1) & (ustrpos(crs_cd_ep5, "9", 17) == 17 & ustrpos(crs_cd_ep5, "D", 19) == 19) & cr_ep5 != "0"), missing

tab crs_ep5 if sc_ep5 == 0 & ps_ep5 == "1"
//把不合規定的彈性學習時間去掉，還是有42 obs 0分但過了

tostring sc_ep5, replace

/*補考成績、補考及格*/
destring me_sc_ep5, replace
tab me_sc_ep5 me_ps_ep5, missing
//1 obs 補考 0 分標成沒有成績，12 obs 卻過了
//2 obs 60 分標成沒有成績，4 obs 卻沒過

tab me_sc_ep5 me_ps_ep5 if ps_ep5 == "1" 
//5018 obs 過了還來補考

tab sc_ep5 me_sc_ep5 if ps_ep5 == "1" & me_sc_ep5 != -1 //會過了還來補考的，有可能是因為雖然已過及格基準分數，但仍低於60分，想再考高一點
//但還是有10 obs本來就比60分還高，卻還來補考 

tab sch_ep5 if me_sc_ep5 != -1 & ps_ep5 == "1"
//看看這5018 obs來自那些學校
tostring me_sc_ep5, replace 

/*分數是否列入計算*/
tab sc_ct_ep5, missing
tab sc_ct_ep5 if ustrregexm(crs_ep5, "彈性") == 1 | ustrregexm(crs_ep5, "團體") == 1, missing
//4497 obs 為1，27217 obs 為2，11695 obs 為3

tab sc_ct_ep5 if (ustrregexm(crs_ep5, "彈性") == 1 | ustrregexm(crs_ep5, "團體") == 1) & (ustrpos(crs_cd_ep5, "9", 17) != 17 | ustrpos(crs_cd_ep5, "D", 19) != 19) & cr_ep5 != "0", missing
//不合規定的彈性與團體 866 obs 為1，3375 obs 為2，3028 obs 為3

tab sch_ep5 if sc_ct_ep5 == "1" &  (ustrregexm(crs_ep5, "彈性") == 1 | ustrregexm(crs_ep5, "團體") == 1) & (ustrpos(crs_cd_ep5, "9", 17) != 17 | ustrpos(crs_cd_ep5, "D", 19) != 19) & cr_ep5 != "0", missing
tab sch_ep5 if sc_ct_ep5 == "2" &  (ustrregexm(crs_ep5, "彈性") == 1 | ustrregexm(crs_ep5, "團體") == 1) & (ustrpos(crs_cd_ep5, "9", 17) != 17 | ustrpos(crs_cd_ep5, "D", 19) != 19) & cr_ep5 != "0", missing
tab sch_ep5 if sc_ct_ep5 == "3" &  (ustrregexm(crs_ep5, "彈性") == 1 | ustrregexm(crs_ep5, "團體") == 1) & (ustrpos(crs_cd_ep5, "9", 17) != 17 | ustrpos(crs_cd_ep5, "D", 19) != 19) & cr_ep5 != "0", missing

/*文字描述前後加上 " " */
protect desc_ep5

save "data\dta\ep5_1082", replace
export delimited using "data\ep5_1082.csv", replace

//109_1_學生成績名冊_學期成績
import delimited "data-raw\109_1_學生成績名冊_學期成績.csv", bindquote(strict) stringcols(_all) clear

rename sch_year upl_ayr_ep5
rename semester upl_sem_ep5
rename book bk_nb_ep5
rename book_nm bk_ep5
rename sheet_nm sht_ep5
rename sch_cd sch_cd_ep5
rename sch_nm sch_ep5
rename 身分證號 id_nat_ep5

rename 課程代碼 crs_cd_ep5
rename 科目名稱 crs_ep5
rename 開課年級 stgr_ep5
rename 修課學分 cr_ep5
rename 學期學業成績 sc_ep5
rename 成績及格 ps_ep5
rename 補考成績 me_sc_ep5
rename 補考及格 me_ps_ep5
rename 是否採計學分 sc_ct_ep5
rename 質性文字描述 desc_ep5

/*改上傳學年度為西元年，並查看分布狀況*/
changeAD upl_ayr_ep5

/*合併學校代碼與學校名稱為學校名稱*/
replace sch_ep5 = sch_cd_ep5 + "_" + sch_ep5
drop sch_cd_ep5

tab sch_ep5
drop if sch_ep5 == "000000_測試高中" | sch_ep5 == "000001_國教署" | sch_ep5 == "000B00_測試學校(進修部)" | sch_ep5 == "000005_資科司"
tab sch_ep5 if ustrregexm(sch_ep5, "進修部") == 1 
//15423 obs 進修部, but shouldn't they be in ep10_1091?

/*開課年級*/
tab stgr_ep5, missing

/*修課學分*/
tab cr_ep5, missing
tab crs_ep5 if cr_ep5 == "0" //normal 沒有無學分的彈性學習時間和團體活動時間

tab crs_ep5 cr_ep5 if (ustrregexm(crs_ep5, "彈性") == 1 | ustrregexm(crs_ep5, "團體") == 1) & cr_ep5 != "0", missing
//13531 obs 彈性學習時間和團體活動時間有學分

tab crs_ep5 if  (ustrregexm(crs_ep5, "彈性") == 1 | ustrregexm(crs_ep5, "團體") == 1) & (ustrpos(crs_cd_ep5, "9", 17) == 17 & ustrpos(crs_cd_ep5, "D", 19) == 19) & cr_ep5 != "0", missing
//有 13462 obs 符合規定 (9+D)

tab crs_ep5 cr_ep5 if (ustrregexm(crs_ep5, "彈性") == 1 | ustrregexm(crs_ep5, "團體") == 1) & (ustrpos(crs_cd_ep5, "9", 17) != 17 | ustrpos(crs_cd_ep5, "D", 19) != 19) & cr_ep5 != "0", missing
//69 obs 不合規定，兩門課團體膳食製作實習、團體膳食規劃

tab sch_ep5 crs_ep5 if (ustrregexm(crs_ep5, "彈性") == 1 | ustrregexm(crs_ep5, "團體") == 1) & (ustrpos(crs_cd_ep5, "9", 17) != 17 | ustrpos(crs_cd_ep5, "D", 19) != 19)
//111427_私立育德工家：團體膳食製作實習
//121417_私立高苑工商：團體膳食規劃

/*學期學業成績和分數及格*/
destring sc_ep5, replace
changeBV ps_ep5
tab sc_ep5 ps_ep5, missing

tab sc_ep5 ps_ep5  if (ustrregexm(crs_ep5, "彈性") != 1 & ustrregexm(crs_ep5, "團體") != 1) |  ((ustrregexm(crs_ep5, "彈性") == 1 | ustrregexm(crs_ep5, "團體") == 1) & (ustrpos(crs_cd_ep5, "9", 17) == 17 & ustrpos(crs_cd_ep5, "D", 19) == 19) & cr_ep5 != "0"), missing

tab crs_ep5 if sc_ep5 == 0 & ps_ep5 == "1"
//59 obs 0分但過了
tostring sc_ep5, replace

/*補考成績、補考及格*/
destring me_sc_ep5, replace
tab me_sc_ep5 me_ps_ep5, missing
//1 obs 補考 0 分標成沒有成績，23 obs 卻過了
//1 obs 60 分標成沒有成績，29 obs 卻沒過

tab me_sc_ep5 me_ps_ep5 if ps_ep5 == "1" 
//224 obs 過了還來補考

tab me_sc_ep5 sc_ep5 if ps_ep5 == "1" & me_sc_ep5 != -1
//推測會過了還來補考的，有可能是因為雖然已過及格基準分數，但仍低於60分，想再考高一點

destring sc_ep5, replace
tab sc_ep5 me_sc_ep5 if ps_ep5 == "1" & me_sc_ep5 != -1 & sc_ep5 >= 60 & sc_ep5 > me_sc_ep5
//但是 149 obs 本來就比60分還高，卻還來補考
//裡面有 89 obs 考得比原本的分數還爛
tab sc_ep5 me_sc_ep5 if ps_ep5 == "1" & me_sc_ep5 != -1 & sc_ep5 >= 60 & sc_ep5 > me_sc_ep5 & me_ps_ep5 == "0"
//其中 42 obs 反而補考沒過
//那這樣是過還是不過

//不看60分的話
tab sc_ep5 me_sc_ep5 if ps_ep5 == "1" & me_sc_ep5 != -1 & sc_ep5 > me_sc_ep5
//但是 149 obs 本來就比60分還高，卻還來補考
//裡面有 89 obs 考得還比原本分數還爛
tab sc_ep5 me_sc_ep5 if ps_ep5 == "1" & me_sc_ep5 != -1 & sc_ep5 >= 60 & sc_ep5 > me_sc_ep5 & me_ps_ep5 == "0"
//其中 42 obs 反而補考沒過
//那這樣是過還是不過

tab sch_ep5 if me_sc_ep5 != -1 & ps_ep5 == "1"
//看看這224 obs來自那些學校
tostring me_sc_ep5, replace

/*分數是否列入計算*/
tab sc_ct_ep5, missing
tab sc_ct_ep5 if (ustrregexm(crs_ep5, "彈性") == 1 | ustrregexm(crs_ep5, "團體") == 1) & (ustrpos(crs_cd_ep5, "9", 17) != 17 | ustrpos(crs_cd_ep5, "D", 19) != 19)
// 69 個不合規定的 obs 

/*文字描述前後加上 " " */
protect desc_ep5

save "data\dta\ep5_1091", replace
export delimited using "data\ep5_1091.csv", replace
