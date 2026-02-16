---
title: Rammerhead Proxy
emoji: 🦈
colorFrom: blue
colorTo: purple
sdk: docker
pinned: false
license: mit
---

# Rammerhead Proxy on Hugging Face Spaces

This is a deployment of [Rammerhead](https://github.com/binary-person/rammerhead), a web proxy powered by testcafe-hammerhead.

## Features

- Full web proxy functionality
- Session management with localStorage and cookie syncing
- Supports proxying most websites (except Google logins)
- Optimized for Hugging Face Spaces deployment

## Usage

1. Access the application through the Hugging Face Spaces URL
2. Default password: `sharkie4life`
3. Create a session and start browsing

## Configuration

This deployment uses optimized settings for Hugging Face Spaces:
- Binds to `0.0.0.0` to work in containerized environment
- Uses PORT environment variable (default: 7860)
- Memory-based caching for better performance
- Disabled workers for resource efficiency

## Source Code

Original repository: https://github.com/binary-person/rammerhead

## License

MIT License - See original repository for details
