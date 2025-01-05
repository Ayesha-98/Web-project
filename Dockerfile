# Use the official Node.js image
FROM node:16

# Set the working directory inside the container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json first to leverage Docker cache and speed up rebuilds
COPY package*.json ./

# Install dependencies with increased timeout and clean cache
RUN npm install --fetch-timeout=60000 --cache /tmp/empty-cache

# Copy all the app files into the container
COPY . .

# Expose the port the app runs on (make sure it's the correct port for your app)
EXPOSE 5503

# Start the app (replace with your app entry point file)
CMD ["node", "app.js"]
