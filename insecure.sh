# --- Gestion de l'option insecure (-i) ---

# Variable par défaut
INSECURE=false

# Parsing de l'option -i
while getopts ":i" opt; do
  case $opt in
    i) INSECURE=true ;;
  esac
done

shift $((OPTIND -1))

# Ajout de l'option wget/curl selon besoin
WGET_OPTS=()
CURL_OPTS=()

$INSECURE && WGET_OPTS+=("--no-check-certificate")
$INSECURE && CURL_OPTS+=("-k")

# Exemple d’utilisation :
# wget -O "$DEST" "$URL" "${WGET_OPTS[@]}"
# ou
# curl -o "$DEST" "$URL" "${CURL_OPTS[@]}"
