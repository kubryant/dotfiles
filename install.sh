# This script will install oh-my-zsh,
# copy .zshrc, .vimrc, and themes

if [ -d ~/.oh-my-zsh ]; then
	echo "Oh-my-zsh already installed. Skipping to the next step!"
else
	sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

echo "Copying .zshrc and oh-my-zsh theme to ~"
cp -i ./zsh/.zshrc ~
cp -i ./zsh/.tmux.conf ~
cp -ir ./zsh/themes/* ~/.oh-my-zsh/themes 

echo "Copying .vimrc and .vim to ~"
cp -i ./vim/.vimrc ~
if [ ! -d ~/.vim ]; then
	mkdir ~/.vim
fi
cp -ir ./vim/bundle ~/.vim
cp -ir ./vim/colors ~/.vim
cp -ir ./vim/scripts ~/.vim
cp -ir ./vim/UltiSnips ~/.vim

echo "Installing Pathogen"
# pathogen
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

if hash brew 2>/dev/null; then
    brew install the_silver_searcher
else
	echo "brew is not installed"
	echo "install brew and run these commands manually"
	echo "brew install the_silver_searcher"
fi

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
