install:
	cp ./vimrc ~/.vimrc
	cp ./tmux.conf ~/.tmux.conf
	cp ./local.bash ~/.local.bash

diff:
	@diff ~/.vimrc ./vimrc || :
	@diff ./tmux.conf ~/.tmux.conf || :
	@diff ./local.bash ~/.local.bash || :

clean:
	rm -rf ~/.vim ~/.vimrc
