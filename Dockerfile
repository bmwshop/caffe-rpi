FROM armv7/armhf-ubuntu 

RUN apt-get update && apt-get -y upgrade && apt-get install -y build-essential cmake git pkg-config libprotobuf-dev libleveldb-dev libsnappy-dev libhdf5-serial-dev protobuf-compiler libatlas-base-dev 
RUN apt-get install -y --no-install-recommends libboost-all-dev
RUN apt-get install -y libgflags-dev libgoogle-glog-dev liblmdb-dev


# (Python general)
RUN apt-get install -y python-pip

# (Python 2.7 development files)
RUN apt-get install -y python-dev
RUN apt-get install -y python-numpy python-scipy python-matplotlib

# (or, Python 3.5 development files)
# RUN apt-get install -y python3-dev
# RUN apt-get install -y python3-numpy python3-scipy

# (OpenCV 2.4)
RUN apt-get install -y libopencv-dev

WORKDIR /

RUN git clone https://github.com/BVLC/caffe

# prep for build
WORKDIR /caffe
RUN cp Makefile.config.example Makefile.config

# use CPU only - can't cuda on the rpi :(
RUN sed -i "s/# CPU_ONLY := 1/CPU_ONLY := 1/g" Makefile.config

# ensure protobuf is found during compile
RUN sed -i "s/INCLUDE_DIRS := \$(PYTHON_INCLUDE) \/usr\/local\/include/INCLUDE_DIRS := \$(PYTHON_INCLUDE) \/usr\/local\/include \/usr\/include\/hdf5\/serial/g" Makefile.config
RUN sed -i "s/LIBRARIES += glog gflags protobuf boost_system boost_filesystem m hdf5_hl hdf5/LIBRARIES += glog gflags protobuf boost_system boost_filesystem m hdf5_serial_hl hdf5_serial/g" Makefile


# python dependencies
WORKDIR /caffe/python
RUN for req in $(cat requirements.txt); do pip install $req; done

# build - using just 2 threads to prevent rpi CPU from overheating [!]
WORKDIR /caffe
RUN make all -j2
RUN make pycaffe -j2
# RUN make matcaffe -j2
RUN make test -j2
RUN make distribute

