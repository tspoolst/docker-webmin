# docker-webmin
dockerfile for webmin

## Building the image
```
git clone https://github.com/tspoolst/docker-webmin.git
cd docker-webmin
docker build -t tspoolst/webmin .
```

## Running the container
```
docker run -d -p 10000:10000 tspoolst/webmin
```

Log into webmin and manage your server
```
https://hostname.or.ip:10000
(root:pass)
```
