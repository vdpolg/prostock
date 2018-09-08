#!/bin/bash
#名稱		版本	日期		作者	備註
#prostock	v0.1	20180903	arthur	先抓資料：元大0050
WRKDIR=$PWD
mkdir -p $WRKDIR/tmp
touch $WRKDIR/tmp/stock.tmp #暫存檔
STOCKTMP=$WRKDIR/tmp/stock.tmp
SOURCE='http://pchome.megatime.com.tw/group/mkt5/cidE002'
function SH(){ #Source Html 目前2個網頁
echo "${SOURCE}.html ${SOURCE}_02.html"
}
#模擬瀏覽器抓資料 (真的搞死我了)
function GSH(){ #Get Stock Html
curl -so $STOCKTMP $SOURCEHTML -H 'Connection: keep-alive' -H 'Cache-Control: max-age=0' -H 'Origin: http://stock.pchome.com.tw' -H 'Upgrade-Insecure-Requests: 1' -H 'Content-Type: application/x-www-form-urlencoded' -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8' -H 'Referer: http://stock.pchome.com.tw/set_cookie.php?is_need_login=0&key=YToyOntzOjI6Iml2IjtzOjg6IgT5OQmwQM%2AYIjtzOjU6ImNyeXB0IjtzOjE3NToifzOESkHPzaXvxDCS0fs95is2KIcSziFithgoGi1TNI2mIYtF2bqTCxb0ojCpWVzYD4o2OENxiCvCX%2AZCu7cduGHq9U1xCpKiOCim0aHfeDDlTT8bBM31xGEOVdXG2cXqoayOxfPKEvQJ_Q6xYoXs2JSY1df70tVkeQDFfK1JGjnfWK3zyl1T%2AuRSN4UtBFpNpmrjZOm96__mrP1OHgsE_Y31E_39V0MVqwdVBsumEiI7fQ%3D%3D' -H 'Accept-Encoding: gzip, deflate' -H 'Accept-Language: zh-TW,zh;q=0.9,en-US;q=0.8,en;q=0.7,zh-CN;q=0.6' -H 'Cookie: stock_user_uuid=6a6b14e8-1663-413c-bd2d-033f8019aad0; stock_popup_personalnews=1; stock_config=YToyOntzOjM6InRhZyI7aTozO3M6NDoidHlwZSI7aToyO30%3D' --data 'is_check=1' --compressed 
#抓台泥代號(4位數字)的網頁8欄資料，待整理股名、收盤價... 
grep -v "<p>" $STOCKTMP|grep -A8 "([0-9]\{1,4\})" > d1.tmp
#股名和代號
sed "s/.*ct.>//g" d1.tmp |sed "/:[0-9]/d"  | grep -A1 "(" > d2.tmp
sed '/--/d' d2.tmp |sed "s/^[0-9]/<\">/" > d3.tmp #刪grep 剩的-- ，並在數字前加<">
sed 's/<.*">//g' d3.tmp | sed "s/<\/span>.*>//g" > d4.tmp #刪股價後的data
sed "s/.(/,/g" d4.tmp |sed "s/).*>/,n/g" |xargs > d5.tmp #全弄成一行，分隔用,n
sed "s/,n. /,/g" d5.tmp | sed "s/[0-9]. / \n/g" > d6.tmp #再拆開
sed "s///g" d6.tmp | sed "s/　//g" > d7.tmp # 去除\^M(Ctrl+V & Ctrl+M)斷行符號,中文字空格
sed "s/^/'/g" d7.tmp |sed "s/^[^\D,]\{1,10\}/&'/g" |sed "s/ $//g" >> f8.tmp #中文字前後加''方便日後塞入db, 移除結尾的空白
cd $WRKDIR ; mv d* tmp/
}
AII() { #Add Insert Into
while IFS= read -r line; do
echo "insert into stock_main (stock_name,stock_num,done_price ) values ( $line"
done
}
> p10.tmp #清空舊資料
echo "抓資料中..."
for i in `SH`
do
SOURCEHTML=$i	
GSH
	done
cat f8.tmp | AII > f9.tmp # 塞db用的 insert into stock_main (stock_name,stock_num,done_price ) volumes ( 
sed "s/$/\);/g" f9.tmp > p10.tmp # 塞db用的 insert 的結尾
less p10.tmp # show stock
mv f*tmp tmp/ # 搬暫存檔，避免f8 重複執行多餘資料
# 待辦：塞DB
# 0.Primary key 1.股票名稱	2.代號	3.收盤後成交價 4.當日最高 5.當日最低 6.日期 (塞db)
# db快忘光光了
# db timestamp 要想辦法
# 匯出匯入db
# docker compose yml 寫法,db 一啟動就停止,3306port連入,volumes 外部掛載
