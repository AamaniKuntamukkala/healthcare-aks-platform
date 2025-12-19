FROM node:18-alpine

# Create app directory
WORKDIR /usr/src/app

# Install dependencies
COPY package*.json ./
RUN npm install --production

# Copy source
COPY . .

# The application listens on this port 
ENV PORT=3001
EXPOSE 3001

# Start the service
CMD ["node", "src/index.js"]
