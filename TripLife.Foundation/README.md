# TripLife Foundation project

Ce projet contient un ensemble d'elements partages entre les differents micro-services de la solution TripLife.

## Developpement et utilisation

Pour utiliser la solution lors de developpement en local. 
Il est necessaire de generer les fichiers .nupkg lies a chaque bibliotheques de classes afin de pouvoir chacun d'entre eux sous forme de Package Nuget aupres des micro-services TripLife.

Pour ce faire, placez-vous a la racine du projet TripLife.Foundation et executez la commande :
> dotnet pack --configuration Release --output ./NugetPackages

Cette commande va build, pack et creer les nupkg de chaque bibliotheque et les placer dans le dossier NugetPackages.

Si ce n'est pas deja fait, il va maintenant ajouter ce dossier en tant que source de package. 

Pour ce faire, aller sur Visual Studio (community) > Outils > Gestionnaire de package Nuget > Parametres du Gestionnaire de package > Sources de package.
Depuis ce menu, appuyez sur le bouton "+" vert et definissez un nom pour cette source et dans le champ "Source", indiquez la route vers le dossier NugetPackages present sur votre machine precedemment rempli.