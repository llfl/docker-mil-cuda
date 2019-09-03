FROM tensorflow/tensorflow:lateast-gpu

RUN apt-get update -q \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    git \
    libgl1-mesa-dev \
    libgl1-mesa-glx \
    libglew-dev \
    libosmesa6-dev \
    libxrandr-dev \
    xpra\
    wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /root/.mujoco \
    && wget https://www.roboti.us/download/mjpro131_linux.zip -O mujoco.zip\
    && unzip mujoco.zip -d /root/.mujoco \
    && rm mujoco.zip

COPY ./mjkey.txt /root/.mujoco/

RUN mkdir /mil

WORKDIR /mil

RUN git clone --single-branch --branch mil https://github.com/tianheyu927/gym.git \
    && pip install -e ./gym && rm -rf ./gym

COPY ./requirements.txt /mil

RUN pip install --no-cache-dir -r requirements.txt

CMD ["bash"]
