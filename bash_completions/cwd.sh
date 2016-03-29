_cwd()
{
	local cur=${COMP_WORDS[COMP_CWORD]}
	local prev=${COMP_WORDS[COMP_CWORD-1]}

	case "$prev" in
		cwd)
			printf "$(tput dim) please choose...\n"
			if [ "$cur" != "" ]; then
				lwd | grep $cur
			else
				lwd
			fi
			printf "$(tput setaf 2)$(tput bold)??>$(tput sgr 0) $cur"
			COMPREPLY=( $(compgen -W "$(lwd_names)" -- $cur) )
			return 0
			;;

		dwd) 
			printf "$(tput dim) please choose...\n"
			if [ "$cur" != "" ]; then
				lwd | grep $cur
			else
				lwd
			fi
			printf "$(tput setaf 1)$(tput bold)!!!>$(tput sgr 0) $cur"
			COMPREPLY=( $(compgen -W "$(lwd_names)" -- $cur) )
			return 0
			;;
	esac
}
complete -F _cwd cwd
complete -F _cwd go
complete -F _cwd dwd
