FROM python:3.10-buster

RUN apt-get update
RUN apt-get install -y git 

RUN git clone https://github.com/TmTutui/test-dreamer.git

# Setting up app dir
ENV APP_DIR test-dreamer
RUN mkdir -p $APP_DIR
WORKDIR $APP_DIR

# remove tensorflow-gpu, comment this line on x86 systems
RUN sed -i '1d' requirements.txt

RUN pip3 install -r requirements.txt

# RUN pip install pyrender
# RUN apt-get install libosmesa6-dev freeglut3-dev
# RUN pip install PyOpenGL==3.1.4


# RUN wget https://www.roboti.us/download/mujoco200_linux.zip
# RUN unzip mujoco200_linux.zip
# RUN wget https://www.roboti.us/file/mjkey.txt
# RUN mv mj_key.txt mujoco200_linux

# RUN python3 dreamer.py --logdir ./logdir/dmc_walker_walk/dreamer/1 --task dmc_walker_walk
CMD ["tail", "-f", "/dev/null"]
