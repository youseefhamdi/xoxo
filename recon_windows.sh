#!/bin/bash

echo "[*] Subdomain enumeration started!"

subfinder -dL "$1" -all -o subs.txt 

echo "[*] crawling started!"
urlfinder -list subs.txt -all -o urlfinder.txt

httpx -list subs.txt -o httpx.txt

katana -u httpx.txt -d 5 -cs waybackarchive,commoncrawl,alienvault -kf -jc -fx -ef woff,css,png,svg,jpg,woff2,jpeg,gif,svg -o katana.txt

Get-Content urlfinder.txt, katana.txt | Set-Content urls-1.txt

Get-Content urls-1.txt | Select-String -Pattern "=" | Sort-Object -Unique | Set-Content xss_1.txt

urless -i xss_1.txt -o xss-ready.txt

Remove-Item -Path @("urls-1.txt", "xss_1.txt", "katana.txt", "urlfinder.txt") 












