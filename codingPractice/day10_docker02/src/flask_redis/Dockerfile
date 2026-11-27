#Build an image from below
FROM python:3.12.16-alpine

#Set working directory to below
WORKDIR /firstflaskredis

#Set environment variables used by the flask command
ENV FLASK_APP=app.py
ENV FLASK_RUN_HOST=0.0.0.0

#Install C and C++ development tools
RUN apk add --no-cache gcc musl-dev linux-headers

COPY requirements.txt .

#Install Python dependencies
RUN pip install -r requirements.txt

#Copy Current to Working directory
COPY . .

EXPOSE 5000

#Run flask in debug
CMD ["flask", "run", "--debug"]
