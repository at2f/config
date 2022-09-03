# Installation des postes

1. Installer Windows 11 Pro [en créant un compte administrateur local](https://github.com/at2f/regler_problemes#installer-windows-sans-compte-microsoft). Les stagiaires auront chacun une session locale sans droits d’administration.
2. Installer le pilote de la carte graphique [AMD Software Adrenalin Edition](https://www.amd.com/fr/support) pour les postes de travail (sans cela un seul écran sera fonctionnel).
3. Faire les mises à jour de Windows.
4. Mettre à jour les logiciels du Microsoft Store (cela installera `winget` qui est nécessaire par la suite).
5. Autoriser l’exécution de scripts Powershell pour l’utilisateur courant avec `Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser`
6. Lancer [le script d’installation des postes](https://github.com/at2f/config/blob/main/e-formation/script_installation_postes_e-formation.ps1).
7. Configurer les stratégies de groupe dans « Modifier la stratégie de groupe » (`gpedit.msc`) avec [les paramètres suivants](https://github.com/at2f/config/blob/main/e-formation/Param%C3%A8tres%20de%20strat%C3%A9gie%20de%20groupe.md).
8. Lancer le script `maintenance_manuelle_hebdomadaire.ps1` présent sur le bureau.
10. Redémarrer l’ordinateur et attendre au moins une heure que le chiffrement soit terminé. (`manage-bde status` pour surveiller l’avancement)

# Ressources
## Mozilla Firefox
- [Modèle des paramètres d’entreprise](https://github.com/mozilla/policy-templates)
 
*Consulter les stratégies de groupe actives via `about:policies`.*

## Google Chrome
- [Outils de configuration de Google Chrome sur Windows](https://support.google.com/chrome/a/topic/6242754)
- [Gérer les règles de Chrome à l’aide du Registre Windows](https://support.google.com/chrome/a/answer/9131254?hl=fr)
- [Liste des règles Chrome Enterprise](https://chromeenterprise.google/policies/)

*Consulter les stratégies de groupe actives via `chrome://policy`.*

## Microsoft Edge
- [Microsoft Edge : Stratégies](https://docs.microsoft.com/fr-fr/deployedge/microsoft-edge-policies)

*Consulter les stratégies de groupe actives via `edge://policy`.*
