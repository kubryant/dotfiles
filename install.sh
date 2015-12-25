# This script will install oh-my-zsh,
# copy .zshrc, .vimrc, and themes,
# and then install all vim plugins

if [ -d ~/.oh-my-zsh ]; then
	echo "Oh-my-zsh already installed. Skipping to the next step!"
else
	sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

echo "Copying .zshrc and oh-my-zsh theme to ~"
cp -i ./zsh/.zshrc ~
cp -ir ./zsh/themes/* ~/.oh-my-zsh/themes 

echo "Copying .vimrc and .vim to ~"
cp -i ./vim/.vimrc ~
if [ ! -d ~/.vim ]; then
	mkdir ~/.vim
fi
cp -ir ./vim/colors ~/.vim
cp -ir ./vim/scripts ~/.vim

echo "Installing vim plugins"
# pathogen
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# ack.vim
git clone https://github.com/mileszs/ack.vim.git ~/.vim/bundle/ack.vim

# ctrlp.vim
git clone https://github.com/ctrlpvim/ctrlp.vim.git ~/.vim/bundle/ctrlp.vim

# syntastic
git clone https://github.com/scrooloose/syntastic.git ~/.vim/bundle/syntastic

# vim-airline
git clone https://github.com/bling/vim-airline ~/.vim/bundle/vim-airline

# ap/vim-css-color
git clone https://github.com/ap/vim-css-color.git ~/.vim/bundle/vim-css-color

# vim-fugitive
git clone git://github.com/tpope/vim-fugitive.git ~/.vim/bundle/vim-fugitive

# vim-surround
git clone git://github.com/tpope/vim-surround.git ~/.vim/bundle/vim-surround

# beautify.vim
git clone https://github.com/alpaca-tc/beautify.vim.git ~/.vim/bundle/beautify.vim
if hash node 2>/dev/null; then
	npm install -g js-beautify
	npm install -g jq
else
	echo "node is not installed"
	echo "install node and run these commands manually"
	echo "npm install -g js-beautify"
	echo "npm install -g jq"
fi

if hash gem 2>/dev/null; then
	gem install html2haml --pre
	gem install sass
else
	echo "gem is not installed"
	echo "install gem and run these commands manually"
	echo "gem install html2haml --pre"
	echo "gem install sass"
fi

vim -u NONE -c "Helptags" -c q

echo "Everything is done"
echo "Enjoy!"
