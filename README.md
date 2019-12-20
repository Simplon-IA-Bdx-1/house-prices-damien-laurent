# Projet House-prices (12/2019)

## Objectifs

Estimer le prix de vente de biens immobilier à partir d'un dataset fournit par kaggle.
<br><br>

## Méthodologie

1. Un historique de cas de ventes est disponible (plusieurs milliers), et pour chacune d'entre-elles diverses données :
    - si le bien est sur un ou plusieurs étages
    - la surface du biens
    - la date de construction
    - la présence d'un garage
    - la présence d'une piscine
    - ...

2. Un traitement est alors effectué sur ces données brutes afin de compléter les informations disponibles, traiter les données extrèmes ou encore harmoniser les données (entièrement numériques ou non).

3. Un modèle d'apprentissage va alors être créé à base d'un réseau de neurones.

4. Une prédiction est effectuée sur un autre ensemble de données dont le prix est inconnu.

5. Nous soumettons alors les prédictions pour évaluation à Kaggle qui nous retourne un score de précision.
<br><br>

## Méthode d'importation du projet et mise en oeuvre

1. Télécharger depuis le dépot github du groupe : https://github.com/Simplon-IA-Bdx-1/house-prices-damien-laurent.git

2. Extraire le fichier .zip dans un dossier vide sur votre espace de travail.

3. Dans le dossier extrait, créer le sous-dossier csv qui accueillera les fichiers du challenge Kaggle ainsi que ceux générés par les notebooks.

4. Depuis votre compte kaggle, récupérez les fichiers test et train du challenge Kaggle : https://www.kaggle.com/c/house-prices-advanced-regression-techniques/data (le fichier train doit être renommé en trainfull)

5. Placer vous dans le sous-dossier docker 
    - Renommer le fichier auth-a-remplir en auth.
    - A partir de votre compte Kaggle renseigner les variables présentes dans auth. (username et apikey)

6. Depuis ce même dossier, ouvrir une fenêtre de terminal et construire l'image docker avec la commande : docker-compose build (l'éxécution de cette commande peut prendre un certain temps, quelques minutes normalement)

7. Création du container à partir de l'image précedement construite, avec la commande : docker-compose up -d

8. Afin d'atteindre les fichiers du projet, l'accès se fait à pertir du navigateur. L'adresse à rentrer dans la barre d'url est : localhost:8888

9. Une fois sur la page Jupyter, le dossier contenant le projet est visible. A l'intérieur de celui-ci vous pourrez ouvrir les différents notebooks. (Les fichiers notebooks sont numérotés selon leur ordre d'éxécution)
<br><br>

## Liens vers les notebooks

- Récupération et visualisation des Données
<center>

[01_visualisation_data.ipynb](file/01_visualisation_data.ipynb)
</center>

- Définition des fonctions pour le traitement de données
<center>

[02_data_processing_functions.ipynb](file/02_data_processing_functions.ipynb)
</center>

- Traitement de données
<center>

[03_data_processing.ipynb](file/03_data_processing.ipynb)
</center>

- Création du modèle et évaluation
<center>

[04_evaluation.ipynb](file/04_evaluation.ipynb)
</center>

- Préparation du fichier pour évaluation finale
<center>

[06_kaggle_submission.ipynb](file/06_kaggle_submission.ipynb)
</center>
<br><br>

## Score Kaggle

Score = 0.16165
