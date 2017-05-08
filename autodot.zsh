function _resolve_dot {
	if [[ $LBUFFER =~ "^\.\.$|[/ '\"({\`]\.\.$" ]]; then
		LBUFFER+=/../
	elif [[ $LBUFFER =~ "^\.\./$|[/ '\"({\`]\.\./$" ]]; then
		LBUFFER+=../
	else
		LBUFFER+=.
	fi
}
zle -N _resolve_dot

function _resolve_backspace {
	if [[ $LBUFFER =~ "\.\./\.\./?$" ]]; then
		zle backward-delete-char
		zle backward-delete-char
		zle backward-delete-char
		if [[ $LBUFFER =~ "^\.\./$|[/ '\"({\`]\.\./$" ]]; then
			zle backward-delete-char
		fi
	else
		zle backward-delete-char
	fi
}
zle -N _resolve_backspace

bindkey . _resolve_dot
bindkey '^?' _resolve_backspace
bindkey -M isearch . self-insert
bindkey -M isearch '^?' self-insert
