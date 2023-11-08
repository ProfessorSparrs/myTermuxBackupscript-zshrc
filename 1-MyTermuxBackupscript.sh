#!/bin/bash

echo "This script will backup all important dotfiles in Termux."
echo "Enter 'y' to continue, or anything else to cancel."
read -r user_input

if [ "$user_input" = "y" ]; then
  # Create a backup directory
  echo "Creating backup directory at ~/.dotfiles_backup"
  mkdir ~/.dotfiles_backup

  # Find dotfiles to include in the backup
  dotfiles=`find ~ -maxdepth 1 -type f -name ".*"`

  # Copy dotfiles to the backup directory with progress bar
  echo "Backing up dotfiles to ~/.dotfiles_backup"
  find ~ -maxdepth 1 -type f -name ".*" | pv -l | xargs -I{} cp {} ~/.dotfiles_backup


	echo " Copying  termux ../usr/etc/-folder to ~/.dotfiles_backup"
	cp -rv /data/data/com.termux/files/usr/etc/ ~/.dotfiles_backup
	echo "done"

	echo "backing up /data/data/com.termux/files/usr/share/nano-folder"
	cp -rv /data/data/com.termux/files/usr/share/nano ~/.dotfiles_backup
	cp -rv	 ~/2-source-code 	~/.dotfiles_backup
	cp -rv ~/1-myscripts ~/.dotfiles_backup
	echo "done" 
	
	echo "backing up ~/.oh-my-zsh-folder "
	cp -rv ~/.oh-my-zsh ~/.dotfiles_backup

#	tar czfv   ~/.dotfiles_backup.tar.xz ~/.dotfiles_backup	
#	tar czfv -  ~/.dotfiles_backup | pigz -9 --verbose -j8  > ~/.dotfiles_backup.tar.gz	
  # Print confirmation message
#	tar -I 'pigz -p $(nproc) -12 -v' -cvf ~/.dotfiles_backup.tar.gz ~/.dotfiles_backup 
	tar -cvzf - ~/.dotfiles_backup | pigz -p $(nproc) -9 -v  > ~/dotfiles_backup.tar.gz 
  echo "All dotfiles backed up to ~/.dotfiles_backup" && 
  mv ~/dotfiles_backup.tar.gz	/sdcard/OneplusSyncthing
#  echo "Also Im moving the .gz file to the synchthing-folder in internal storage"
else
  echo "Cancelled."
fi


