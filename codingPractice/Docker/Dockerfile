#Pull base image
FROM ubuntu:latest AS UOS

#Install python and pip
RUN apt-get update -y
RUN apt-get install -y python3 && apt-get install -y python3-pip
RUN python3 -m pip install ansible

#Default command shell
CMD ["/bin/bash"]
