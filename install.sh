git submodule init
git submodule sync
git submodule update
ln -fs $PWD/.vimrc $HOME/.vimrc
vim +PluginInstall +qall
