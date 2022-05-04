#!/bin/sh
### Configuration des accès via proxy web (système env, apt, svn, git, npm, wget, docker).

#	NO_PROXY=localhost,127.0.0.0/8,::1,192.168.0.0/16
#	no_proxy=localhost,127.0.0.0/8,::1,192.168.0.0/16
#	export NO_PROXY
#	export no_proxy

OPT_HTTPS=
OPT_HTTP=
OPT_HOST=
OPT_PORT=3128
OPT_NONE=

CFG_ENV="/etc/profile.d/tic_proxy.sh"
CFG_APT="/etc/apt/apt.conf.d/99HttpProxy"
CFG_SVN="/etc/subversion/servers"
CFG_DKC="/home/root/.docker/config.json"
CFG_DKD="/etc/systemd/system/docker.service.d/http-proxy.conf"
CFG_WGET="/etc/wgetrc"


########################################################### ARGS

usage() {
	printf "\nUsage: ${0} [-y] [--http|--https] <host[:port]> [-p <port>]" >&2
	printf "\n   ou: ${0} [-y] [--http|--https] --none\n\n" >&2
	printf "  -H, --host    :  Adresse IP du serveur proxy\n"
	printf "  -p, --port    :  Port du serveur proxy (défaut: ${OPT_PORT})\n"
	printf "      --none    :  Désactivation de la configuration de serveur proxy\n"
	printf "      --http    :  Configuration pour les requêtes HTTP (défaut HTTP+HTTPS)\n"
	printf "      --https   :  Configuration pour les requêtes HTTPS (défaut HTTP+HTTPS)\n"
	printf "  -y, --yes     :  Désactivation des demandes de confirmation du script !\n"
	printf "  -A, --no-ansi :  Désactivation de la coloration pour les messages du script\n"
	printf "  -h, --help    :  Affichage de ce message d'aide\n"
	printf "\nExemples:"
	printf "\n\t${0} -H 192.168.0.1 -p 1080"
	printf "\n\t${0} 192.168.0.1:8080 --http"
	printf "\n\t${0} --https --none"
	printf "\n\n"
	exit 1
}

### Analyse des paramètres de la ligne de commande
[ $# -eq 0 ] && usage
while [ $# -gt 0 ]; do
	case "${1}" in
		-h | --help    ) usage ;;
		-A | --no-ansi ) OPT_NOANSI='yep' ;;
		-y | --yes     ) OPT_FORCE='yep'  ;;
		     --https   ) OPT_HTTPS='https' ;;
		     --http    ) OPT_HTTP='http'   ;;
		     --none    ) OPT_NONE='yep'    ;;
		-H | --host    ) [ $# -lt 2 ] && usage; OPT_HOST="${2}"; shift ;;
		-p | --port    ) [ $# -lt 2 ] && usage; OPT_PORT="${2}"; shift ;;
		-- ) shift; break ;;
		-* ) printf "\n*** Option inconnue '%s' !\n\n" "${1}" >&2; usage ;;
		*  ) [ -z "${OPT_HOST}" ] || usage; OPT_HOST="${1}" ;;
	esac
	shift
done
[ $# -gt 0 -a -z "${OPT_HOST}" ] && OPT_HOST="${1}" && shift
[ $# -gt 0 ] && usage


########################################################### UTIL

COL_NORM=""; COL_BOLD=""; COL_HEAD=""; COL_INFO=""; COL_CALL=""; COL_WARN="" COL_CRIT=""; COL_DONE=""
if [ -z "${OPT_NOANSI}" ]; then
	COL_NORM="\033[0;00m"   # default
	COL_BOLD="\033[1m"      # bold
	COL_HEAD="\033[1;36m"   # cyan
	COL_INFO="\033[1;34m"   # blue
	COL_CALL="\033[1;35m"   # purple
	COL_WARN="\033[1;33m"   # yellow
	COL_CRIT="\033[1;31m"   # red
	COL_DONE="\033[1;32m"   # green
fi

tic_title() {
	printf "\n${COL_HEAD}###\n### %s\n###\n${COL_NORM}" "${1}"
}
tic_tellme() {
	printf "\n${COL_INFO}=== %s${COL_NORM}\n" "${1}"
}
tic_warnme() {
	printf "\n${COL_WARN}  * %s !${COL_NORM}\n" "${1}" >&2
}
tic_notice() {
	printf "  ${COL_BOLD}- %s${COL_NORM}\n" "${1}"
}
tic_itemize() {
	[ -z "${TIC_ITEMIZE_COLS}" ] && TIC_ITEMIZE_COLS=20
	printf "  ${COL_BOLD}- %-${TIC_ITEMIZE_COLS}s\t:${COL_NORM}\t%s\n" "${1}" "${2}"
}

tic_success() {
	TIC_MESSAGE="${1}"; [ -z "${TIC_MESSAGE}" ] && TIC_MESSAGE="Succès"
	printf "\n${COL_DONE}  > %s.${COL_NORM}\n" "${TIC_MESSAGE}"
}
tic_failed() {
	TIC_MESSAGE="${1}"; [ -z "${TIC_MESSAGE}" ] && TIC_MESSAGE="Échec"
	printf "\n${COL_CRIT}  * %s !${COL_NORM}\n" "${TIC_MESSAGE}" >&2
}

tic_abort() {
	TIC_MESSAGE="${1}"; [ -z "${TIC_MESSAGE}" ] && TIC_MESSAGE="Abandon"
	printf "\n${COL_INFO}### %s.${COL_NORM}\n\n" "${TIC_MESSAGE}"
	[ -n "${2}" ] && exit "${2}" ; exit 2
}
tic_error() {
	TIC_MESSAGE="${1}"; [ -z "${TIC_MESSAGE}" ] && TIC_MESSAGE="Erreur"
	printf "\n${COL_CRIT}*** %s !${COL_NORM}\n\n" "${TIC_MESSAGE}" >&2
	[ -n "${2}" ] && exit "${2}" ; exit 2
}

tic_confirm() {
	[ -n "${OPT_FORCE}" ] && return
	TIC_MESSAGE="${1}"; [ -z "${TIC_MESSAGE}" ] && TIC_MESSAGE="Confirmation"
	printf "${COL_CALL}>>> %s ?${COL_NORM}" "${TIC_MESSAGE}"
	read -p " (o|N|q) " TIC_RESPONSE
	[ "x${TIC_RESPONSE}" = "xq" ] && tic_abort
	[ "x${TIC_RESPONSE}" = "xo" -o "x${TIC_RESPONSE}" = "xy" ] && return 0
	return 1
}


########################################################### CONF

echo "${OPT_HOST}" | grep '^[^:]*:[0-9]\+$' -q
if [ $? -eq 0 ]; then
	OPT_PORT="$(echo "${OPT_HOST}" | cut -d':' -f2)"
	OPT_HOST="$(echo "${OPT_HOST}" | cut -d':' -f1)"
fi

if [ -z "${OPT_NONE}" ]; then
	[ -z "${OPT_HOST}" ] && tic_error "Adresse IP du serveur proxy non spécifiée"
	[ -z "${OPT_PORT}" ] && tic_error "Port du serveur proxy non spécifié"
fi

[ -z "${OPT_HTTP}" -a -z "${OPT_HTTPS}" ] && OPT_HTTP='http' && OPT_HTTPS='https'


tic_title "Configuration des accès via proxy :"
if [ -z "${OPT_NONE}" ]; then
	tic_itemize "Proxy host"  "${OPT_HOST}"
	tic_itemize "Proxy port"  "${OPT_PORT}"
else
	tic_itemize "Proxy host"  "aucun"
	tic_itemize "Proxy port"  "-"
fi
	tic_itemize "Protocoles"  "${OPT_HTTP} ${OPT_HTTPS}"
tic_confirm || tic_abort


########################################################### SUB ENV

do_config_env() {
	[ -d "$(dirname "${CFG_ENV}")" ] || return 0
	tic_tellme "Configuration du proxy dans l'environnement..."
	tic_confirm || return 1
	
	[ -f "${CFG_ENV}" ] || printf "### Configuration du proxy web\n\n" > "${CFG_ENV}"
	
	## variable http_proxy ?
	grep -q "^export http_proxy=http://${OPT_HOST}:${OPT_PORT}\s*\$" "${CFG_ENV}"
	if [ $? -ne 0 -a -n "${OPT_HTTP}" ]; then
		sed  '/^export http_proxy/Id'                               -i "${CFG_ENV}"  # supprime
		sed 's|^\(export http_proxy\)|#\1|i'                        -i "${CFG_ENV}"  # remplace
		printf "export http_proxy=http://${OPT_HOST}:${OPT_PORT}\n" >> "${CFG_ENV}"
		printf "export HTTP_PROXY=http://${OPT_HOST}:${OPT_PORT}\n" >> "${CFG_ENV}"
	fi
	## variable https_proxy ?
	grep -q "^export https_proxy=http://${OPT_HOST}:${OPT_PORT}\s*\$" "${CFG_ENV}"
	if [ $? -ne 0 -a -n "${OPT_HTTPS}" ]; then
		sed  '/^export https_proxy/Id'                               -i "${CFG_ENV}"  # supprime
		sed 's|^\(export https_proxy\)|#\1|i'                        -i "${CFG_ENV}"  # remplace
		printf "export https_proxy=http://${OPT_HOST}:${OPT_PORT}\n" >> "${CFG_ENV}"
		printf "export HTTPS_PROXY=http://${OPT_HOST}:${OPT_PORT}\n" >> "${CFG_ENV}"
	fi
	
	## affichage de la configuration
	tic_notice "Configuration dans '${CFG_ENV}' :"
	grep -v '^\s*$' "${CFG_ENV}"
}

do_remove_env() {
	[ -f "${CFG_ENV}" ] || return 0
	tic_tellme "Désactivation du proxy pour l'environnement..."
	tic_confirm || return 1
	
	[ "${OPT_HTTP}"  ] && sed 's|^\(export http_proxy\)|#\1|i'  -i "${CFG_ENV}"  # remplace
	[ "${OPT_HTTPS}" ] && sed 's|^\(export https_proxy\)|#\1|i' -i "${CFG_ENV}"  # remplace
}

########################################################### SUB APT

do_config_apt() {
	[ -d "$(dirname "${CFG_APT}")" ] || return 0
	tic_tellme "Configuration du proxy pour apt..."
	tic_confirm || return 1
	
	## fichier de configuration spécifique
	printf "### [TIC] Proxy configuration\n\n" > "${CFG_APT}"
	printf "Acquire::http::Proxy \"http://${OPT_HOST}:${OPT_PORT}\";\n\n" >> "${CFG_APT}"
	
	## affichage de la configuration
	tic_notice "Configuration dans '${CFG_APT}' :"
	grep -v '^\s*$' "${CFG_APT}"
}

do_remove_apt() {
	[ -f "${CFG_APT}" ] || return 0
	tic_tellme "Désactivation du proxy pour apt..."
	tic_confirm || return 1
	
	sed 's|^\(Acquire::http::Proxy\)|#\1|i' -i "${CFG_APT}"  # remplace
}

########################################################### SUB SVN

do_config_svn() {
	[ -f "${CFG_SVN}" ] || return 0
	tic_tellme "Configuration du proxy pour svn..."
	tic_confirm || return 1
	
	## backup du fichier d'origine (une seule fois)
	[ -f "${CFG_SVN}.orig" ] || cp "${CFG_SVN}" "${CFG_SVN}.orig"
	
	## directive http-proxy-host ?
	grep -q "^http-proxy-host\s*=\s*${OPT_HOST}\s*\$" "${CFG_SVN}"
	if [ $? -ne 0 ]; then
		sed  '/^http-proxy-host/d'                                   -i "${CFG_SVN}"  # supprime
		sed 's|^\(http-proxy-host\)|#\1|'                            -i "${CFG_SVN}"  # remplace
		printf "http-proxy-host = ${OPT_HOST}\n" >> "${CFG_SVN}"
	fi
	## directive http-proxy-port ?
	grep -q "^http-proxy-port\s*=\s*${OPT_PORT}\s*\$" "${CFG_SVN}"
	if [ $? -ne 0 ]; then
		sed  '/^http-proxy-port/d'                                   -i "${CFG_SVN}"  # supprime
		sed 's|^\(http-proxy-port\)|#\1|'                            -i "${CFG_SVN}"  # remplace
		printf "http-proxy-port = ${OPT_PORT}\n" >> "${CFG_SVN}"
	fi
	
	## affichage de la configuration
	tic_notice "Configuration dans '${CFG_SVN}' :"
	grep '^http-proxy' "${CFG_SVN}"
}

do_remove_svn() {
	[ -f "${CFG_SVN}" ] || return 0
	tic_tellme "Désactivation du proxy pour svn..."
	tic_confirm || return 1
	tic_warnme "TODO"
}

########################################################### SUB GIT

do_config_git() {
	which git >/dev/null || return 0
	tic_tellme "Configuration du proxy pour git..."
	tic_confirm || return 1
	
	[ -n "${OPT_HTTP}"  ] && git config --global http.proxy  "http://${OPT_HOST}:${OPT_PORT}"
	[ -n "${OPT_HTTPS}" ] && git config --global https.proxy "http://${OPT_HOST}:${OPT_PORT}"
}

do_remove_git() {
	which git >/dev/null || return 0
	tic_tellme "Désactivation du proxy pour git..."
	tic_confirm || return 1
	
	[ -n "${OPT_HTTP}"  ] && git config --global --unset http.proxy
	[ -n "${OPT_HTTPS}" ] && git config --global --unset https.proxy
}

########################################################### SUB NPM

do_config_npm() {
	which npm >/dev/null || return 0
	tic_tellme "Configuration du proxy pour npm..."
	tic_confirm || return 1
	
	[ -n "${OPT_HTTP}"  ] && npm config set       proxy "http://${OPT_HOST}:${OPT_PORT}"
	[ -n "${OPT_HTTPS}" ] && npm config set https-proxy "http://${OPT_HOST}:${OPT_PORT}"
}

do_remove_npm() {
	which npm >/dev/null || return 0
	tic_tellme "Désactivation du proxy pour npm..."
	tic_confirm || return 1
	
	[ -n "${OPT_HTTP}"  ] && npm config delete       proxy
	[ -n "${OPT_HTTPS}" ] && npm config delete https-proxy
}

########################################################### SUB WGET

do_config_wget() {
	[ -f "${CFG_WGET}" ] || return 0
	tic_tellme "Configuration du proxy pour wget..."
	tic_confirm || return 1
	
	## backup du fichier d'origine (une seule fois)
	[ -f "${CFG_WGET}.orig" ] || cp "${CFG_WGET}" "${CFG_WGET}.orig"
	## ajout d'une section (si aucun paramètrage de proxy)
	grep -q '^[^#]*proxy' "${CFG_WGET}" || printf "\n\n###\n### [TIC] Proxy configuration\n###\n" >> "${CFG_WGET}"
	
	## directive use_proxy ?
	grep -q '^use_proxy\s*=\s*on\s*$' "${CFG_WGET}"
	if [ $? -ne 0 ]; then
		sed  '/^use_proxy/d'        -i "${CFG_WGET}"  # supprime
		sed 's|^\(use_proxy\)|#\1|' -i "${CFG_WGET}"  # remplace
		printf "use_proxy = on\n"   >> "${CFG_WGET}"
	fi
	## directive http_proxy ?
	grep -q "^http_proxy\s*=\s*http://${OPT_HOST}:${OPT_PORT}/\s*\$" "${CFG_WGET}"
	if [ $? -ne 0 -a -n "${OPT_HTTP}" ]; then
		sed  '/^http_proxy/d'                                   -i "${CFG_WGET}"  # supprime
		sed 's|^\(http_proxy\)|#\1|'                            -i "${CFG_WGET}"  # remplace
		printf "http_proxy = http://${OPT_HOST}:${OPT_PORT}/\n" >> "${CFG_WGET}"
	fi
	## directive https_proxy ?
	grep -q "^https_proxy\s*=\s*http://${OPT_HOST}:${OPT_PORT}/\s*\$" "${CFG_WGET}"
	if [ $? -ne 0 -a -n "${OPT_HTTPS}" ]; then
		sed  '/^https_proxy/d'                                   -i "${CFG_WGET}"  # supprime
		sed 's|^\(https_proxy\)|#\1|'                            -i "${CFG_WGET}"  # remplace
		printf "https_proxy = http://${OPT_HOST}:${OPT_PORT}/\n" >> "${CFG_WGET}"
	fi
	
	## affichage de la configuration
	tic_notice "Configuration dans '${CFG_WGET}' :"
	grep '^[^#][a-z]*_proxy' "${CFG_WGET}"
}

do_remove_wget() {
	[ -f "${CFG_WGET}" ] || return 0
	tic_tellme "Désactivation du proxy pour wget..."
	tic_confirm || return 1
	
	[ -n "${OPT_HTTP}" -a -n "${OPT_HTTPS}" ] && sed 's|^\(use_proxy\s*=\s*on\)|#\1|' -i "${CFG_WGET}"
	[ "${OPT_HTTP}"  ] && sed 's|^\(http_proxy\)|#\1|'  -i "${CFG_WGET}"  # remplace
	[ "${OPT_HTTPS}" ] && sed 's|^\(https_proxy\)|#\1|' -i "${CFG_WGET}"  # remplace
}

########################################################### SUB DOCKER

### https://docs.docker.com/network/proxy/
do_config_docker() {
	which docker >/dev/null || return 0
	tic_tellme "Configuration du proxy pour docker..."
	tic_confirm || return 1
	
	### https://www.thegeekdiary.com/how-to-configure-docker-to-use-proxy/
	find "/etc/" -name 'docker.service' | grep -q .
	if [ $? -eq 0 ]; then
		DIR_DKD="$(dirname "${CFG_DKD}")"
		[ -d "${DIR_DKD}" ] || mkdir -p "${DIR_DKD}"
		[ -f "${CFG_DKD}" ] || printf "### Configuration du proxy web\n\n[Service]\n" > "${CFG_DKD}"
		
		## variable http_proxy ?
		grep -q "^Environment=\"HTTP_PROXY=http://${OPT_HOST}:${OPT_PORT}\"\s*\$" "${CFG_DKD}"
		if [ $? -ne 0 -a -n "${OPT_HTTP}" ]; then
			sed  '/^Environment=\"http_proxy/Id'                                 -i "${CFG_DKD}"  # supprime
			sed 's|^\(Environment=\"http_proxy\)|#\1|i'                          -i "${CFG_DKD}"  # remplace
			printf "Environment=\"http_proxy=http://${OPT_HOST}:${OPT_PORT}\"\n" >> "${CFG_DKD}"
			printf "Environment=\"HTTP_PROXY=http://${OPT_HOST}:${OPT_PORT}\"\n" >> "${CFG_DKD}"
		fi
		## variable https_proxy ?
		grep -q "^Environment=\"HTTPS_PROXY=http://${OPT_HOST}:${OPT_PORT}\"\s*\$" "${CFG_DKD}"
		if [ $? -ne 0 -a -n "${OPT_HTTPS}" ]; then
			sed  '/^Environment=\"https_proxy/Id'                                 -i "${CFG_DKD}"  # supprime
			sed 's|^\(Environment=\"https_proxy\)|#\1|i'                          -i "${CFG_DKD}"  # remplace
			printf "Environment=\"https_proxy=http://${OPT_HOST}:${OPT_PORT}\"\n" >> "${CFG_DKD}"
			printf "Environment=\"HTTPS_PROXY=http://${OPT_HOST}:${OPT_PORT}\"\n" >> "${CFG_DKD}"
		fi
		
		## affichage de la configuration
		tic_notice "Configuration dans '${CFG_DKD}' :"
		grep -v '^\s*$' "${CFG_DKD}"
		systemctl daemon-reload
		systemctl is-active --quiet docker 2>/dev/null && systemctl restart docker
	fi
}

do_remove_docker() {
	which docker >/dev/null || return 0
	tic_tellme "Désactivation du proxy pour docker..."
	tic_confirm || return 1
	
	if [ -f "${CFG_DKD}" ]; then
		sed 's|^\(Environment=\"http_proxy\)|#\1|i'  -i "${CFG_DKD}"  # remplace
		sed 's|^\(Environment=\"https_proxy\)|#\1|i' -i "${CFG_DKD}"  # remplace
		systemctl daemon-reload
		systemctl is-active --quiet docker 2>/dev/null && systemctl restart docker
	fi
}


########################################################### MAIN

if [ -z "${OPT_NONE}" ]; then
	do_config_env
	do_config_apt
	do_config_svn
	do_config_git
	do_config_npm
	do_config_wget
	do_config_docker
else
	do_remove_env
	do_remove_apt
	do_remove_svn
	do_remove_git
	do_remove_npm
	do_remove_wget
	do_remove_docker
fi

tic_warnme "Pour un usage immédiat dans le shell courant, taper la ligne suivante"
printf ". /etc/profile\n\n"

