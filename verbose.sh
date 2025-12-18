# Parsing de l'option -v
while getopts ":vcl:" opt; do
  case $opt in
    v) VERBOSE=true ;;
    # autres options...
  esac
done

# Bloc verbeux à la fin du script
if $VERBOSE; then
    log "Infos supplémentaires :"
    log "URL : $URL"
    log "Destination : $DEST"
    log "Reprise forcée : $FORCE_RESUME"
    [ -n "$LOGFILE" ] && log "Logs enregistrés dans : $LOGFILE"
fi
