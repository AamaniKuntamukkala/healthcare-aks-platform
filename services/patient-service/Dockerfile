# Use the official Node.js 18 image as the base
FROM node:18-alpine

# Set working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json to install dependencies
COPY package*.json ./

# Install dependencies
RUN npm install --production

# Copy the rest of the application source code
COPY . .

# Expose the desired port (usually 3000 or configured port)
EXPOSE 3000

# Start the Node.js application
CMD ["node", "src/index.js"]
