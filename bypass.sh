#!/bin/bash
# By Mercurial
## Automated Bypass 403


echo "Ola SrMercurial"
echo "Site Ex:https://site.com/api/v2"
echo "Manda ai o dominio com https/http    ---> Ex: https://site.com/api/v2"
read domain
#echo "Manda ai o dominio com https/http    ---> Ex: https://site.com"
#read domain1
#echo "Manda ai o path com https/http       ---> Ex: api/v2"
#read path

#python3 /home/water/tools/403bypass/4xx.py $domain1 $path 
bash /home/water/tools/4-ZERO-3/403-bypass.sh -u $domain --exploit 
python3 /home/water/tools/byp4xx/byp4xx.py $domain 
#cat ficheiro1 | grep "200" | anew bypass1
#cat ficheiro2 | grep "200" | anew bypass2
#cat ficheiro2 | grep "curl" | anew bypass2
#cat ficheiro3 | grep "200" | anew bypass3
#rm ficheiro1
#rm ficheiro2
#rm ficheiro3
echo "Acabou"
