#!/bin/bash
# Smart Downloader v5 (avec limite de redirections)
# Auteur : Votre Nom
# Description : Télécharge un fichier depuis une URL avec reprise, mode verbeux, log, option SSL insecure et suivi des redirections limité

# Affichage de l'aide
usage() {
    echo "Usage: $0 [-v] [-c] [-l logfile] [-i] <URL> [destination]"
    echo "Options:"
    echo "  -v            Mode verbeux (affiche plus de détails)"
    echo "  -c            Force la reprise du téléchargement"
    echo "  -l <logfile>  Sauvegarde les logs dans un fichier"
    echo "  -i            Ignore les erreurs SSL (insecure)"
    exit 1
}

# Variables par défaut
VERBOSE=false
FORCE_RESUME=false
INSECURE=false
LOGFILE=""

# Parsing des options
while getopts ":vcl:i" opt; do
  case $opt in
    v) VERBOSE=true ;;
    c) FORCE_RESUME=true ;;
    l) LOGFILE=$OPTARG ;;
    i) INSECURE=true ;;
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

    # Construction des options curl
    CURL_OPTS=("-L" "--max-redirs" "10")   # suivre les redirections, max 10
    $VERBOSE && CURL_OPTS+=("-v")
    $INSECURE && CURL_OPTS+=("-k")

    if $FORCE_RESUME; then
        curl -C - -o "$dest" "$url" "${CURL_OPTS[@]}"
        status=$?
        if [ $status -eq 33 ]; then
            log "[INFO] Le serveur ne supporte pas la reprise, téléchargement complet..."
            curl -o "$dest" "$url" "${CURL_OPTS[@]}"
            status=$?
        fi
    else
        curl -o "$dest" "$url" "${CURL_OPTS[@]}"
        status=$?
    fi

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
    log "Mode insecure SSL : $INSECURE"
    [ -n "$LOGFILE" ] && log "Logs enregistrés dans : $LOGFILE"
fi
