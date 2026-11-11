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
RUN apt install -y nginx

WORKDIR /nginxapp

#Expose port 80 for nginx
EXPOSE 80

#Default command shell
CMD ["/bin/bash"]

#Adding Entry point to run nginx in foreground
ENTRYPOINT ["nginx", "-g", "daemon off;"]