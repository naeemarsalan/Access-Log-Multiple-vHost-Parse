#!/bin/bash
#set -x
file="server.txt"
folder="$(date '+%d-%b-%Y')"
user='anaeem'
mkdir $report
while IFS= read line; do
	mkdir "$folder-$line"
	echo "Copying Data From $line"
	files="$(ssh -i /c/Users/Arsalan.Naeem/.ssh/id_rsa $user@$line 'sudo ls -l /var/log/httpd/' < /dev/null | grep access | awk '{if ($5 != 0) print $9}' | sed '/^$/d')"
	
	for i in $files
	do
		if [ ! -f "$folder-$line"/$i ]
		then
		echo "Downloaded and Parsed $i ...."
		ssh $user@$line "sudo cat /var/log/httpd/$i" > "$folder-$line"/$i
		grep -E -o '(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)' "$folder-$line"/$i | sort -n | uniq -c | sort -nr | head -5 | awk -v filename="$i" '{ print filename "," $2 "," $1}' > report/$i-$line
		fi
	done
	
	#mv "$folder-$line"/* old_data/
	#rm -rf "$folder-$line"


done <"$file"


