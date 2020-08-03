

cd /home/pi


git clone --recursive https://github.com/rhasspy/rhasspy
cd rhasspy/
./configure --enable-in-place
make
make install


echo
echo "Finished installing Rhasspy!"
echo
