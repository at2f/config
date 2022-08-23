# Installation des postes

1. Installer Windows 11 Pro en créant une session administrateur local. Les stagiaires auront chacun une session locale sans droits d’administration.
2. Installer le pilote de la carte graphique [AMD Software Adrenalin Edition](https://www.amd.com/fr/support) pour les postes de travail (sans cela un seul écran sera fonctionnel).
3. Fair les mises à jour de Windows.
4. Mettre à jour les logiciels du Microsoft Store (cela installera `winget` qui est nécessaire pour l’étape suivante).
5. Lancer [le script d’installation des postes](https://github.com/at2f/config/blob/main/e-formation/script_installation_postes_e-formation.ps1).
6. Configurer les stratégies de groupe dans « Modifier la stratégie de groupe » (`gpedit.msc`) avec [les paramètres suivants](https://github.com/at2f/config/blob/main/e-formation/Param%C3%A8tres%20de%20strat%C3%A9gie%20de%20groupe.md).
