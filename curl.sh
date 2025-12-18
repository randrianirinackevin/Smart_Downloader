CURL_OPTS=()
$VERBOSE && CURL_OPTS+=("-v")
$INSECURE && CURL_OPTS+=("-k")
CURL_OPTS+=("-L")   # suivre les redirections
