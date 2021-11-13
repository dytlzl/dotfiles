install:
	cp -r ./.vimrc ~
	mkdir -p ~/.vim/dein
	cp ./vim/dein/plugins.toml ~/.vim/dein
	curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
	sh ./installer.sh ~/.vim/dein
	vim -c 'call dein#install()'
