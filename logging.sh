# Parsing de l'option -l
while getopts ":vcl:" opt; do
  case $opt in
    l) LOGFILE=$OPTARG ;;
    # autres options...
  esac
done

# Fonction de log centralisée
log() {
    local msg=$1
    echo "$msg"
    if [ -n "$LOGFILE" ]; then
        echo "$(date '+%Y-%m-%d %H:%M:%S') - $msg" >> "$LOGFILE"
    fi
}
