OS X Setup
==========

This is what I do to set up my Mac.

During OS X Installation
------------------------
- do not import any TimeMachine backup
- do log into iCloud
- do not set up iKeychain (will keep using Lastpass for now)
- do encrypt the disk, allowing password recovery through iCloud password

Remove most everything from the Dock, adding Terminal only.

System Preferences changes:

- Dock: automatically hide / show
- Date & Time > Clock: 24-hour clock, show day, show date
- Desktop & Screensaver > Desktop: change it to something
- iCloud: select only iCloud Drive and Photos

Finder > Preferences changes:

- Change what shows up in Favorites sidebar to include home directory,
  and change default to home directory
- Show all filename extensions


Apps
----
Download and Install:

- Chrome
  - Make Chrome the default browser (in System Preferences)
  - Log in to Chrome to sync Chrome preferences and extensions
  - Right click on uBlock and uSelect icons to "hide button"
  - In Advanced Settings, change download location to Desktop
  - Ensure that LastPass preferences force logout after closing browser
    and idle time
- Firefox
- BetterTouchTool*
  - Enable window snapping in preferences
- [f.lux](http://justgetflux.com)*
- AntiRSI*
  - [Version 2.1 is free](http://antirsi.onnlucky.com)
- Google Drive*
  - Log into Google account
- Dropbox*
  - Log into Dropbox account
- Skype
  - Log into Skype account
- [Cisco AnyConnect](https://nyu.service-now.com/servicelink/kb_search.do?id-KB0011175),
  for VPN access to NYU network
- TextWrangler
- SequelPro
  - Save connection info for various favorites
- Various printer softwares (first time I hook up to printer)
- Caffeine
  - NOTE: installing from the App Store failed with a mysterious error
    message; perhaps not ready for el capitan. So, do
    [direct download](http://lightheadsw.com/caffeine/) instead.

*These apps should start on system login, which can be set at
System Preferences > Users & Groups > Login Items


Terminal / OS X Command Line Tools
----------------------------------
Edit Terminal preferences for black background, 13pt font, rows and
cols to fill screen, no Audible bell, and unqualified Visual bell.

Download and install OS X Command Line Tools (to get here, follow
instructions on prompt that appears during git init attempt)


SSH
---
Create SSH keys (no passphrase for now; to add later,
[see this](http://www.cyberciti.biz/faq/howto-ssh-changing-passphrase/)):

```
ssh-keygen -t rsa -b 4096 -C "my_email@lemonparty.org"
```

Git
---
Set bare bones global git configuration:

```
git config --global user.name "My Name"
git config --global user.email "my_email@lemonparty.org"
git config --global push.default simple
```

Add SSH public key to SSH Keys in my GitHub personal settings.


Dot Files
---------
```
sudo gem install homesick
```

### *If setting up homesick for the first time*
Create repo in GitHub called `dotfiles`.

Clone the repo:

```
homesick clone katur/dotfiles
```

Edit `~/.homesick/repos/dotfiles/.git/config` to use the SSH URL instead of
the HTTP URL for connecting (can find this URL in the repo on GitHub).

Create directory to hold the files that will be symlinked into `~`:

```
mkdir ~/.homesick/repos/dotfiles/home
```

Add/move `.bash_profile` and `.bashrc` files (or whatever shell configuration
files you want) to `~/.homesick/repos/dotfiles/home`. Commit and push
changes. Then, to create the symlinks into `~`:

```
homesick symlink dotfiles
```

The bash settings should now work properly (if not, try restarting Terminal).

Move the global git config file to the repo, too:

```
mv ~/.gitconfig ~/.homesick/repos/dotfiles/home/
homesick symlink dotfiles
```

### *If already have a homesick repo*
Follow same steps to clone the repo and to use SSH instead of HTTP.

If the repo contains a git config file redundant with or better
than that at `~/.gitconfig`, will *probably* have to do something like:

```
rm ~/.gitconfig
```

(The same goes for any other dotfiles in the repo that already exist
on the computer)

Now create the symlinks:

```
homesick symlink dotfiles
```


Vim
---
### *If setting up homesick for the first time*
To prevent committing temporary vim files and logs, make sure these
are present in `~/.homesick/repos/dotfiles/.gitignore`:

```
*.netrwhist
*.swp
```

Add/move `~/.vimrc` file and `~/.vim` directory to
`~/.homesick/repos/dotfiles/home`, then create the homesick symlinks
(do this right away, before ~/.vim is regenerated):

```
homesick symlink dotfiles
```


#### Define language-specific vim rules
Create ftplugin directory for language-specific vim rules:

```
mkdir ~/.homesick/repos/dotfiles/home/.vim/ftplugin
```

Here is an example Python rules, to put in
`~/.homesick/repos/dotfiles/home/.vim/ftplugin/python.vim`:

```
setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
```


#### Set up Pathogen for vim package management
Install pathogen as a git submodule in the dotfiles repo
(see
[this tutorial](http://www.tedreed.info/setup/2012/03/30/pathogen-and-plugins/)
and
[this cheatsheet about git submodules in general](http://blog.jacius.info/git-submodule-cheat-sheet/)):

```
cd ~/.homesick/repos/dotfiles
git submodule add https://github.com/tpope/vim-pathogen.git home/.vim/bundle/vim-pathogen
```

*NOTE:* if encounter problem with `tags` files changing the pathogen repo,
try the following, per the
[pathogen
FAQ](https://github.com/tpope/vim-pathogen/blob/master/README.markdown#faq)
(I did not do this yet, because I think it is not an issue due to using a
git submodule):

```
git config --global core.excludesfile '~/.cvsignore'
echo tags >> ~/.cvsignore
```

To start pathogen, add these to `~/.vimrc`:

```
runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()
```


#### Get other vim packages
Install other packages as git submodules in the dotfiles repo:

```
cd ~/.homesick/repos/dotfiles
git submodule add https://github.com/kien/ctrlp.vim.git home/.vim/bundle/ctrlp
git submodule add https://github.com/scrooloose/syntastic.git home/.vim/bundle/syntastic
git submodule add https://github.com/plasticboy/vim-markdown.git home/.vim/bundle/vim-markdown
git submodule add https://github.com/kchmck/vim-coffee-script.git home/.vim/bundle/vim-coffee-script
```

To configure Syntastic, add the
[recommended syntastic settings](https://github.com/scrooloose/syntastic#3-recommended-settings)
to .vimrc.

To configure Powerline with improved font, add the following to .vimrc:
```
set laststatus=2
let g:Powerline_symbols = 'fancy'
```

Get a vim-powerline-patched (-glyphed) font, and install it by copying
it into Font Book app. Once installed, change Terminal preferences
to use the font.


### *If already have a homesick repo
Not much should be needed, but make sure to remove any already-present
`~/.vim` or `~/.vimrc` prior to making the symlinks.


Homebrew
--------
Install Homebrew for OS X package management:

```
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```


Python
------
[Here](https://github.com/Homebrew/homebrew/blob/master/share/doc/homebrew/Homebrew-and-Python.md)
is the Homebrew documentation about brewing Python.

```
brew install python
pip install --upgrade pip setuptools
```

*NOTE:* Originally, I installed and upgraded python3 as well:

```
brew install python3
pip3 install --upgrade pip setuptools
```

However, the upgrade command overwrites the default pip and easy_install
such that they use python3 instead of python2, despite the fact that
these files exist in python2 directories.
[This is a known issue.](https://github.com/Homebrew/homebrew/issues/25752)
So, since I do not need Python 3 right now anyway, I uninstalled the brewed
Pythons and packages, and started over, brewing only python2.

Install virtualenv and virtualenvwrapper for creating isolated Python
package environments, and flake8 for syntax and style checking (which I
do in vim with Syntastic):

```
pip install virtualenv
pip install virtualenvwrapper
pip install flake8
```

Confirm virtualenvwrapper config is in `~/.bashrc`:

```
export WORKON_HOME=$HOME/.virtualenvs
source /usr/local/bin/virtualenvwrapper.sh
```


MySQL
-----
```
brew install mysql
```

Have MySQL start on startup:

```
ln -sfv /usr/local/opt/mysql/*.plist ~/Library/LaunchAgents
```

Run this script for setting a root password (and some other setup):

```
mysql_secure_installationd
```

Choose these options:

  - Set root password? [Y/n] Y
  - Remove anonymous users? [Y/n] n
  - Disallow root login remotely? [Y/n] Y
  - Remove test database and access to it? [Y/n] n
  - Reload privilege tables now? [Y/n] Y


Log in as root user to create a dev user:

```
mysql -u root -p
mysql> CREATE USER 'dev'@'localhost' IDENTIFIED BY '<password>';
mysql> GRANT ALL PRIVILEGES ON *.* TO 'dev'@'localhost';
```


Web Dev Stuff (sass, coffee, etc)
---------------------------------
```
sudo gem install sass
brew install node
sudo npm install -g coffee-script@1.9.0
sudo npm install -g gulp
```

Note: there is a bug in coffee-script@1.9.1


After El Capitan update
-----------------------
Restore my ownership of /usr/local
```
sudo chown $(whoami):admin /usr/local && sudo chown -R $(whoami):admin /usr/local
```
