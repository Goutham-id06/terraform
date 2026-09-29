
# Module-Three-Tier apply flow 
```
terraform apply -target=module.vpc -auto-approve
terraform apply -target=module.frontend-ec2 -auto-approve
terraform apply -target=module.backend-ec2 -auto-approve
terraform apply -target=module.frontend_alb -auto-approve
terraform apply -target=module.backend_alb -auto-approve
terraform apply -target=module.rds -auto-approve
```
- now connect to backend and frontend ec2s deploy the application
- in frontend connfig file give backend loadbalncer url
- next backend .env give rds detils 
- next deploy both frontend and backend

- conenct to backend 

https://github.com/Goutham-id06/2nd10WeeksofCloudOps-main.git

2nd10WeeksofCloudOps-main.git/backend/.env

### add this mater
DB_HOST=book.rds.com	#change rds endpoint
DB_USERNAME=admin	#cahnge to nyour rds user name 
DB_PASSWORD="123456789"   # change to your rds password
PORT=3306

yum install mariadb105-server
sudo dnf install -y nodejs
sudo npm install -g pm2

mysql -h book.rds.com -u admin -p<password> < test.sql

cd backend

npm install

npm install dotenv

sudo pm2 start index.js --name node-app

sudo pm2 startup

sudo systemctl enable pm2-root

sudo pm2 save

- connect to frontend

sudo yum update -y
sudo yum install -y nginx
# Enable and start nginx
sudo systemctl enable --now nginx

sudo vi /etc/nginx/conf.d/nginx.conf

server {
    listen 80;
    root /usr/share/nginx/html;
    index index.html;

    location / {
        try_files $uri $uri/ /index.html;
    }

    location /api {
        proxy_pass http://localhost;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }

   location /socket.io {
        proxy_pass http://localhost;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "Upgrade";
        proxy_set_header Host $host;
    }

    gzip on;
    gzip_types text/plain text/css application/json application/javascript text/xml application/xml;
}

sudo nginx -t
sudo systemctl reload nginx

sudo dnf install -y nodejs
npm install

npm run build

# Copy the build files to nginx root on the nginx host
sudo rm -rf /usr/share/nginx/html/*
sudo cp -r build/* /usr/share/nginx/html/

# reload nginx
sudo systemctl reload nginx
sudo systemctl enable nginx



# apply reming  mmodules
```
terraform apply -target=module.frontend_launchtemplate
terraform apply -target=module.backend_launchtemplate
terraform apply -target=module.asg-backend
terraform apply -target=module.asg-frontend

```
