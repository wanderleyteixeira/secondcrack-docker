# Summary
I containerized the [Second Crack static-file blog engine](https://github.com/marcoarment/secondcrack) project using Alpine Linux.

## Docker

Second Crack requires PHP 5.3+ and was tested on Mac OS X and CentOS 5.5, with Apache HTTPd. I dockerized the blog using Alpine Linux (v3.9) for the base OS image and added NGINX. You can build and deploy the image anywhere Docker is supported.

The docker image contain all PHP dependencies.

### Build
`$ docker build -t secondcrack:v1 .`

### Run
`$ docker run -i -t -v /tmp/secondcrack:/home/secondcrack -p 80:80 secondcrack:v1`

## NGINX

I prefer to use NGINX over Apache HTTPd. 

## inotify + nginx + supervisord

This modified version of SecondCrack will leverage NGINX reverse proxy, inotify-tools, and supervisord to automatically monitor your Second Crack's path for any changes including in `drafts/*` folder. This way, once a file is added or changed it will automatically update the site. 

Docker is a great way to componentize an app along different aspects. But I found that when I still need to start multiple programs in a single container, it is better to use supervisor instead of cron scripts.

## Robots.txt
I added a `robots.txt` template from Jonas Jacek's [robots](https://github.com/jonasjacek/robots.txt) project.


## Pushover
I integrated [Pushover](https://pushover.net)'s API to the `update.sh` to send a notification once page it updated.

