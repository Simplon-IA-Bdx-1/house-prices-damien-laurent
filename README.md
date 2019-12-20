# Projet House-prices (12/2019)

## Objectifs

Générer un programme qui estime la capacité de remboursement d'une personne demandant un nouveau prêt.
<br><br>

## Méthodologie

1. Un historique de cas d'emprunteurs est disponible (plusieurs milliers), et pour chacun d'entre-eux diverses données :
    - si la personne a réussi a rembourser le prêt dans son intégralité
    - les revenus de la personnes
    - le nombre de personnes à charge
    - si elle a déjà eu des défauts de paiement
    - le taux d'endettement
    - ...

2. Un traitement est alors effectué sur ces données brutes afin de compléter les informations disponibles.

3. Un modèle d'apprentissage va alors être créé à partir de toutes ces données afin de déterminer l'importance de chacune 'entre-elles.

4. Lorsque un nouveau candidat emprunteur se présente :
    - l'on retraite ces nouvelles données de la même façon que ce qui avait été fait sur les données d'entraînement du mdèle
    - on présente ces nouvelles données au modèle
    - le résultat est récupéré, à savoir si ce candidat a de bonne chance de rembourser ou non (en se basant sur les cas passés)
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

