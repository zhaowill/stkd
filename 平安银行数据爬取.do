clear all
cd "~/Documents/我的项目/stkdetail"
local stkcode = "000001"
copy "http://stockdata.stock.hexun.com/gszl/s`stkcode'.shtml" temp.txt, replace
if _rc != 0{
	di as error "请输入有效的股票代码！"
	exit 601
}
cap unicode encoding set gb18030
cap unicode translate temp.txt
cap unicode erasebackups, badidea
infix strL v 1-20000 using temp.txt, clear
keep if index(v, "<td") | index(v, `"<p class="text_x">"') | index(v, `"<h5 class="tit02">"') | index(v, "table cellspacing")
replace v  = ustrregexs(1) if ustrregexm(v, ">(.*)<")
replace v  = ustrregexs(1) if ustrregexm(v, ">(.*)<")
gen v1 = ""
replace v1 = v[_n+1] if mod(_n, 2) == 1
drop if v1 == ""
format v %-15s
format v1 %-25s
split v1 if index(v1, "<a href"), parse(</a> "_blank" >)
foreach i of varlist _all{
	levelsof `i', local(a)
	if ustrregexm(`a',"[\u4e00-\u9fa5]+") == 0 & "`i'" != "v" & "`i'" != "v1"{
		drop `i'
	}	
}
drop v11
replace v1 = ustrregexs(0) if ustrregexm(v1,"[\u4e00-\u9fa5]+") & index(v1, "<a href")
foreach i of varlist _all{
	replace `i' = subinstr(`i'," ","",.)
	if "`i'" != "v" & "`i'" != "v1"{
		format `i' %-8s
	}
}
replace v1 = "" if v1 == `"<tablecellspacing="0"cellpadding="0"class="tab_xtable">"'
replace v = "【基础信息】" if v == "基础信息"
replace v = "【工商信息】" if v == "工商信息"
replace v = "【经营范围】" if v == "经营范围"
replace v = "【联系方式】" if v == "联系方式"
replace v = "【证券信息】" if v == "证券信息"
replace v = "【公司简介】" if v == "公司简介"
compress
outfile using `stkcode'.txt, replace noq nol

forval i = 1/`=_N'{
	if v[`i'] == "公司简称"{
		global firmnme = v1[`i'] 
		di "$firmnme"
	}
}