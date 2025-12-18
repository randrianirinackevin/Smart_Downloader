#!/bin/bash
# Smart Downloader
# Auteur : Ckevin
# Description : Télécharge un fichier depuis une URL avec reprise et vérification

# Vérification des arguments
if [ $# -lt 1 ]; then
    echo "Usage: $0 <URL> [destination]"
    exit 1
fi

URL=$1
DEST=${2:-$(basename "$URL")}   # Si pas de destination, nom du fichier original

# Fonction de téléchargement
download_file() {
    local url=$1
    local dest=$2

    echo "Téléchargement de $url vers $dest ..."
    # -c permet de reprendre un téléchargement interrompu
    curl -C - -o "$dest" "$url"

    # Vérification du succès
    if [ $? -eq 0 ]; then
        echo "[OK] Téléchargement terminé : $dest"
    else
        echo "[ERREUR] Échec du téléchargement"
        exit 1
    fi
}

# Vérification si le fichier existe déjà
if [ -f "$DEST" ]; then
    echo "Le fichier $DEST existe déjà."
    read -p "Voulez-vous reprendre le téléchargement ? (o/n) " choix
    case $choix in
        o|O) download_file "$URL" "$DEST" ;;
        n|N) echo "Opération annulée." ; exit 0 ;;
        *) echo "Réponse invalide." ; exit 1 ;;
    esac
else
    download_file "$URL" "$DEST"
fi
