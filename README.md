# prostock
<pre>
版本	日期		備註	作者:arthur    
v0.1	20180903 	先抓資料：元大0050  
v0.2	20180904	初步能撈第17筆資料的股名、代號塞入stock.q1 、也能欄轉列				
v0.3	20180907	令curl 抓資料(模擬browser)後續待處理					
v0.4	20180908	第一頁抓取OK				
v0.5	20180908	去除中文字空格和^M斷行符號				
v0.6	20180908	用function處理				
v0.7	20180908	納入第二頁資料(真的剩塞DB了!!!!!!)
v0.8	20180908	令p10.tmp = insert db 格式資料(送啦！)
v0.9	20180909	修改重複執行時資料異常問題(應該是網路不順造成…)
v1.0	20180909	產出文字檔可塞入db，但還是一堆待辦…
v1.1	20180909	ref9~16修改(待驗證),新增mariadb folder加入docker-compose.yml檔(也是搞死我)
v1.2	20180909	將date改為check_time，令查詢時間=塞入db時間。
v1.3	20180909	確定volumes掛載路徑和移除失效volume節省空間
v1.4	20180909	mv mairadb mariadb 字打錯了
v2.0	20180909	docker-compose啟動db時可匯入DB schema(開心!!) #ref21
v2.1	20180909	加入function VD驗證機制, 因為常常抓不到第一頁資料。
v2.2	20180909	新增import shell將資料寫入db ，但有亂碼中文字待處理。
v2.3	20180909	修正insert時中文亂碼問題(web和console都搞定了)
v2.3.1	20180909	mv manual readme, 移除多餘mysql.sql
v2.3.2	20180910	修正手機版Termux可匯出正確p10.tmp(xargs > d5.tmp 異常,改用sed合併) ref24
v2.4	20180910	嚴重錯誤,部份資料價格錯誤(從d3.tmp開始)(例107變07),sed 的"&"漏加 ref1
v2.4.1	20180911	修正f8.tmp 中文字斷字誤判
v2.4.2	20180912	塞price_main 資料(mariadb/readme)
v2.4.3	20180913	shell insert price_main (數據錯誤…這版不能用)
v2.4.4	20180914	fix price_main done_price error(又再一次搞死我) ref25~26
v2.5	20180915	create view 成長率排序
v2.5.1	20180915	修正README錯字,待調整win10 bash和win docker整合(起雞皮疙瘩的功能) ref27
v2.6	20180916	前端新增https的docker ref28~29
v2.6.1	20180917	"fix 小資股 done_price < 100 ,測試排程ok。" ref30
</pre>
> 待辦：
>> db password密碼加密
>>> 先處理2.5.1 功能實現
#### 使用方法
	1. 安裝docker & docker-compose
	1.1 [安裝MariaDB & Adminer client & Https Web ](./mariadb/readme) cd mariadb ; docker-compose up -d
	1.2 https://example.com (root/密碼)登入確認是否正常(網域和https
	2. 撈資料：./prostock.sh 
	3. 匯入資料：./import.sh
	4. 同1.2確認prostock_db 資料
###### ref1: [sed:匹配和保存字串](http://man.linuxde.net/sed)
###### ref2: [文字檔前加入文字(塞db用的)](https://serverfault.com/questions/310098/how-to-add-a-timestamp-to-bash-script-log)
###### ref3: [README.md寫法](https://github.com/guodongxiaren/README#%E9%93%BE%E6%8E%A5)
###### ref4: [移除文字結尾的^M](https://blog.gtwang.org/tips/vim-ctrl-m/)
###### ref5: [curl模擬browser抓資料](https://blog.phpdr.net/%E5%A6%82%E4%BD%95%E7%94%A8curl%E6%A8%A1%E6%8B%9F%E6%B5%8F%E8%A7%88%E5%99%A8.html)
###### ref6: [mariadb docker](https://my.oschina.net/iluckyboy/blog/740661)
###### ref7: [Mysql datetime](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-types.html)
###### ref8: [Mysql PK自動增加](https://dotblogs.com.tw/ianchiu28/2017/05/21/142523)
###### ref9: [Mysql 小數點](https://webcache.googleusercontent.com/search?q=cache:D8VaEgMszGgJ:https://n.sfs.tw/10266+&cd=1&hl=zh-TW&ct=clnk&gl=tw&client=firefox-b-ab)
###### ref10: [Mysql timestamp](https://mariadb.com/kb/en/library/timestamp/)
###### ref11: [Mysql 多筆insert](http://gn02214231.pixnet.net/blog/post/200632246-sql-insert-into)
###### ref12: [Mysql utf8mb4格式](http://ourmysql.com/archives/1402)
###### ref13: [docker Mysql TimeZone](https://hk.saowen.com/a/207e511282672f4a85600ed8225f8ed764fb5614180c652e377d6910d09d5ce8)
###### **ref14 快速刪除停用的container :** `docker rm $(docker ps -aq)`
###### ref15: [docker-compose volume1](https://docs.docker.com/compose/compose-file/#volume-configuration-reference)
###### ref16: [docker-compose volume2](http://www.netadmin.com.tw/article_print.aspx?sn=1712060002)
###### ref17: [docker remove 失效volume](https://medium.com/@toomore/%E9%97%9C%E6%96%BC%E6%88%91%E5%B8%B8%E7%94%A8%E7%9A%84-docker-%E5%B0%8F%E6%8F%90%E7%A4%BA-9a63efdbce20) `docker volume ls -qf dangling=true | xargs -r docker volume rm`
###### ref18: [docker 找到volume實體位置](https://ithelp.ithome.com.tw/articles/10192397) `docker inspect -f '{{.Mounts}}' <container id>`
###### ref19: [docker 找到volume實體位置2](https://julianchu.net/2016/04/19-docker.html) `docker volume inspect <volume id>`
###### **ref20: docker 掛載其他volume:** `docker run -d --name QQ --volumes-from <其他container id> <image id>`
###### ref21: [docker MariaDB匯入sql](https://stackoverflow.com/questions/43880026/import-data-sql-mysql-docker-container/43880563) 
###### ref22: [docker MariaDB修正中文亂碼](https://blog.csdn.net/u012410733/article/details/61619656)
###### ref23: [docker MariaDB修正中文亂碼置換檔案](https://stackoverflow.com/questions/46004648/how-to-setup-mysql-with-utf-8-using-docker-compose)
###### ref24: [sed 多行合併為一行(因有些環境xargs不支援^M斷行)](https://blog.csdn.net/hjxhjh/article/details/17264739) `sed ':a ; N;s/\n/ / ; t a ; ' <file>`
###### ref25: [SQL select into 、group by 、join的注意事項](https://stackoverflow.com/questions/9473718/getting-max-value-from-rows-and-joining-to-another-table)
###### ref26: [SQL insert into 注意別名](https://www.cnblogs.com/RoadGY/archive/2011/07/22/2114088.html)
###### ref27: [Windows 10的Ubuntu bash下run Docker](https://www.cnblogs.com/cloudapps/p/7800428.html)
###### ref28: [A fully automated HTTPS server powered by Nginx, Let's Encrypt and Docker](https://github.com/SteveLTN/https-portal)
###### ref29: [承上的設定檔參考](https://github.com/SteveLTN/https-portal/blob/master/examples/minimal/docker-compose.yml) `PRODUCTION: 'true'`
###### **ref30: 設定crontab:** `35 10-14 * * 1-5 cd /tmp/prostock; ./prostock.sh && ./import.sh`
