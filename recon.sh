#!/bin/bash
# By Mercurial
## Automated GF && GF-patterns 


echo "Ola SrMercurial"
echo "Manda ai o dominio"
read domain
echo "Vou ver o" $domain "Vai buscar um cafe SrMercurial"
{
cd recon
mkdir $domain
cd $domain
python3 /home/water/tools/Sublist3r/sublist3r.py -d $domain -o domains
amass enum --passive -d "$domain" | anew domains
subfinder -d $domain | anew domains
cat domains | qsreplace -a
cat domains | httpx -silent | anew hosts
# shuffledns -d $domain -w words.txt -r resolvers 
} &> /dev/null
echo "Tou a tirar pics com o Aquatone"
{
cat hosts | fff -d 1 -S -o hosts_roots
#cat hosts | aquatone -out /home/water/recon/$domain/AquatoneReport
cat hosts | gau | anew urls
cat hosts | waybackurls | anew urls
cat urls | httpx -mc 200 | anew urls_live
chronos -t $domain -p /robots.txt -m Disallow -e "(?:\s)(/.*)" -o robots_wordlist.txt

###Port Scan####
bash /home/op/tools/dnmasscan/dnmasscan domains dns.log -p80,433 -oG Nmap_masscan.log
mkdir portscan
cp Nmap_masscan.log /portscan
cp dns.log /portscan
cat dns.log | grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}' | anew portscan/ip_file.txt
rm Nmap_masscan.log 
rm dns.log 
######

} &> /dev/null

echo "Vou mandar agora os hosts para fazer scan ao JavaScript, depois vai lá começar o scan"
cp hosts /home/water/tools/JSFScan.sh/hosts_$domain 

echo "Esta feito SrMercurial"
