# CoverShield Web Deployment Guide

Complete process to build and deploy CoverShield Flutter web app to production server.

## Prerequisites

- Flutter SDK installed
- SSH access to server (IP: `195.35.45.17`)
- Server password: `Bazeer@12345`
- Domain: `getashokaazzwels.shop`

---

## Step 1: Build Flutter Web App

### Navigate to project directory
```bash
cd /Users/adityasharma/Desktop/Flutter/covershield
```

### Build for web (Release mode)
```bash
flutter build web --release
```

### Build output location
```
/Users/adityasharma/Desktop/Flutter/covershield/build/web/
```

**Build output includes:**
- `index.html` - Main entry point
- `flutter.js` - Flutter loader
- `flutter_bootstrap.js` - Bootstrap script
- `assets/` - Images, fonts, and other assets
- `canvaskit/` - CanvasKit renderer files

---

## Step 2: Deploy to Server

### Using scp with sshpass (automated)

```bash
sshpass -p 'Bazeer@12345' scp -o StrictHostKeyChecking=no -r /Users/adityasharma/Desktop/Flutter/covershield/build/web/* root@195.35.45.17:/var/www/covershield/
```

### Manual SCP (if sshpass not installed)
```bash
scp -r /Users/adityasharma/Desktop/Flutter/covershield/build/web/* root@195.35.45.17:/var/www/covershield/
```

### Server path details
- **Server IP:** `195.35.45.17`
- **Username:** `root`
- **Password:** `Bazeer@12345`
- **Deploy path:** `/var/www/covershield/`

---

## Step 3: Server Configuration

### Nginx Config File Location
```
/etc/nginx/sites-available/covershield
```

### Current Nginx Config
```nginx
server {
    listen 80 default_server;
    listen [::]:80 default_server;
    server_name getashokaazzwels.shop www.getashokaazzwels.shop;
    return 301 https://$host$request_uri;
}

server {
    listen 443 ssl http2;
    listen [::]:443 ssl http2;
    server_name getashokaazzwels.shop www.getashokaazzwels.shop;
    root /var/www/covershield;
    index index.html;
    
    ssl_certificate /etc/letsencrypt/live/getashokaazzwels.shop/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/getashokaazzwels.shop/privkey.pem;
    include /etc/letsencrypt/options-ssl-nginx.conf;
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem;
    
    location / {
        try_files $uri $uri/ /index.html;
    }
    
    location ~* \.(js|css|png|jpg|jpeg|gif|ico|svg|woff|woff2|ttf|eot)$ {
        expires 1y;
        add_header Cache-Control "public, immutable";
    }
}
```

### Restart Nginx after config changes
```bash
sshpass -p 'Bazeer@12345' ssh -o StrictHostKeyChecking=no root@195.35.45.17 'nginx -t && systemctl restart nginx'
```

---

## Step 4: SSL Certificate (Let's Encrypt)

### Install/Update SSL Certificate
```bash
sshpass -p 'Bazeer@12345' ssh -o StrictHostKeyChecking=no root@195.35.45.17 'certbot --nginx -d getashokaazzwels.shop -d www.getashokaazzwels.shop --non-interactive --agree-tos --email admin@getashokaazzwels.shop'
```

### Auto-renewal
Certbot automatically sets up cron job for renewal. Verify with:
```bash
sshpass -p 'Bazeer@12345' ssh -o StrictHostKeyChecking=no root@195.35.45.17 'certbot renew --dry-run'
```

---

## Quick Deployment Script

### One-command deployment
```bash
#!/bin/bash

# Build Flutter web
flutter build web --release

# Deploy to server
sshpass -p 'Bazeer@12345' scp -o StrictHostKeyChecking=no -r /Users/adityasharma/Desktop/Flutter/covershield/build/web/* root@195.35.45.17:/var/www/covershield/

# Restart Nginx
sshpass -p 'Bazeer@12345' ssh -o StrictHostKeyChecking=no root@195.35.45.17 'systemctl restart nginx'

echo "✓ Deployment complete! Website live at: https://getashokaazzwels.shop"
```

Save as `deploy.sh` and run:
```bash
chmod +x deploy.sh
./deploy.sh
```

---

## Troubleshooting

### Website not loading
1. Check Nginx status:
   ```bash
   sshpass -p 'Bazeer@12345' ssh root@195.35.45.17 'systemctl status nginx'
   ```

2. Check file permissions:
   ```bash
   sshpass -p 'Bazeer@12345' ssh root@195.35.45.17 'ls -la /var/www/covershield/'
   ```

3. Check Nginx error logs:
   ```bash
   sshpass -p 'Bazeer@12345' ssh root@195.35.45.17 'tail -50 /var/log/nginx/error.log'
   ```

### SSL Issues
1. Test SSL config:
   ```bash
   sshpass -p 'Bazeer@12345' ssh root@195.35.45.17 'nginx -t'
   ```

2. Renew certificate manually:
   ```bash
   sshpass -p 'Bazeer@12345' ssh root@195.35.45.17 'certbot renew'
   ```

### Build Issues
1. Clean build:
   ```bash
   flutter clean
   flutter pub get
   flutter build web --release
   ```

---

## Website URLs

- **HTTP:** http://getashokaazzwels.shop
- **HTTPS:** https://getashokaazzwels.shop (SSL enabled)

---

## Server Details Summary

| Setting | Value |
|---------|-------|
| Server IP | 195.35.45.17 |
| Username | root |
| Password | Bazeer@12345 |
| Domain | getashokaazzwels.shop |
| Deploy Path | /var/www/covershield/ |
| Nginx Config | /etc/nginx/sites-available/covershield |
| SSL Certificate | /etc/letsencrypt/live/getashokaazzwels.shop/ |

---

## Last Deployment

- **Date:** April 1, 2026
- **Status:** ✅ Live
- **Build:** Flutter Web (Release)
- **Server:** 195.35.45.17
