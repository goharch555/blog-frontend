# Use Node 16 for old CRA compatibility
FROM node:16-alpine

# Set working directory
WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy project files
COPY . .

# Build app
RUN npm run build

# Install serve package
RUN npm install -g serve

# Expose port
EXPOSE 80

# Run app
CMD ["serve", "-s", "build", "-l", "80"]
