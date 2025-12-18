#!/bin/bash
# Smart Downloader v2 (final corrigé)
# Auteur : Votre Nom
# Description : Télécharge un fichier depuis une URL avec reprise, mode verbeux et log

# Affichage de l'aide
usage() {
    echo "Usage: $0 [-v] [-c] [-l logfile] <URL> [destination]"
    echo "Options:"
    echo "  -v            Mode verbeux (affiche plus de détails)"
    echo "  -c            Force la reprise du téléchargement"
    echo "  -l <logfile>  Sauvegarde les logs dans un fichier"
    exit 1
}

# Variables par défaut
VERBOSE=false
FORCE_RESUME=false
LOGFILE=""

# Parsing des options
while getopts ":vcl:" opt; do
  case $opt in
    v) VERBOSE=true ;;
    c) FORCE_RESUME=true ;;
    l) LOGFILE=$OPTARG ;;
    *) usage ;;
  esac
done

# Supprimer les options déjà traitées
shift $((OPTIND -1))

# Vérification des arguments restants
if [ $# -lt 1 ]; then
    usage
fi

URL=$1
DEST=${2:-$(basename "$URL")}

# Fonction de log
log() {
    local msg=$1
    echo "$msg"
    if [ -n "$LOGFILE" ]; then
        echo "$(date '+%Y-%m-%d %H:%M:%S') - $msg" >> "$LOGFILE"
    fi
}

# Fonction de téléchargement
download_file() {
    local url=$1
    local dest=$2

    log "Téléchargement de $url vers $dest ..."

    if $FORCE_RESUME; then
        if $VERBOSE; then
            curl -C - -v -o "$dest" "$url"
        else
            curl -C - -o "$dest" "$url"
        fi
    else
        if $VERBOSE; then
            curl -v -o "$dest" "$url"
        else
            curl -o "$dest" "$url"
        fi
    fi

    local status=$?
    if [ $status -eq 0 ]; then
        log "[OK] Téléchargement terminé : $dest"
        [ -f "$dest" ] && log "Taille finale du fichier : $(stat -c%s "$dest") octets"
    else
        log "[ERREUR] Échec du téléchargement (code $status)"
        exit $status
    fi
}

# Vérification si le fichier existe déjà
if [ -f "$DEST" ] && ! $FORCE_RESUME; then
    log "Le fichier $DEST existe déjà."
    read -p "Voulez-vous reprendre le téléchargement ? (o/n) " choix
    case $choix in
        o|O) download_file "$URL" "$DEST" ;;
        n|N) log "Opération annulée." ; exit 0 ;;
        *) log "Réponse invalide." ; exit 1 ;;
    esac
else
    download_file "$URL" "$DEST"
fi

# Mode verbeux (infos supplémentaires)
if $VERBOSE; then
    log "Infos supplémentaires :"
    log "URL : $URL"
    log "Destination : $DEST"
    log "Mode reprise forcée : $FORCE_RESUME"
    [ -n "$LOGFILE" ] && log "Logs enregistrés dans : $LOGFILE"
fi
