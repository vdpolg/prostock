# prostock
#名稱           版本    日期            作者    備註
#prostock       v0.1    20180903        arthur  先抓資料：元大0050
#prostock       v0.2	20180904				初步能撈第17筆資料的股名、代號塞入stock.q1 、也能欄轉列
												待處理for loop 
<pre>

        # </td> 結尾變斷行          # 股票代號和股名中間改@分隔 	#代號前的字清空       #只撈出 @ 的行
cat p | sed 's/\/td>/\/td> \n /g' 	|sed 's/.htm.>/ @ /g'          |sed 's/.*ofile.//g' |grep @

</pre>
