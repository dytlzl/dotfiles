install:
	cp ./vimrc ~

diff:
	@diff ~/.vimrc ./vimrc || :

clean:
	rm -rf ~/.vim ~/.vimrc
