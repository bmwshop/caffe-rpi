## Docker container for Caffe on a Raspberry Pi

Trying to make it a litle simpler to install [Caffe](http://caffe.berkeleyvision.org/) - the deep learning framework - on a Raspberry Pi. The build process below takes a few hours; if you are confident that your rpi does not overheat, you could replace -j2 with -j4 in the Dockerfile.  Or you could just pull the [image from dockerhub](https://hub.docker.com/r/bmwshop/caffe-rpi/)

```
docker build -t caffe-rpi .
docker run --name caffe-rpi -ti caffe-rpi bash
make runtest -j4
```
Running make runtest -j4  validates the installation.  See the [Caffe installation docs](http://caffe.berkeleyvision.org/installation.html) for more
