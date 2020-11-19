FROM python:3.8-slim

RUN apt-get update && \
    apt-get install gcc -y && \
    apt-get install libkrb5-dev -y  && \
    pip install sparkmagic==0.16.0


USER root
RUN useradd -ms /bin/bash jovyan
ARG NB_USER=jovyan

USER $NB_USER


USER root

RUN chown -R $NB_USER /home/$NB_USER/
RUN chown -R $NB_USER /usr/

USER $NB_USER


RUN mkdir /home/$NB_USER/.sparkmagic
RUN touch /home/$NB_USER/.sparkmagic/config.json



ENV HOME=/home/$NB_USER



RUN jupyter nbextension enable --py --sys-prefix widgetsnbextension
RUN jupyter-kernelspec install --user $(pip show sparkmagic | grep Location | cut -d" " -f2)/sparkmagic/kernels/sparkkernel
RUN jupyter-kernelspec install --user $(pip show sparkmagic | grep Location | cut -d" " -f2)/sparkmagic/kernels/pysparkkernel
RUN jupyter-kernelspec install --user $(pip show sparkmagic | grep Location | cut -d" " -f2)/sparkmagic/kernels/sparkrkernel
RUN jupyter serverextension enable --py sparkmagic

USER root
COPY config_template.json /home/$NB_USER/.sparkmagic/config_template.json
COPY entrypoint.sh /entrypoint.sh


RUN chown $NB_USER /home/$NB_USER/.sparkmagic/config.json
RUN chown $NB_USER /home/$NB_USER/.sparkmagic/config_template.json
RUN chown $NB_USER /entrypoint.sh


USER $NB_USER
#USER root

WORKDIR $HOME/notebooks

ENTRYPOINT ["/entrypoint.sh"]