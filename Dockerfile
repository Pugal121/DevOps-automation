FROM nginx:latest

# Copy your custom Nginx configuration file (if needed)
COPY nginx.conf .

# Expose the port for Nginx
EXPOSE 80

# Define the command to run Nginx
CMD ["nginx", "-g", "daemon off;"]
