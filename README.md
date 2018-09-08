# prostock
<pre>
版本	日期			備註	作者:arthur    
v0.1	20180903  先抓資料：元大0050  
v0.2	20180904	初步能撈第17筆資料的股名、代號塞入stock.q1 、也能欄轉列				
v0.3	20180907	令curl 抓資料(模擬browser)後續待處理					
v0.4	20180908	第一頁抓取OK				
v0.5	20180908	去除中文字空格和^M斷行符號				
v0.6	20180908	用function處理				
v0.7	20180908	納入第二頁資料(真的剩塞DB了!!!!!!)
v0.8	20180908	令p10.tmp = insert db 格式資料(送啦！)
v0.9	20180909	修改重複執行時資料異常問題
</pre>
## 待辦：塞DB。
##### 用docker 掛MariaDB ,primary Key ,date,已有當日資料就不塞…
##### 0.Primary key 1.股票名稱  2.代號  3.收盤後成交價 4.當日最高 5.當日最低 6.日期 (塞db)
##### db快忘光光了
##### db timestamp 要想辦法
##### 匯出匯入db
##### docker compose yml 寫法,db 一啟動就停止,3306port連入,volumes 外部掛載
###### ref1: [sed:匹配和保存字串](http://man.linuxde.net/sed)
###### ref2: [文字檔前加入文字(塞db用的)](https://serverfault.com/questions/310098/how-to-add-a-timestamp-to-bash-script-log)
###### ref3: [README.md寫法](https://github.com/guodongxiaren/README#%E9%93%BE%E6%8E%A5)
###### ref4: [移除文字結尾的^M](https://blog.gtwang.org/tips/vim-ctrl-m/)
###### ref5: [curl模擬browser抓資料](https://blog.phpdr.net/%E5%A6%82%E4%BD%95%E7%94%A8curl%E6%A8%A1%E6%8B%9F%E6%B5%8F%E8%A7%88%E5%99%A8.html)
###### ref6: [mariadb docker](https://my.oschina.net/iluckyboy/blog/740661)
