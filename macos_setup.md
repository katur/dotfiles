# macOS Setup

## macOS Installation

- do not import any TimeMachine backup
- do log into iCloud (can do this later from System Preferences)
- do not set up iKeychain (prefer 1Password)
- do encrypt the disk (i.e. FileVault on), and allow password recovery through
  iCloud password (can do this later from System Preferences)


## System Preferences

- Dock: automatically hide / show
- Date & Time > Clock: 24-hour clock, show day, show date
- Desktop & Screensaver > change Desktop to a Muxy photo
- iCloud: select only iCloud Drive, Photos, and Find My Mac
- Keyboard: set Key Repeat and Delay Until Repeat to maximum


## Dock

Remove most everything from the Dock.


## Finder

Show hidden files in Finder:
```
defaults write com.apple.finder AppleShowAllFiles YES
```

Need to restart Finder to see this change (hold option while right-clicking
Finder icon in the dock and click Relaunch)


### Finder > Preferences
- Change what shows up in Favorites sidebar to include home directory,
  and change default to home directory
- Show all filename extensions


## High-Level Applications

### General
- Chrome
  - Make Chrome the default browser (in System Preferences)
  - Log in to Chrome to sync preferences and extensions
  - Right click on uBlock and uSelect (etc) icons to "Hide in Chrome Menu"
  - In Advanced Settings, change download location to Desktop
- 1Password
  - Also install 1Password mini and the Chrome extension
- Other browsers: Firefox, Safari, Opera (including 1Password extensions)

### Communication and file sharing (log in to account / teams)
- [Google Drive - Backup and Sync](https://www.google.com/drive/download/)\*
  - Set up syncing
- [Dropbox](https://www.dropbox.com/install)\*
  - Set up syncing
- [Keybase](https://keybase.io/)\*
- [Slack](https://slack.com/)
- [Screenhero](https://screenhero.com/)\*
- [Skype](https://www.skype.com/en/)

### Programming
- [iTerm2](https://www.iterm2.com/)
  - Import preferences
- [Sublime 3](https://www.sublimetext.com/)
  - Enable `subl` command line tool:
    `ln -s "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" ~/bin/subl`
  - Import preferences
- [SequelPro](https://www.sequelpro.com/)
  - Save connection info for various favorites
- [Postico](https://eggerapps.at/postico/)
  - Save connection info for various favorites
- [Sketch](https://www.sketchapp.com/)
- [Skitch](https://evernote.com/products/skitch)
  - Check options to start Skitch helper at login, and leave it running

### Pleasant things
- [BetterTouchTool](https://www.boastr.net/)\*
  - Allow BTT to "control your computer" in System Preferences > Privacy
  - Enable window snapping (BTT settings)
  - Add license
- [f.lux](https://justgetflux.com)\*
- [KeepingYouAwake](https://github.com/newmarcel/KeepingYouAwake)\*
  - `brew cask install keepingyouawake`
- AntiRSI\*
  - Version 2.1 had been available for free [here](http://antirsi.onnlucky.com),
    but that webpage is no longer loading.

\* These apps should start on system login, which can be set at
System Preferences > Users & Groups > Login Items


## Terminal Preferences

Edit Terminal preferences for black background, 13pt font, rows and
cols to fill screen, no Audible bell, and unqualified Visual bell.

Download a vim-powerline-patched (-glyphed) font, and install it by copying
it into Font Book app. Once installed, change Terminal preferences
to use the font. I got: Droid Sans Mono for Powerline Regular.

TODO: deprecate this section in favor of iTerm


## Command Line Tools

Install macOS Command Line Tools:
```
xcode-select --install
```


## SSH

### *If creating a new keypair*
Create SSH keys (no passphrase for now; to add later,
[see this](http://www.cyberciti.biz/faq/howto-ssh-changing-passphrase/)):
```
ssh-keygen -t rsa -b 4096 -C "my_email@lemonparty.org"
```

### *If copying from another device*
Create ~/.ssh directory if it is not already there. Turn on Remote Login on
the other device, and copy the keypair:
```
rsync -avz <user>@<ip>:~/.ssh/id_rsa.pub .
rsync -avz <user>@<ip>:~/.ssh/id_rsa .
```


## Homebrew

Install Homebrew for OS X package management:
```
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

*NOTE:* After El Capitan update, I could restore my ownership of /usr/local:
```
sudo chown $(whoami):admin /usr/local && sudo chown -R $(whoami):admin /usr/local
```

But now in High Sierra, this is no longer permitted.
So when I need new subdirectories within /usr/local (e.g.
/usr/local/include, /usr/local/Frameworks), I've just done a sudo mkdir
followed by a sudo chown $(whoami):admin.


## GPG

```
brew install gpg
gpg --list-keys
```
This creates dir ~/.gnupg, file ~/.gnupg/gpg.conf, file ~/.gnupg/pubring.gpg,
and file ~/.gnupg/trustdb.gpg

TODO: figure out how to organize keys between gpg and keybase.


## Miscellaneous command line tools

```
brew install pv
brew install tree
```


## Git

Add SSH public key to SSH Keys in my GitHub personal settings.

```
brew install git && brew install bash-completion
```

### *First time config setup (if not in homesick repo)*
```
git config --global user.name "My Name"
git config --global user.email "my_email@lemonparty.org"
git config --global push.default simple
```


## Dotfiles

```
sudo gem install homesick
```

### *If already have a homesick repo*

Clone the repo:
```
homesick clone katur/dotfiles
```

Edit `~/.homesick/repos/dotfiles/.git/config` to use the SSH URL instead of
the HTTP URL for connecting (can find this URL in the repo on GitHub).

Before creating symlinks, remove any dotfiles that will cause conflicts
(e.g. ~/.gitconfig, ~/.bash_profile, ~/.bashrc, etc)

Create the symlinks:
```
homesick symlink dotfiles
```

### *First time homesick setup*

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

First, let's take care of our bash and git configs. Add/move `~/.bash_profile`,
`~/.bashrc`, `~/.gitconfig`, etc (whatever configuration files you want) to
`~/.homesick/repos/dotfiles/home`. Commit and push changes. Then, create the
symlinks into `~`:
```
homesick symlink dotfiles
```

The bash settings should now work properly (if not, try restarting Terminal).

Next, let's take care of our vim config.

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


## Vim

### *First time vim config setup (if not in homesick repo)*

#### Language-specific vim rules
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

#### Vim package management with Pathogen
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
[pathogen FAQ](https://github.com/tpope/vim-pathogen/blob/master/README.markdown#faq)
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


#### Vim packages
Install packages as git submodules in the dotfiles repo:
```
cd ~/.homesick/repos/dotfiles
git submodule add https://github.com/kien/ctrlp.vim.git home/.vim/bundle/ctrlp
git submodule add https://github.com/scrooloose/syntastic.git home/.vim/bundle/syntastic
git submodule add https://github.com/plasticboy/vim-markdown.git home/.vim/bundle/vim-markdown
git submodule add https://github.com/kchmck/vim-coffee-script.git home/.vim/bundle/vim-coffee-script
git submodule add https://github.com/bling/vim-airline home/.vim/bundle/vim-airline
git submodule add https://github.com/scrooloose/nerdtree home/.vim/bundle/nerdtree
```

To configure Syntastic, add the
[recommended syntastic settings](https://github.com/scrooloose/syntastic#3-recommended-settings)
to .vimrc.


## Python

[Here](https://docs.brew.sh/Homebrew-and-Python.html)
is the Homebrew documentation about brewing Python.
```
brew install python2
pip2 install --upgrade pip setuptools
pip2 install --upgrade pip
```

Install virtualenv and virtualenvwrapper for creating isolated Python
package environments, and flake8 for syntax and style checking (which I
do in vim with Syntastic):
```
pip2 install virtualenv
pip2 install virtualenvwrapper
pip2 install flake8
```

Confirm virtualenvwrapper config is in `~/.bashrc`:
```
export WORKON_HOME=$HOME/.virtualenvs
export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python2
source /usr/local/bin/virtualenvwrapper.sh
```


## Ruby

See RMA README.


## MySQL

```
brew install mysql
```

Have MySQL start on startup:
```
ln -sfv /usr/local/opt/mysql/*.plist ~/Library/LaunchAgents
```

Run this script for setting a root password (and some other setup):
```
mysql_secure_installation
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


## Postgres

See RMA README.


## Front-end Web Dev

```
sudo gem install sass
brew install node
sudo npm install -g coffee-script@1.9.0
sudo npm install -g gulp
```

Note: there is a bug in coffee-script@1.9.1


## Jekyll

```
sudo gem install jekyll
```


## Heroku

Download and install
[Heroku Toolbelt for OS X](https://toolbelt.heroku.com/).


## LaTeX

Homebrew does not have LaTeX, and suggests using MacTeX.
Download and install the BasicTeX distribution from
[MaxTeX](https://www.tug.org/mactex).
This is a ~100MB subset of the ~2GB full distribution, without
the GUIs and some other stuff.

Download and install the latest release of
[TeX Live Utility app](http://amaxwell.github.io/tlutility/),
for package management. Use this to require needed packages (e.g. enumitem).


## Java

First installed Eclipse for Java:
http://www.eclipse.org/downloads/download.php?file=/technology/epp/downloads/release/mars/2/eclipse-java-mars-2-macosx-cocoa-x86_64.tar.gz

I also installed the legacy Java 6 runtime, from:
https://support.apple.com/kb/DL1572?locale=en_US

But then I got the error message:
```
Version 1.6.0_65 of the JVM is not suitable for this product.
Version: 1.7 or greater is required
```

And switched to brewing stuff. First I got brew-cask:
```
brew tap caskroom/cask
brew install brew-cask
```

Because this gave the caveat:
```
==> Caveats
You must uninstall this formula. It is no longer needed to stay up to date,
as Homebrew now takes care of that automatically.
```

I did:
```
brew uninstall brew-cask
```

Then the following (which required password to write to
/opt/homebrew-cask/Caskroom):
```
brew cask install java
```

Then I installed jenv:
```
brew install jenv
```

And added the following to .bashrc, to initialize jenv:
```
if which jenv > /dev/null; then eval "$(jenv init -)"; fi
```

Then I added the newly installed java:
```
jenv add /Library/Java/JavaVirtualMachines/jdk1.8.0_92.jdk/Contents/Home/
```


## VirtualBox

Install VirtualBox from https://www.virtualbox.org/wiki/Downloads

Thought I needed the below to use https://github.com/xdissent/ievms/ (but then
got MD5 issues with it, so abandoned after brewing unar):
```
brew install unar
```

Install IE9 (Win7), IE10 (Win7), IE11 (Win81), and Edge (Win10 Stable) from
https://developer.microsoft.com/en-us/microsoft-edge/tools/vms/

Launch VirtualBox and import each by doing File > Import Appliance, and
selecting the .ovf file. From there, the defaults are fine.
