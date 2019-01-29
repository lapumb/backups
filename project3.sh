#! /bin/bash
#Blake Lapum, Project 3, CIS-241 02, Fall 2018


#checks if arguments provided, if not, send error message
if test $# -eq 0
then
	echo "Must provide at least one argument!"
	exit 1
fi


#checking if backup is already created in home directory
#if not, create it
if test -d ~/backup
then
	#do nothing
	echo "Directory 'backup' already exists in the home directory"

else
	mkdir ~/backup 
fi


#Copying fileTargetList to backup directory (files and directories allowed)
#files / directories that do not exist need to be stated
for var in "$@"
do
	if [ $var != "-c" ] && [ $var != "-l" ] && [ $var != "--help" ] #checking if the command is not these
	then
		if test -f $var #checking if the file actually exists
		then

			cp $var ~/backup #if so, copy to backup directory

		elif test -d $var #checking if is a directory
		then
			cp -R $var ~/backup #if so, copy to backup directory

		else
			echo "$var does not exist" #otherwise, throw an error in saying it doesnt exist

		fi

	else
		break #once a command is hit, exit so no other files after commands are copied
	fi
done


#checking for each of the options, then executing whichever one
for var in "$@"
do
	if test $var == "-c"
	then 
		echo "Number of files / directories: $(ls ~/backup |wc -l)"
		echo "Amount of bytes consumed:"
		echo "$(du -b ~/backup)"
	
	elif test $var == "-l"
	then
		echo "Files and directories in backup subdirectory: "
		echo "$(ls ~/backup)"	

	elif test $var == "--help"
	then
		echo "Run this script by using the format: ./backup file1 file2 file3 test -c -l --help"
		echo "-c option shows the number of files and directories in the backup subdirectory, and how many bytes they consume"
		echo "-l lists files and directories in the backup subdirectory"
		echo "--help gives a brief discription of how to run the script and what each option does"

	fi
done
