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

#Default command shell
CMD ["/bin/bash"]
