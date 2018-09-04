#!/bin/bash
#名稱		版本	日期		作者	備註
#prostock	v0.1	20180903	arthur	先抓資料：元大0050
STOCKTMP=/tmp/stock.tmp #暫存檔
STOCK_Q=/tmp/stock.q #暫存檔
curl -sk https://www.cnyes.com/twstock/Etfingredient/0050.htm > $STOCKTMP
grep 台泥 $STOCKTMP| sed 's/\/td>/\/td> \n /g' |sed 's/.htm.>/ @ /g' |sed 's/.*ofile.//g' |grep @ |sed 's/<.*>//g' > stock.q1
#欄轉列 #0905待處理(for loop)
cat stock.q1 |awk '{print $1}'|xargs
#取得關鍵字之前 1101.htm的資料，點進去後先抓成交價再塞csv檔令後續DB科科
# 0.Primary key 1.股票名稱	2.代號	3.收盤後成交價 4.當日最高 5.當日最低
# 待處理：塞進來的文字檔易於閱讀
stock_query(){
	Q=$QUERY
	curl -sk https://www.cnyes.com/twstock/Etfingredient/${Q}.htm > $STOCK_Q
}
#stock_query $QUERY
# cat stock.tmp |grep 台泥 | sed 's/\/td>/\/td> \n /g' |sed 's/.htm.>/ @ /g' |sed 's/.*ofile.//g' |grep @

