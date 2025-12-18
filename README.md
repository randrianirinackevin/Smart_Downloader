Script de Téléchargement

Présentation

Ce projet est un script de téléchargement basé sur curl, conçu pour gérer efficacement les transferts de fichiers avec reprise, logs et options avancées. L’évolution du projet entre la version v2 et la version v3 apporte de nombreuses améliorations en termes de robustesse, sécurité et traçabilité.

Fonctionnalités de la v2
La version v2 posait les bases du script avec les options essentielles :

Options disponibles :

-v → mode verbeux (affiche des infos supplémentaires en fin de script).

-c → reprise forcée du téléchargement (curl -C -).

-l <logfile> → enregistre les logs dans un fichier.

Vérification de l’existence du fichier avant téléchargement, avec question interactive pour reprendre ou non.

Fonction log() qui écrit à l’écran et dans le fichier log.

Téléchargement simple via curl -o.


Fonctionnalités ajoutées (v7)
1. Mode verbeux intégré à curl
Passage de l’option -v à un usage natif de curl -v.

Affiche directement les détails de connexion et transfert.

2. Fallback automatique si reprise impossible
Si le serveur ne supporte pas la reprise (code 33 ou absence de Accept-Ranges), le script relance un téléchargement complet.

3. Option -i pour SSL insecure
Ajout de l’option -i qui utilise curl -k.

Permet d’ignorer les erreurs SSL (utile pour serveurs avec certificats invalides).

4. Suivi des redirections
Ajout de -L pour suivre automatiquement les redirections HTTP/HTTPS.

5. Limite de redirections
Ajout de --max-redirs 10 pour éviter les boucles infinies.

Avant, curl pouvait suivre jusqu’à 50 redirections.

6. Logs enrichis
Ajout de la taille finale du fichier téléchargé (stat -c%s).

Permet de vérifier l’intégrité et la complétude du téléchargement.


Utilisation
1.Donne les droits d’exécution aux scripts :

bash
chmod +x *.sh

2.Lance un commit spécifique :

bash
./commit_verbose.sh

3.Ou enchaîne tous les commits :

bash
./commits_all.sh

Bonnes pratiques

Commits atomiques : chaque fonctionnalité doit être isolée pour un historique lisible.

Logs complets : toujours vérifier la taille finale du fichier pour garantir l’intégrité.

Sécurité : utiliser -i uniquement si nécessaire (SSL insecure peut exposer à des risques).

Robustesse : le fallback automatique assure la continuité même si la reprise n’est pas supportée.

