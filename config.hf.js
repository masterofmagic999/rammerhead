// Configuration overrides for Hugging Face Spaces deployment
// This file should be copied to config.js in the root during deployment

const path = require('path');

// Hugging Face Spaces provides PORT environment variable (default 7860)
const port = parseInt(process.env.PORT || '7860');

module.exports = {
    // Bind to all interfaces (required for containerized deployments)
    bindingAddress: '0.0.0.0',
    
    // Use PORT environment variable (Hugging Face Spaces standard)
    port: port,
    
    // Use same port for cross-domain (simplified for HF Spaces)
    crossDomainPort: port,
    
    // Disable workers in constrained environments
    enableWorkers: false,
    
    // Server info for Hugging Face Spaces
    getServerInfo: (req) => {
        const hostname = req?.headers?.host?.split(':')[0] || 'localhost';
        return {
            hostname: hostname,
            port: port,
            crossDomainPort: port,
            protocol: 'https:'
        };
    },
    
    // Use memory cache for better performance in containerized environment
    jsCache: new (require('./src/classes/RammerheadJSMemCache.js'))(50 * 1024 * 1024), // 50MB
};
