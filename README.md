# System Monitoring Scripts 🚀

This repository contains scripts to monitor Linux server resources and automatically send email alerts when CPU or Memory usage crosses a set threshold.  

---

## Features

- ✅ Logs system info: CPU, Memory, Disk, Uptime, IP Address  
- ✅ Automatically saves logs to `/var/log/vivek-system-report/`  
- ✅ Sends email alerts if CPU or Memory usage exceeds a configurable limit  
- ✅ Easy to automate via cron  

---

## Requirements

- Linux server (Ubuntu, Amazon Linux, CentOS, Debian)  
- `bash` shell  
- `mailx` or `mailutils` installed  

### Install mail utility

```bash
# Amazon Linux / CentOS
sudo yum install mailx -y

# Ubuntu / Debian
sudo apt install mailutils -y
