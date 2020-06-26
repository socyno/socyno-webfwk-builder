upstream webfwk {
    server 10.0.0.11:8080 max_fails=3;
}

server {
	listen 80;
	return 500;
}

server {
    listen       80;
    listen  [::]:80;
    server_name  webfwk.socyno.org;
    
    location / {
		root /usr/share/nginx/html/webfwk;
		index index.html index.htm;
	}
	
	error_page 500 502 503 504 /50x.html
	location /50x.html {
		root /usr/share/nginx/html;
	}
	
	location /webfwk/ {
		proxy_pass http://webfwk; 
	}
}
