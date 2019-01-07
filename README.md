# Access Log Multiple vHost Parser 

## Intro
The logs_pull.sh will ssh into multiple servers this can be set in the server.txt. Will get a list of all the files located in /var/log/httpd.
Will output via cat and write to file. It will only get files with more then 0KB. 

For each access file it will use RegEx to the IP and do a count. Once it has completed it will write a csv file with IP,Count of Hits,vHost

The python script parse_log.py will lookup each IP for AS Name and Location and give you count and vhost name.

I use these scripts to monitor active websites and possible crawerls to reduce the load on the server.
