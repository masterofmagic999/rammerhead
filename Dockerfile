# Use Node.js LTS version as recommended in README
FROM node:16-alpine

# Set working directory
WORKDIR /app

# Copy package files for dependency installation
COPY package*.json ./

# Install dependencies (including dev dependencies for build step)
RUN npm install --production=false && \
    npm cache clean --force

# Copy application source files
COPY . .

# Build the application (creates optimized client-side files)
RUN npm run build

# Create necessary directories for cache and sessions
RUN mkdir -p cache-js sessions

# Expose the main application port and cross-domain port
# Note: Back4app may assign different PORT via environment variable
EXPOSE 8080 8081

# Set environment to production
ENV NODE_ENV=production

# Start the application server
CMD ["npm", "start"]
