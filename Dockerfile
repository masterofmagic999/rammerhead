# Build stage
FROM node:16-alpine AS builder

WORKDIR /app

# Copy package files for dependency installation
COPY package*.json ./

# Install all dependencies (dev dependencies needed for build)
RUN npm install --production=false && \
    npm cache clean --force

# Copy application source files
COPY . .

# Build the application (creates optimized client-side files)
RUN npm run build

# Production stage
FROM node:16-alpine

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install only production dependencies
RUN npm install --production && \
    npm cache clean --force

# Copy built application from builder stage
COPY --from=builder /app/src ./src
COPY --from=builder /app/public ./public

# Create necessary directories for cache and sessions
RUN mkdir -p cache-js sessions

# Expose the main application port and cross-domain port
# Note: Back4app may assign different PORT via environment variable
EXPOSE 8080 8081

# Set environment to production
ENV NODE_ENV=production

# Start the application server
CMD ["npm", "start"]
