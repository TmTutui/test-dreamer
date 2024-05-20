FROM tensorflow/tensorflow:2.4.2-gpu

# Avoid error in apt-get update
RUN rm /etc/apt/sources.list.d/cuda.list
RUN rm /etc/apt/sources.list.d/nvidia-ml.list

# System packages.
RUN apt-get update && apt-get install -y \
  ffmpeg \
  libgl1-mesa-dev \
  python3-pip \
  unrar \
  wget \
  git \
  && apt-get clean

# MuJoCo.
ENV MUJOCO_GL egl
RUN mkdir -p /root/.mujoco && \
  wget -nv https://www.roboti.us/download/mujoco200_linux.zip -O mujoco.zip && \
  unzip mujoco.zip -d /root/.mujoco && \
  rm mujoco.zip

RUN pip3 install \
  cmake \
  --upgrade pip

RUN git clone https://github.com/danijar/dreamer

# Setting up app dir
ENV APP_DIR dreamer
RUN mkdir -p $APP_DIR
WORKDIR $APP_DIR

# Python packages.
RUN pip3 install --no-cache-dir \ 
  absl-py==0.11.0 \
  astor==0.8.1 \
  atari-py==0.2.6 \
  cached-property==1.5.2 \
  cachetools==4.1.1 \
  certifi==2020.6.20 \
  chardet==3.0.4 \
  cloudpickle==1.5.0 \
  cycler==0.10.0 \
  decorator==4.4.2 \
  dm-control==0.0.322773188 \
  dm-env==1.3 \
  dm-tree==0.1.5 \
  ffmpeg==1.4 \
  future==0.18.2 \
  gast==0.3.3 \
  glfw==2.0.0 \
  google-auth==1.23.0 \
  google-auth-oauthlib==0.4.2 \
  google-pasta==0.2.0 \
  grpcio==1.33.2 \
  gym==0.17.3 \
  h5py==2.10.0 \
  idna==2.10 \
  importlib-metadata==2.0.0 \
  Keras-Applications==1.0.8 \
  Keras-Preprocessing==1.1.2 \
  kiwisolver==1.3.1 \
  labmaze==1.0.3 \
  lxml==4.6.1 \
  Markdown==3.3.3 \
  matplotlib==3.3.3 \
  numpy==1.19.4 \
  oauthlib==3.1.0 \
  opencv-python==4.4.0.46 \
  opt-einsum==3.3.0 \
  pandas==1.1.4 \
  Pillow==8.0.1 \
  pip==20.2.4 \
  protobuf==3.14.0 \
  pyasn1==0.4.8 \
  pyasn1-modules==0.2.8 \
  pyglet==1.5.0 \
  PyOpenGL==3.1.5 \
  pyparsing==2.4.7 \
  python-dateutil==2.8.1 \
  pytz==2020.4 \
  requests==2.25.0 \
  requests-oauthlib==1.3.0 \
  rsa==4.6 \
  scipy==1.4.1 \
  setuptools==50.3.1 \
  six==1.15.0 \
  tensorboard==2.2.0 \
  tensorflow-estimator==2.2.0 \
  tensorflow-gpu==2.2.0 \
  tensorflow-probability==0.9.0 \
  termcolor==1.1.0 \
  tqdm==4.52.0 \
  urllib3==1.26.2 \
  Werkzeug==1.0.1 \
  wheel==0.35.1 \
  wrapt==1.12.1 \
  zipp==3.4.0

# MuJoCo key.
RUN wget https://www.roboti.us/file/mjkey.txt
RUN mv mjkey.txt /root/.mujoco/mjkey.txt

CMD ["tail", "-f", "/dev/null"]