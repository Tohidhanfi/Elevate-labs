# Custom nginx image for Task 3
FROM nginx:alpine

# Copy our custom HTML file
COPY index.html /usr/share/nginx/html/index.html

# Copy our custom nginx configuration
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Create a simple 404 page
RUN echo '<html><head><title>404 - Not Found</title></head><body><h1>404 - Page Not Found</h1><p>This is Task 3 Infrastructure as Code demo.</p></body></html>' > /usr/share/nginx/html/404.html

# Create a simple 50x error page
RUN echo '<html><head><title>500 - Server Error</title></head><body><h1>500 - Server Error</h1><p>This is Task 3 Infrastructure as Code demo.</p></body></html>' > /usr/share/nginx/html/50x.html

# Expose port 80
EXPOSE 80

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD curl -f http://localhost/health || exit 1 