#Pull base image
FROM ubuntu:latest AS UOS

#Install python and pip
RUN sudo apt-get update -y
RUN sudo apt-get install -y python3 && sudo apt-get install -y python3-pip
RUN sudo pip3 install ansible

#Default command shell
CMD ["/bin/bash"]
