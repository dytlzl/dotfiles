install:
	cp ./.vimrc ~
	curl -fLo ~/.vim/autoload/jetpack.vim --create-dirs https://raw.githubusercontent.com/tani/vim-jetpack/master/autoload/jetpack.vim

clean:
	rm -rf ~/.vim ~/.vimrc
