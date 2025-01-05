
# Use Node.js official image
FROM node:16

# Set the working directory inside the container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json to install dependencies first
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy all the files into the container
COPY . .

# Expose the port your app runs on
EXPOSE 5503

# Run the app (replace with the entry point of your app, usually app.js or server.js)
CMD ["node", "app.js"]
