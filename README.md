 Script de Téléchargement Pro (Basé sur CURL)

 Présentation
Ce projet est un utilitaire de téléchargement robuste conçu pour gérer efficacement les transferts de fichiers. Il intègre des mécanismes de reprise intelligente, un logging détaillé et des options de sécurité avancées. L'évolution entre la version v2 et la v3 apporte des améliorations majeures en termes de robustesse et de traçabilité.

 Évolution des Fonctionnalités
 La Base (Version v2)
 La version v2 a posé les fondations du script avec les options essentielles :
 Mode Verbeux (-v) : Affiche des informations supplémentaires en fin de script.
 Reprise forcée (-c) : Utilise curl -C - pour continuer un transfert interrompu.
 Journalisation (-l) : Enregistre les événements dans un fichier de log dédié.
 
 Gestion Intelligente :
 Vérification de l'existence du fichier avant le début du transfert.
 Question interactive pour décider de la reprise ou du remplacement.
 Fonction log() centralisée (affichage écran + écriture fichier).
 
  Améliorations Majeures (Version v3)
  La v3 transforme l'outil en une solution de téléchargement "intelligente" :
 Fonctionnalité, Détail Technique, Bénéfice
Verbose Natif ,Intégration de curl -v, Détails de connexion et de transfert en temps réel.
Fallback Auto, Détection d'erreur 33 / Accept-Ranges, Relance un téléchargement complet si la reprise est impossible.
SSL Insecure, Option -i (curl -k), Permet de télécharger sur des serveurs avec certificats invalides.
Suivi Redirection, Option -L, Suit automatiquement les redirections HTTP/HTTPS.
Sécurité Boucle, --max-redirs 10, la taille finale pour vérifier l'intégrité du fichier.

Guide d'Utilisation
1. Préparation des droits
   Avant toute chose, rendez vos scripts exécutables :
   Bash: chmod +x *.sh
2. Exécution ciblée
 Pour lancer une fonctionnalité spécifique (exemple : mode verbeux) :
 Bash: ./commit_verbose.sh
3. Déploiement complet
   Pour enchaîner l'historique complet des commits et tester l'évolution :
   Bash: ./commits_all.sh
 Bonnes Pratiques & Sécurité
Commits Atomiques : Chaque fonctionnalité est isolée pour garantir un historique de projet lisible et facile à maintenir.
Vérification d'Intégrité : Utilisez toujours les logs pour comparer la taille finale du fichier et garantir que le transfert est complet.
Usage de -i (Insecure) :  À utiliser avec parcimonie. L'ignorer les erreurs SSL peut exposer votre machine à des risques de sécurité.
Robustesse Totale : Le système de Fallback automatique assure que vos scripts de téléchargement ne restent jamais bloqués, même si le serveur cible ne supporte pas la reprise de données.
