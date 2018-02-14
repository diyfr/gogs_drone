# Gogs & Drone 
Créez votre propre solution LIGHT d'intégration continue :  
- Gogs (Gitlab light privé)  
- Drone (CI)  
- Registry Docker (Hébergement privé de vos images docker)  

Le tout derrière le reverse proxy  'Traefik' en https avec Let's Encrypt  

# Installation
Il faut au préalable que la configuration bind9 (Nom de domaine) sur votre machine ubuntu soit déjà réalisée.  
Cloner le répo et rendre le script exécutable  
```bash
git clone https://github.com/diyfr/gogs_drone.git  
cd gogs_drone/  
sudo su  
chmod +x install.sh  
```
Le lancer(toujours en mode admin) et répondre aux questions. Pour les identifiants et mot de passe pensez à les noter
```bash
./install.sh
```
Une fois le script déroulé, vous pouvez lanacer la stack avec cette commande:  
```bash
docker-compose up -d
```
Vérifier que tous les containers (traefik, gogs,gogs-database,drone-server,drone-agent, registry)sont présents   
```bash
docker ps -a 
```

### Configurer gogs


Accès à votre repository (Pour un domaine example.com):   
https://g.example.com  

Lors du premier accès à Gogs, il vous faudra configurer la connexion à la bdd  
type: `PostgreSQL`  
hôte: `gogs-database:5432`   
Utilisateur: `gogs`  
Mot de passe : `gogs`    
Mode SSL :`disable`  
Nom de l'application : `<Ce que vous voulez>`  
Emplacement racine des dépôts : <Laissez ce qui est proposé par défaut>  
Utilisateur système : <Laissez ce qui est proposé par défaut>   
Domaine: `<Saisissez votre domaine ex : g.example.com>`     
Port SSH : <Laissez ce qui est proposé par défaut>    
Utilisez le serveur SSH incorporé : <Laissez ce qui est proposé par défaut>    
Port HTTP : <Laissez ce qui est proposé par défaut>    
URL de l'application : `<Saisissez votre domaine ex : https://g.example.com/>`  
Chemin des fichiers de logs : <Laissez ce qui est proposé par défaut>    

Dans les paramètres facultatifs / Paramètres du serveur et des autre services :
Laissez coché uniquement :
Désactiver le formulaire d'inscription  
Exigez l'identification pour afficher les pages  
Optionnel:  
Activer les recherches d'avatars unifiés  

Dans les paramètres facultatifs / Paramètres du compte administrateur :

Il vous faudra créer le compte avec les identifiants et mot de passe que vous avez spécifiés lors de l'éxécution du script d'installation. Retrouvez les dans le fichier `.env`  

Une fois la première configuration Gogs réalisée, le fichier de conf est accessible dans /var/ul/gogs/gogs/conf/app.ini. Si vous y réalisez des modification pensez à relancer le container. 
```bash
docker restart gogs
```

### Autres interfaces..  
Accès à la console Traefik (identifiant saisi lors du script d'installation):  
http://example.com:8080  
Accès à votre CI (identifiant et pwd dito compte gogs):  
https://d.example.com  
Accès à votre registre personnel docker (identifiant saisi lors du script d'installation):  
https://r.example.com/v2/  

Enjoy !  


## Nota  
Pensez à vérifier les images stockées sur le registry local, un petit nettoyage peut-être salutaire..
https://docs.docker.com/engine/reference/commandline/image_prune/  


