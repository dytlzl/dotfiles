install:
	cp ./vimrc ~/.vimrc

diff:
	@diff ~/.vimrc ./vimrc || :

clean:
	rm -rf ~/.vim ~/.vimrc
