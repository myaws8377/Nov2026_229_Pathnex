#Pull base image
FROM Ubuntu:latest AS UOS

#Install python and pip
RUN apt-get update && apt-get install -y python3 && apt-get install -y python3-pip && pip3 install ansible

#Default command shell
CMD ["/bin/bash"]
