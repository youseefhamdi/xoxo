# recon.sh - XSS-Focused Reconnaissance Tool

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
![Bash](https://img.shields.io/badge/Language-Bash-ff69b4)
![Category](https://img.shields.io/badge/Category-Bug_Bounty-Recon-blue)

**recon.sh** is a fast, lightweight Bash script designed specifically for bug bounty hunters and penetration testers who want to quickly generate a high-quality list of parameter-based URLs (perfect for XSS testing) from a list of domains.

It automates subdomain enumeration, crawling, parameter extraction, and filtering — producing a clean `xss-ready.txt` file that can be directly fed into **[xoxo-xss](https://github.com/youseefhamdi/xoxo)** or any other XSS payload testing tool.

Part of the [xoxo-xss toolkit](https://github.com/youseefhamdi/xoxo).

## Features

- Input: simple list of root domains (one per line)
- Discovers subdomains with `subfinder`
- Crawls targets efficiently with `katana`
- Extracts and filters URLs containing query parameters using `urless`/`urlfinder`
- Removes duplicates, noisy file extensions, and irrelevant endpoints
- Outputs only high-value URLs ideal for reflected/stored XSS testing
- Fully automated and highly parallelized

## Prerequisites

Install these tools and ensure they're in your `$PATH`:

```bash
go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
go install -v github.com/projectdiscovery/katana/cmd/katana@latest
go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest
go install -v github.com/xnl-h4ck3r/urless@latest
# or: go install -v github.com/projectdiscovery/urlfinder/cmd/urlfinder@latest
```

## Installation & Usage

# 1. Clone or download recon.sh
```bash
wget https://raw.githubusercontent.com/youseefhamdi/xoxo/main/tools/recon.sh
chmod +x recon.sh
```
# 2. Create your domains list
```bash
cat > domains.txt << EOF
example.com
target.com
site.org
EOF
```

# 3. Run the recon
```bash
./recon.sh domains.txt
```

## Output:

```txt
[+] Starting reconnaissance on 3 domains...
[+] Subdomain enumeration completed
[+] Crawling and extracting URLs with parameters...
[+] Recon completed!
[+] XSS-ready URLs saved to: xss-ready.txt (12457 URLs found)
```

## One-Liner with xoxo-xss
```bash
Bash./recon.sh domains.txt && ./xoxo-xss -l xss-ready.txt -t 100 --rate 200
```

## Sample Output (xss-ready.txt)
```txt
https://app.example.com/search?q=test
https://target.com/profile.php?id=1337&debug=true
https://login.site.org/reset?token=abc123&ref=home
https://api.target.com/v1/users?filter[name]=admin&page=1
```

## Customization (Optional)
```txt
Edit variables at the top of recon.sh:
BashTHREADS=50        # Adjust parallelism
DEPTH=3           # Katana crawl depth
TIMEOUT=10        # HTTP request timeout
EXCLUDE="logout,signout,css,js,jpg,png,gif,pdf,svg"  # File extensions to skip
```
