RELEASE_VERSION=$2
LOG=$1

mkdir -p /home/slay/tmp/

#sftp devremote@194.67.91.22:/public/AlarmEseti.tar.gz /home/slay/tmp/

sftp -oPort=6767 slay@178.154.235.43:SoundEseti.tar.gz /home/slay/tmp/

sleep 15


#  ~/updates/AlarmEsetiUpdate/$RELEASE_VERSION
mkdir -p /home/slay/backup/
BACKUP_FOLDER=/home/slay/backup/`date '+%Y-%m-%d-%H-%M-%S'`
echo $BACKUP_FOLDER >> $1
mkdir -p $BACKUP_FOLDER

mkdir -p /home/slay/apps/SoundEseti

echo 'Выполняем бекап текущей версии' 
echo 'Выполняем бекап текущей версии' >> $LOG &>> $LOG
	tar -czf $BACKUP_FOLDER/SoundEseti.tar.gz --exclude='*.log' -C /home/slay/apps/SoundEseti . >> $1 && echo "this is done now $!" >>$1
if [ $? -eq 0 ]; then
	echo " Has been created" >> $LOG &>> $LOG
fi
echo 'Выполнено' >> $LOG &>> $LOG

#sh /home/slay/updates/AlarmEsetiRelease/$RELEASE_VERSION/run.sh $1

#sudo systemctl stop SoundEseti.service

#echo 'Удаляем файлы предыдущей версии' >> $LOG &>> $LOG
#find /home/slay/apps/AlarmEseti/* -delete

echo 'Распаковываем новую версию' 
echo 'Распаковываем новую версию' >> $LOG &>> $LOG
cd /home/slay/apps/SoundEseti/
tar -xzf /home/slay/tmp/SoundEseti.tar.gz . >> $1 && echo "Распаковываем новую версию - выполнено $!" >> $1
if [ $? -eq 0 ]; then
        echo " Распаковываем новую версию - выполнено" >> $LOG &>> $LOG
fi
echo 'Распаковываем новую версию - выполнено' >> $LOG &>> $LOG

echo 'Запускаем новую версию' 
echo 'Запускаем новую версию' >> $LOG &>> $LOG
sudo cp /home/slay/apps/SoundEseti/SoundEseti.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable SoundEseti.service

sudo chown -R slay:slay /home/slay/apps/

#sudo chmod 777 -R /home/slay/apps/AlarmEseti/
#sudo chmod 777 -R /var/spool/asterisk/recording/

sudo systemctl start SoundEseti.service

sleep 10

systemctl status SoundEseti.service >> $LOG &>> $LOG


#sleep 5

#VERSION=`curl http://localhost:5000/api/version`

