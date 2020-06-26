upstream webfwk {
    server webfwk-app:8080 max_fails=3 fail_timeout=10s;
}

server {
    listen       443 ssl;
    listen  [::]:443 ssl;
    server_name  webfwk.socyno.org;
    
    ssl_protocols TLSv1.2 TLSv1.1 TLSv1;
    ssl_certificate /etc/nginx/cert/webfwk-cert-all.pem;
    ssl_certificate_key /etc/nginx/cert/webfwk-cert-key.pem;
    ssl_prefer_server_ciphers on;
    ssl_ciphers HIGH:!aNULL:!MD5;
    
    location / {
        root /usr/share/nginx/html/webfwk;
        index index.html index.htm;
    }
    
    error_page 502 503 504 /50x.html;
    location /50x.html {
        root /usr/share/nginx/html;
    }
    
    location /webfwk/ {
        proxy_pass http://webfwk; 
    }
}
