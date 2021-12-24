

#!/bin/bash
# By Mercurial
## Automated GF && GF-patterns 


overwrite=false

if [ ! -d "Gf_files" ] || [ "$overwrite" = true ]

then

echo "Calma SrMercurial estamos a descobrir gf-patterns"

mkdir "Gf_files"
mkdir "url_data"

######################################## GF ######################################## 

{
#cat urls_live | python3 /home/water/tools/FavFreak/favfreak.py --shodan -o FaviCon
cat urls_live | Gxss | anew Gf_files/reflected.txt

gf ssrf < "urls_live" > "Gf_files/server-side-request-forgery.txt"
cat  "Gf_files/server-side-request-forgery.txt" | qsreplace FUZZ  | anew "Gf_files/ssrf.txt"

gf takeovers < "urls" > "Gf_files/takeovers.txt"

gf xss < "urls_live" > "Gf_files/xsscript.txt"
cat  "Gf_files/xsscript.txt" | kxss | anew "Gf_files/xssManual.txt"
cat Gf_files/xssManual.txt | sed 's/URL://g' | sed 's/\Param.*$//' | anew "Gf_files/xss.txt"


gf redirect < "urls_live" > "Gf_files/open-redirect.txt"
cat  "Gf_files/open-redirect.txt" | qsreplace FUZZ  | anew "Gf_files/openredirect.txt"
#cut -f 3- -d ':' |

gf rce < "urls_live" > "Gf_files/rcexe.txt"
cat  "Gf_files/rcexe.txt" | qsreplace FUZZ  | anew "Gf_files/rce.txt"


gf idor < "urls_live" > "Gf_files/insecure-direct-object-reference.txt"
cat  "Gf_files/insecure-direct-object-reference.txt" | qsreplace FUZZ  | anew "Gf_files/idor.txt"

gf sqli < "urls_live" > "Gf_files/sqli_normal.txt"
cat  "Gf_files/sqli_normal.txt" | qsreplace FUZZ  | anew "Gf_files/sqli.txt"


gf lfi < "urls_live" > "Gf_files/local-file-inclusion.txt"
cat  "Gf_files/local-file-inclusion.txt" | qsreplace FUZZ  | anew "Gf_files/lfi.txt"


gf ssti < "urls_live" > "Gf_files/server-side-template-injection.txt"
cat  "Gf_files/server-side-template-injection.txt" | qsreplace FUZZ  | anew "Gf_files/ssti.txt"

cat urls | httpx -mc 200,301,302 | grep -vE "\.js|/js/|.json"| grep -iE "admin|test|staging|dev|development|prod|production" >> sensitive_url
mv sensitive_url Gf_files/sensitive_url.txt

cat urls | for i in `gf -list`; do [[ ${i} =~ "_secret"* ]] && gf ${i}; done | anew "Gf_files/secrets.txt"

######################################## UNFURL ######################################## 

cat urls | unfurl -u domains | anew url_data/domains
cat urls | unfurl -u paths | anew url_data/paths
cat urls | unfurl -u keys | anew url_data/keys
cat urls | unfurl -u values | anew url_data/values
cat urls | unfurl -u keypairs | anew url_data/keypairs

cd "Gf_files"
rm "xsscript.txt"
rm "open-redirect.txt"
rm "rcexe.txt"
rm "local-file-inclusion.txt"
rm "server-side-request-forgery.txt"
rm "server-side-template-injection.txt"
rm "insecure-direct-object-reference.txt" 

######################################## GREP ######################################## 
mkdir "Grep_files"
# Use GF to identify "suspicious" endpoints that may be vulnerable (automatic checks below)
cat  "urls_live" | grep "api" | anew  "Grep_files/api.txt"
cat  "urls_live" | grep "admin" | anew  "Grep_files/admin.txt"
cat  "urls_live" | grep ".php"  | anew  "Grep_files/php.txt"
cat  "urls_live" | grep ".aspx"  | anew  "Grep_files/aspx.txt"
cat  "urls_live" | grep "cgi-bin"  | anew  "Grep_files/cgi-bin.txt"
cat  "urls_live" | grep "bin"  | anew  "Grep_files/bin.txt"
cat  "urls_live" | grep ".git/config"  | anew  "Grep_files/git_config.txt"
cat  "urls_live" | grep ".env"  | anew  "Grep_files/env.txt"
cat  "urls_live" | grep ".jsp"  | anew  "Grep_files/jsp.txt"


} &> /dev/null

echo "Esta feito SrMercurial!"
fi



