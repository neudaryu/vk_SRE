!#/bin/bash

REMOTE_USER = #username of the remote machine
REMOTE_HOST = #ip-address of the remote machine
REMOTE_DIR = #the path to the directory on the remote machine

#create files in /var/log/
for i in {1..5}
do
	touch /var/log/file${i}.log
	echo "Contents of file ${i}" > /var/log/file${i}.log
done

#copy files from the local system to path $REMOTE_DIR on $REMOTE_HOST using $REMOTE_USER credentials 
rsync -avz /var/log/file?.txt "$REMOTE_USER@$REMOTE_HOST:$REMOTE_DIR" 

#connect to remote machine using ssh,search for files in the $REMOTE_DIR that were modified more than 7 days ago & delete it
ssh "$REMOTE_USER@$REMOTE_HOST" find "REMOTE_DIR" type -f -name "*.log" -mtime +7 -exec rm {} \

#0 0 * * * root /home/user/script.sh - runs script every day at 00:00
