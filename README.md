# Gogs & Drone 
Créez votre propre solution d'intégration continue :  
- Gogs (Gitlab light privé)  
- Drone (CI)  
- Registry Docker (Hébergement privé de vos images docker)  

Le tout derrière le reverse proxy  'Traefik' en https avec Let's Encrypt  

# Installation
Il faut au préalable que la configuration bind9 sur votre machine ubuntu soit déjà réalisée.  
Cloner le répo et rendre le script exécutable  
```bash
git clone https://github.com/diyfr/gogs_drone.git  
cd gogs_drone/  
sudo su  
chmod +x setup.sh  
```
Le lancer(toujours en mode admin) et répondre aux questions. Pour les identifiants et mot de passe pensez à les noter
```bash
./setup.sh
```
Une fois le script déroulé, vous pouvez la stack avec cette commande:  
```bash
docker-compose up -d
```
Vérifier que tous les containers (traefik, gogs,gogs-database,drone-server,drone-agent, registry) 
```bash
docker ps -a 
```
Lors du premier accès à Gogs, il vous faudra configurer la connexion à la bdd  
host: `gogs-database:5432`   
user: `gogs`  
pwd : `gogs`  

Il vous faudra créer le compte avec les identifiants et mot de passe que vous avez spécifiés lors de l'éxécution du script d'istallation. retrouvez les dans le fichier `.env`  

Une fois la première configuration Gogs réalisée, le fichier de conf est accessible dans /var/ul/gogs/gogs/conf/app.ini. Vous pourrez rendre l'accès obligatoire  et bloquer la création de compte :

```conf
DISABLE_REGISTRATION   = true
REQUIRE_SIGNIN_VIEW    = true
```

Pour un domaine exmaple.com  
Accès à la console Traefik (identifiant saisi lors du script d'installation):  
http://example.com:8080  
Accès à votre repository :  
https://g.example.com  
Accès à votre CI (identifiant et pwd dito compte gogs):  
https://d.example.com  
Accès à votre registre personnel docker (identifiant saisi lors du script d'installation):  
https://r.example.com/v2/  

Enjoy !  


