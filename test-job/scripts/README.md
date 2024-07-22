# Making migrate.sh Executable
## Ensure that migrate.sh is executable before building your Docker image:
````
chmod +x migrate.sh
````

## Adding the Script to Your Docker Image
## In your Dockerfile, you should copy the script into the image and ensure the necessary tools are installed:
```
FROM your-base-image

# Install necessary tools (example for Debian-based images)
RUN apt-get update && apt-get install -y postgresql-client

# Copy the migration script into the image
COPY migrate.sh /migrate.sh

# Ensure the script is executable
RUN chmod +x /migrate.sh

# Set the entrypoint or command (if needed)
# ENTRYPOINT ["/migrate.sh"]
# or
# CMD ["/migrate.sh"]
```