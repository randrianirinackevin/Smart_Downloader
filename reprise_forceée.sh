# Parsing de l'option -c
while getopts ":vcl:" opt; do
  case $opt in
    c) FORCE_RESUME=true ;;
    # autres options...
  esac
done

# Utilisation dans la fonction de téléchargement
if $FORCE_RESUME; then
    curl -C - -o "$dest" "$url"
else
    curl -o "$dest" "$url"
fi
