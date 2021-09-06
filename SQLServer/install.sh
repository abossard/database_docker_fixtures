#!/bin/sh
/opt/mssql/bin/sqlservr &
until /opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P $SA_PASSWORD  -Q 'CREATE DATABASE $TARGET_DB'
do
  sleep 1
  echo "Try again"
done
#/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P $SA_PASSWORD  -Q 'EXEC sp_msforeachtable "ALTER TABLE ? NOCHECK CONSTRAINT all"'

/opt/sqlpackage/sqlpackage /tsn:localhost /tu:SA /tp:$SA_PASSWORD /A:Import /tdn:$TARGET_DB /sf:$BACPAC