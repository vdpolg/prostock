#!/bin/bash
#名稱		版本	日期		作者	備註
#import sql	v0.1	20180909	arthur	塞db
WRKDIR=$PWD
DB_NAME=prostock_db
DB_DOCKER=mariadb_db_1
DB_USER=root
DB_PASSWORD=111111
DB_SQL=p10.tmp
function IMPORT(){
cd $WRKDIR
docker exec -i $DB_DOCKER mysql -u$DB_USER -p$DB_PASSWORD $DB_NAME < $DB_SQL
}
IMPORT

