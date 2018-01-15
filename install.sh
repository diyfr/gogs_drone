#!/bin/sh

apt-get install docker.io docker-compose git apache2-utils fail2ban
# CREATE DIRECTORIES
echo "Create Directories"
mkdir /var/ul
mkdir /var/ul/gogs
mkdir /var/ul/registry
mkdir /var/ul/registry/lib
mkdir /var/ul/drone
mkdir /var/ul/traefik
mkdir /var/ul/traefik/acme
mkdir /var/ul/gogs-database

echo "Define Basic Auth account for registry"
echo "Enter registry username"
read REG_USERNAME
htpasswd -c .registry_pwd $REG_USERNAME

# SETUP GOGS ACCOUNT FOR DRONE
echo "Setup GOGS account for drone connection"
echo "Enter GOGS username"
read GOGS_USERNAME
echo "Enter GOGS user password"
read GOGS_PASSWORD

echo "Enter domain ex: example.com"
read DOMAIN
echo "Enter Email for let's encrypt certificate query"
read EMAIL

echo "Define Basic Auth account for traefik console"
echo "Enter registry username"
read REG_USERNAME
htpasswd -c .traefik_pwd $REG_USERNAME

cp traefik.toml.ori /var/ul/traefik/traefik.toml
echo "Create /var/ul/traefik/traefik.toml configuration"
sed -i "s/%%DOMAIN%%/${DOMAIN}/g" /var/ul/traefik/traefik.toml
sed -i "s/%%EMAIL%%/${EMAIL}/g" /var/ul/traefik/traefik.toml
sed -i "s/%%BASIC_AUTH%%/$(cat .traefik.pwd)/g" /var/ul/traefik/traefik.toml


echo "Generate .env file"

ENV_FILE=".env"
touch "$ENV_FILE"
echo "DOMAIN=$DOMAIN" >> "$ENV_FILE"
echo "EMAIL=$EMAIL" >> "$ENV_FILE"
echo "GOGS_USERNAME=$GOGS_USERNAME" >> "$ENV_FILE"
echo "GOGS_PASSWORD=$GOGS_PASSWORD" >> "$ENV_FILE"
echo "REGISTRY_BASIC_AUTH=$(cat .registry_pwd)" >> "$ENV_FILE"
# CREATE DOCKER NETWORK
docker network create pg1
docker network create traefik
echo " ----------------------------------- "
echo " Start stack -> docker-compose up -d "
echo " ----------------------------------- "


