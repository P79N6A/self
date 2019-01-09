```bash
host='ip'
port=8086

curl -v "$host:$port/query?pretty=true"  --data-urlencode "q=SHOW DATABASES"
curl "$host:$port/query?pretty=true"  --data-urlencode "q=CREATE DATABASE testdb"
curl "$host:$port/query?pretty=true" --data-urlencode "db=testdb" --data-urlencode "q=SHOW measurements"
curl "$host:$port/query?pretty=true" --data-urlencode "db=testdb" --data-urlencode "q=DROP measurement hello"

cat > data.txt <<EOF
mymeas,mytag1=1 value=21 1463689680
mymeas,mytag1=1 value=34 1463689690000000000
mymeas,mytag2=8 value=78 1463689700000000000
mymeas,mytag3=9 value=89 1463689710000000000
EOF

curl -X POST "$host:$port/write?db=testdb" --data-binary @data.txt

```
