#!/bin/bash
#名稱		版本	日期		作者	備註
#prostock	v0.1	20180903	arthur	先抓資料：元大0050
WRKDIR=$PWD
mkdir -p $WRKDIR/tmp
STOCKTMP=$WRKDIR/tmp/stock.tmp #暫存檔
#STOCK_Q=$PWD/tmp/stock.s #暫存檔
echo "抓資料中..."
#模擬瀏覽器抓資料 (真的搞死我了)
curl -so $STOCKTMP 'http://pchome.megatime.com.tw/group/mkt5/cidE002.html' -H 'Connection: keep-alive' -H 'Cache-Control: max-age=0' -H 'Origin: http://stock.pchome.com.tw' -H 'Upgrade-Insecure-Requests: 1' -H 'Content-Type: application/x-www-form-urlencoded' -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8' -H 'Referer: http://stock.pchome.com.tw/set_cookie.php?is_need_login=0&key=YToyOntzOjI6Iml2IjtzOjg6IgT5OQmwQM%2AYIjtzOjU6ImNyeXB0IjtzOjE3NToifzOESkHPzaXvxDCS0fs95is2KIcSziFithgoGi1TNI2mIYtF2bqTCxb0ojCpWVzYD4o2OENxiCvCX%2AZCu7cduGHq9U1xCpKiOCim0aHfeDDlTT8bBM31xGEOVdXG2cXqoayOxfPKEvQJ_Q6xYoXs2JSY1df70tVkeQDFfK1JGjnfWK3zyl1T%2AuRSN4UtBFpNpmrjZOm96__mrP1OHgsE_Y31E_39V0MVqwdVBsumEiI7fQ%3D%3D' -H 'Accept-Encoding: gzip, deflate' -H 'Accept-Language: zh-TW,zh;q=0.9,en-US;q=0.8,en;q=0.7,zh-CN;q=0.6' -H 'Cookie: stock_user_uuid=6a6b14e8-1663-413c-bd2d-033f8019aad0; stock_popup_personalnews=1; stock_config=YToyOntzOjM6InRhZyI7aTozO3M6NDoidHlwZSI7aToyO30%3D' --data 'is_check=1' --compressed 
# 0.Primary key 1.股票名稱	2.代號	3.收盤後成交價 4.當日最高 5.當日最低 6.日期 (塞db)
#抓台泥代號(4位數字)的網頁8欄資料，待整理股名、收盤價... 
grep -v "<p>" $STOCKTMP|grep -A8 "([0-9]\{1,4\})" > d1.tmp
#股名和代號
#grep sid d1.tmp | awk -F '>' '{print $3}'|sed "s/)<\/a//g"|sed "s/ (/,/g" > d2.tmp
sed "s/.*ct.>//g" d1.tmp |sed "/:[0-9]/d"  | grep -A1 "(" > d2.tmp
#2395 首欄沒有< 問題待處理
