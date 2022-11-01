RELEASE_VERSION=RELEASE-1
echo Запускает обновление $RELEASE_VERSION
mkdir -p /home/slay/updates/SoundEsetiUpdate/logs/
LOG=/home/slay/updates/SoundEsetiUpdate/logs/`date '+%Y-%m-%d-%H-%M-%S'`.log
echo Запускает обновление $RELEASE_VERSION >> $LOG &>> $LOG

cd /home/slay/updates/SoundEsetiUpdate # >> $LOG &>> $LOG
#git pull origin master >> $LOG &>> $LOG
sh /home/slay/updates/SoundEsetiUpdate/update.sh $LOG $RELEASE_VERSION
