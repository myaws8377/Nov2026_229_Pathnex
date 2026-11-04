#Pull base image
FROM ubuntu:latest AS UOS

#Install python and pip
RUN apt-get update -y
RUN apt-get install -y \
python3 \
pipx

#Environment variable to use pipx installed python3
ENV PATH="/root/.local/bin:${PATH}"

#Install ansible using pip
RUN pipx install ansible

#Default command shell
CMD ["/bin/bash"]
