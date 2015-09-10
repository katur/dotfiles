OS X Setup
==========

This is what I did to set up my computer.

During OS X Installation
------------------------
- did not import any TimeMachine backup
- did log into iCloud
- did not set up iKeychain (will keep using Lastpass for now)
- did encrypt the disk, allowing password recovery through iCloud password

Delete most everything from Dock, adding Terminal only.

System Preferences changes:

- Have dock automatically disappear / reappear

Finder Preferences changes:

- Change what shows up in "favorites" sidebar to include home directory,
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
  - Ensure that LastPass preferences cause logout after closing browser
    and idle time.
- BetterTouchTool*
  - Enable window snapping in preferences
- f.lux*
  - justgetflux.com
- AntiRSI*
  - Free version 2.1 available at: antirsi.onnlucky.com
- Google Drive*
  - Log into Google account
- Dropbox*
  - Log into Dropbox account
- Skype
  - Log into Skype account
- Cisco AnyConnect, for VPN access to NYU network
  - https://nyu.service-now.com/servicelink/kb_search.do?id-KB0011175
- TextWrangler
- SequelPro
  - save connection info for Favorites
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
Create ssh keys (no passphrase for now;
to add later: http://www.cyberciti.biz/faq/howto-ssh-changing-passphrase/):

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

Add SSH public key to SSH Keys in my Github personal settings.


Dot Files
---------
```
sudo gem install homesick
```

### If first time using homesick
Create new repo in Github called `dotfiles`, with just a README.

Clone the repo:

```
homesick clone katur/dotfiles
```

Edit ~/.homesick/repos/dotfiles/.git/config to use the ssh instead of http
URL for connecting (can find this URL on Github)

Create directory to hold the dotfiles that will be symlinked in ~:

```
mkdir ~/.homesick/repos/dotfiles/home
```

Add .bash_profile and .bashrc files to ~/.homesick/repos/dotfiles/home. Commit
and push changes.

Create the symlinks in ~:

```
homesick symlink dotfiles
```

Confirm that the bash settings now work (if not, try restarting Terminal).

Move the global git config file and vim config directories, too:

```
mv ~/.gitconfig ~/.homesick/repos/dotfiles/home/
mv ~/.vim ~/.homesick/repos/dotfiles/home/
homesick symlink dotfiles
```

To .gitignore in the dotfiles repo, add `*.netrwhist` (some vim log file).

Install pathogen as a git submodule
(see http://www.tedreed.info/setup/2012/03/30/pathogen-and-plugins/):

```
cd ~/.homesick/repos/dotfiles
git submodule add https://github.com/tpope/vim-pathogen.git home/.vim/bundle/vim-pathogen
```

Per the Pathogen FAQ, do this to keep tags files out of repo:

```
git config --global core.excludesfile '~/.cvsignore'
echo tags >> ~/.cvsignore
```

To start Pathogen, add these to .vimrc:

```
runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()
```

### If already have a homesick repo
Follow same steps to clone the repo and to use ssh instead of http.

If the repo contains a git config file redundant with or better
than that at ~/.gitconfig, will *probably* have to do something like:

```
rm ~/.gitconfig
rm ~/.vim
```

(The same goes for any other dotfiles that already exist on the computer)

Now create the symlinks:

```
homesick symlink dotfiles
```


Homebrew
--------
```
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```


Python
------
See https://github.com/Homebrew/homebrew/blob/master/share/doc/homebrew/Homebrew-and-Python.md

```
brew install python
pip install --upgrade pip setuptools
pip install virtualenv
pip install virtualenvwrapper
```

Confirm virtualenvwrapper config is in .bashrc:

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
such that they use python3 instead of python (2), despite the fact that
these files exist in python2 directories. This is a known issue:
https://github.com/Homebrew/homebrew/issues/25752
So, since I do not need Python 3 right now anyway, I uninstalled the brewed
pythons and packages, and started over, brewing only python (2).


MySQL
-----
```
brew install mysql
```

Have mysql start on startup:

```
ln -sfv /usr/local/opt/mysql/*.plist ~/Library/LaunchAgents
```

Run script for setting a root password (and some other setup):

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
