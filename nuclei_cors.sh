#!/bin/bash
# By Mercurial
## Automated GF && GF-patterns 


echo "Ola SrMercurial"
mkdir nuclei
mkdir cors 
echo "Numero de Threads:"
read threadsLimit
echo "A Scannar"
#if [ "$threadsLimit" -gt 150 ];
#then
#echo "---------Threads estao muito altas---------"
#echo "-------------------Valor-------------------"
#threadsLimit=150
#fi


{
nuclei -update
nuclei -ut
cat hosts | nuclei -t /home/water/nuclei-templates/vulnerabilities/ -o nuclei/nuclei_vulnerabilities.txt -rate-limit $threadsLimit
cat hosts | nuclei -t /home/water/nuclei-templates/cves/ -o nuclei/nuclei_cves.txt -rate-limit $threadsLimit
cat hosts | nuclei -t /home/water/nuclei-templates/exposed-panels/ -o nuclei/nuclei_panels.txt -rate-limit $threadsLimit
cat hosts | nuclei -t /home/water/nuclei-templates/technologies/ -o nuclei/nuclei_technologies.txt -rate-limit $threadsLimit
cat hosts | nuclei -t /home/water/nuclei-templates/exposures/ -o nuclei/nuclei_exposures.txt -rate-limit $threadsLimit
cat hosts | nuclei -t /home/water/nuclei-templates/misconfiguration/ -o nuclei/nuclei_misconfiguration.txt -rate-limit $threadsLimit
cat hosts | nuclei -t /home/water/nuclei-templates/token-spray/ -o nuclei/nuclei_token.txt -rate-limit $threadsLimit
cat hosts | nuclei -t /home/water/nuclei-templates/file/ -o nuclei/nuclei_file.txt -rate-limit $threadsLimit
cat hosts | nuclei -t /home/water/nuclei-templates/default-logins/ -o nuclei/nuclei_default.txt -rate-limit $threadsLimit 
cat hosts | nuclei -t /home/water/nuclei-templates/fuzzing/ -o nuclei/nuclei_fuzzing.txt -rate-limit $threadsLimit
cat hosts | nuclei -t /home/water/nuclei-templates/takeovers/ -o nuclei/nuclei_takeovers.txt -rate-limit $threadsLimit 
cat hosts | nuclei -t /home/water/nuclei-templates/cnvd/ -o nuclei/cnvd.txt -rate-limit $threadsLimit 
cat hosts | nuclei -t /home/water/nuclei-templates/workflows/ -o nuclei/workflows.txt -rate-limit $threadsLimit 
} &> /dev/null
echo "Scan com Nuclei concluido SrMercurial"
echo "Scan cors agora"
{
python3 /home/water/tools/CORScanner/cors_scan.py -i hosts -o /cors/cors
python3 /home/water/tools/Corsy/corsy.py -i hosts -o /cors/corsy
} &> /dev/null

echo "Concluido SrMercurial"
