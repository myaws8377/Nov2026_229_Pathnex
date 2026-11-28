#Use NodeJS 24 as base image
FROM node:24-bookworm-slim
#Set /app as Work dir
WORKDIR /app
#Copy package files
COPY package*.json ./
#Install application dependencies
RUN npm install
#Copy application code
COPY . .
#Expose application port
EXPOSE 3000
#Start Express application
CMD ["node", "app.js"]
