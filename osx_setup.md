OS X Setup
==========

This is what I did to set up my Mac.

During OS X Installation
------------------------
- did not import any TimeMachine backup
- did log into iCloud
- did not set up iKeychain (will keep using Lastpass for now)
- did encrypt the disk, allowing password recovery through iCloud password

Remove most everything from the Dock, adding Terminal only.

System Preferences changes:

- Set the Dock to automatically disappear / reappear

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
- BetterTouchTool*
  - Enable window snapping in preferences
- [f.lux](justgetflux.com)*
- AntiRSI*
  - [Version 2.1 is free](antirsi.onnlucky.com)
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

*These apps should start on system login, which can be set at
System Preferences > Users & Groups > Login Items


Terminal / OS X Command Line Tools
----------------------------------
Edit Terminal preferences for black background, 13pt font, rows and
cols to fill screen

Download and install OS X Command Line Tools (to get here, follow
instructions on prompt that appears during git init attempt)


SSH
---
Create SSH keys (no passphrase for now; to add later, [see this](http://www.cyberciti.biz/faq/howto-ssh-changing-passphrase/)):

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

#### If setting uip homesick for the first time
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

#### If already have a homesick repo
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
#### If setting up homesick for the first time
To prevent committing temporary vim files and logs, make sure these
are present in `~/.homesick/repos/dotfiles/.gitignore`:

```
*.netrwhist
*.swp
```

Add/move `.vimrc` file to `~/.homesick/repos/dotfiles/home`.

Move `~/.vim` to the repo:

```
mv ~/.vim ~/.homesick/repos/dotfiles/home/
homesick symlink dotfiles
```

Install pathogen as a git submodule
(see [this tutorial](http://www.tedreed.info/setup/2012/03/30/pathogen-and-plugins/) and
[this cheatsheet about git submodules in general](http://blog.jacius.info/git-submodule-cheat-sheet/)):

```
cd ~/.homesick/repos/dotfiles
git submodule add https://github.com/tpope/vim-pathogen.git home/.vim/bundle/vim-pathogen
```

Per the [pathogen FAQ](https://github.com/tpope/vim-pathogen/blob/master/README.markdown#faq),
do the following to keep `tags` files out of repo:

```
git config --global core.excludesfile '~/.cvsignore'
echo tags >> ~/.cvsignore
```

To start pathogen, add these to `~/.vimrc`:

```
runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()
```

Install ctrlp as a git submodule:

```
cd ~/.homesick/repos/dotfiles
git submodule add https://github.com/kien/ctrlp.vim.git home/.vim/bundle/ctrlp
```

#### If already have a homesick repo
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
pip install virtualenv
pip install virtualenvwrapper
```

Confirm necessary virtualenvwrapper config is in `~/.bashrc`:

```
export WORKON_HOME=$HOME/.virtualenvs
source /usr/local/bin/virtualenvwrapper.sh
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
