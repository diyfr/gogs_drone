# Exemple de fichier de configuration pour le build d'une application JAVA  

## Modifier .drone.yml
Remplacer `example.com` par votre domaine  

## Placez les fichier .drone.yml et Dockerfile à la racine de votre projet java.  
Il faut déclarer les éléments de connexions basic auth à Drone.io pour qu'il puisse pusher l'image sur votre registry  
Sur l'onglet secret  ajoutez :  
docker_username   -> utilisateur créé à l'installation pour le registry  
docker_password   -> Mot de passe créé à l'installation pour le registry  

Pour verifier que votre image est bien dans votre registry privé  
`https://r.example.com/v2/_catalog`


## Utiliser votre image :  
Il faut au préalable que docker dispose des éléments d'authentification sur votre registry  (saisi lors de l'installation et dans drone.io pour publier votre image)  
```bash
docker login r.example.com
```
ensuite récupérez votre image :
```bash
docker pull r.example.com/app:latest
```
