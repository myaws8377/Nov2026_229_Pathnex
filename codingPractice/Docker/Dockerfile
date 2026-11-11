#Pull base image
FROM ubuntu:latest AS UOS

#Install python and pip
RUN apt-get update -y
RUN apt-get install -y \
python3 \
pipx

#Environment variable to use pipx installed python3
ENV PATH="/root/.local/bin:${PATH}"

#Updating pipx's internal shared pip and force install of ansible with dependencies
RUN pipx ensurepath && \
pipx install --include-deps ansible

#Install nginx and start the service
RUN apt install -y nginx && \
systemctl start nginx

WORKDIR /nginxapp

#Expose port 8080 to 80 for nginx
EXPOSE 8080:80

#Default command shell
CMD ["/bin/bash"]