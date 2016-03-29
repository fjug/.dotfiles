" my filetype cg
if exists("did_load_filetypes")
	finish
endif
augroup filetypedetect
	au! BufRead,BufNewFile *.cg		setfiletype cg
	au! BufRead,BufNewFile *.fx		setfiletype cg
	au! BufRead,BufNewFile *.txx	setfiletype cpp
	au! BufRead,BufNewFile *.cu		setfiletype cpp
augroup END

