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

# Build the application (creates optimized client-side files in src/client)
RUN npm run build

# Production stage
FROM node:16-alpine

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install only production dependencies
RUN npm install --production && \
    npm cache clean --force

# Copy application files from builder stage
COPY --from=builder /app/src ./src
COPY --from=builder /app/public ./public

# Copy Hugging Face Spaces configuration as config.js
# This overrides default settings for containerized HF Spaces deployment
COPY --from=builder /app/config.hf.js ./config.js

# Create necessary directories for cache and sessions
RUN mkdir -p cache-js sessions

# Expose the default port for Hugging Face Spaces
# The application will use PORT environment variable if provided
EXPOSE 7860

# Set environment to production
ENV NODE_ENV=production

# Hugging Face Spaces uses PORT environment variable
ENV PORT=7860

# Start the application server
CMD ["npm", "start"]
