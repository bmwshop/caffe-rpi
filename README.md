## Docker container for Caffe on a Raspberry Pi

Trying to make it a litle simpler to install [Caffe](http://caffe.berkeleyvision.org/) - the deep learning framework - on a Raspberry Pi.

```
docker build -t caffe-rpi .
docker run --privileged --name caffe-rpi -ti caffe-rpi bash
make runtest -j4
```
Running make runtest -j4  validates the installation.  See the [Caffe installation docs](http://caffe.berkeleyvision.org/installation.html) for more..

