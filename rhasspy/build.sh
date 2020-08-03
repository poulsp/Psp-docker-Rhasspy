
START_TIME=`date +%s`


if [ ! -d Docker/host_volumes/rhasspy-from-git ]; then
  mkdir -p Docker/host_volumes/rhasspy-from-git
fi

docker-compose down >/dev/null 2>&1

echo
USERID=`id -u $"$USER"`
GROUPID=`id -g $"$USER"`
echo $"Your USERID: $USERID"
echo $"Your GROUPID: $GROUPID"
echo


# -f for force build image
if [ "$1" == "-f" ];then
  BUILD_ARGS="--no-cache"
fi


#Is image builded
image=`docker image ls  -q poulsp/rhasspy | cat -`
if [[  -z $image  ||  ! -z $BUILD_ARGS ]];then
  time docker build $BUILD_ARGS --force-rm --build-arg UID=$"$USERID" --build-arg GID=$"$GROUPID"  -t poulsp/rhasspy -f Docker/Dockerfile .
fi


if [ -d Docker/host_volumes/rhasspy-from-git ] ; then
  if [ ! -z "$(ls -A Docker/host_volumes/rhasspy-from-git)" ]; then
    echo
    echo '  The directory Docker/host_volumes/rhasspy-from-git must be empty for successful installation.'
    echo '  Empty the directory.'
    echo
    exit 0
  fi


  owner=`stat -c '%U' Docker/host_volumes/rhasspy-from-git`
  if [ "$owner" == "$USER" ]; then
    echo
  else
    echo
    echo $"Wrong owner $owner"
    echo "  Docker/host_volumes/rhasspy-from-git are owned by $owner, remove Docker/host_volumes/rhasspy-from-git with sudo"
    echo '  sudo rm -r Docker/host_volumes/rhasspy-from-git'
    echo
    exit 0
  fi
fi

# So the docker container can start with out a installed Rhasspy.
sed -i "s/command: \/home\/pi\/bin\/rhasspy/#command: \/home\/pi\/bin\/rhasspy/" ./docker-compose.yml

docker-compose up -d

time docker-compose exec rhasspy bash -c 'bash /installl-scripts/rhasspy-install.sh'

echo "The above is time it took to build clone and build Rhasspy"
echo
docker-compose down

cp Docker/host_volumes/my-wavs/beep_error.wav  Docker/host_volumes/rhasspy-from-git/etc/wav/beep_error.wav
cp Docker/host_volumes/my-wavs/beep_hi.wav     Docker/host_volumes/rhasspy-from-git/etc/wav/beep_hi.wav
cp Docker/host_volumes/my-wavs/beep_lo.wav     Docker/host_volumes/rhasspy-from-git/etc/wav/beep_lo.wav

# Let Rhasspy start automatically.
sed -i "s/#command: \/home\/pi\/bin\/rhasspy/command: \/home\/pi\/bin\/rhasspy/" ./docker-compose.yml

END_TIME=`date +%s`

TOTAL_RUN_TIME="Built at "$(((END_TIME-START_TIME)/60))" minutes."
echo '--------------------------'
echo "$TOTAL_RUN_TIME"
echo '--------------------------'
echo "Start 'Rhasspy' enter: docker-compose up -d"
echo "Visit localhost:12101 in your browser"
echo '--------------------------'
echo "Shutdown 'Rhasspy' enter: docker-compose down"
echo '--------------------------'
echo
