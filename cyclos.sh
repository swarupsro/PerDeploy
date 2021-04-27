sudo docker pull cyclos/cyclos

sudo docker network create cyclos-net

sudo docker run -d \
    --name=cyclos-db \
    --net=cyclos-net \
    --hostname=cyclos-db \
    --restart=unless-stopped \
    -e POSTGRES_DB=cyclos \
    -e POSTGRES_USER=cyclos \
    -e POSTGRES_PASSWORD=cyclospwd \
    postgis/postgis

sudo docker run -d \
    --name=cyclos-app \
    -p 80:8080 \
    --net=cyclos-net \
    --restart=unless-stopped \
    -e DB_HOST=cyclos-db \
    -e DB_NAME=cyclos \
    -e DB_USER=cyclos \
    -e DB_PASSWORD=cyclospwd \
    cyclos/cyclos

sudo docker start cyclos-db cyclos-app