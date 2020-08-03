
# Psp-docker-Rhasspy.

My way to build and use Rhasspy in a Docker container.
I works with Rhasspy 2.5.5 and properly >2.5.5
I use it one my Linux Desktop PC, with a usb microphone and the desktop's speakers.
But that you can configure in the Rhasspy web interface.

Read [Installing](#Installing).

## Installing.
`build.sh` builds the docker images and the Rhasspy.

  - Enter **`"bash build.sh"`**
    With `"bash build.sh"` you get the right UID and GID in the image ant the container.

- When finished building the images you can enter: `"docker-compose up -d"`.
  Visit `localhost:12101` in your browser.

#### Running Rhasspy container Manual.
You can run "rhasspy" manually edit the docker-compose.yaml and comment out:
- `#command: /home/pi/bin/rhasspy`  and afterward entering: `"docker-compose exec rhasspy bash"`.
And inside the container enter: `"rhasspy"`.

#### Running Rhasspy container  Automatic.
To run "rhasspy" automatically edit the docker-compose.yaml and un-comment:
- `#command: /home/pi/bin/rhasspy`

Then enter `"docker-compose up -d"`.

To shutdown the Rhasspy container enter: `"docker-compose down"`.

## 📜 License.
Psp-docker-Rhasspy ships under GPLv3, it means you are free to use and redistribute the code but are not allowed to use any part of it under a closed license.

Rhasspy lives at [github.com/rhasspy/rhasspy](https://github.com/rhasspy/rhasspy)
Rhasspyis licensed under the MIT License and Copyright (c) 2019-2020 Michael Hansen.

## Disclaimer.
I have made this repo for my self but wanted to share it.
 This is work in progress and the code is as it is.
 Use it at your own risk.
