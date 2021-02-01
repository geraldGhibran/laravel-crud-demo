# Simple Laravel CRUD Demo

## Installation

We need composer to install all packages.
Here the complete instruction to install composer https://getcomposer.org/doc/00-intro.md

Make sure you're already install docker in your machine
Run command below to build docker images

```
docker build -t laravelCrud .
```

Run command below to build images using previous docker images

```
docker run -it -d --name laravelCrud -p 81:81 laravelCrud

```

Next, enter the container
```
docker exec -it laravelCrud /bin/bash
```

or

```
docker exec -it laravelCrud /bin/sh
```

And create databases
```
mysql -u root 
CREATE DATABASE IF NOT EXISTS test; 
CREATE USER IF NOT EXISTS 'user'@'%' IDENTIFIED BY 'password'; 
GRANT ALL PRIVILEGES ON * . * TO 'user'@'%'; 
FLUSH PRIVILEGES; 

```


Let's do some migration and seed with dummy data.

```
cd /var/www/html && php artisan migrate --seed
```

Change .env.example to .env
```
cd /var/www/html && mv .env.example .env
```

Now, visit http://localhost:81 to try the demo.

## Notes
This apps running without php artisan

This repo is forked from https://github.com/mul14/laravel-crud-demo make sure you give the star if this work for you, thanks.