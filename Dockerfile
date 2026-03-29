# Base image - Ubuntu Linux
FROM ubuntu:22.04

# Avoid timezone prompts during install
ENV DEBIAN_FRONTEND=noninteractive

# Install all the tools needed to build the kernel
RUN apt-get update && apt-get install -y \
    nasm \
    gcc \
    make \
    xorriso \
    grub-pc-bin \
    grub-common \
    build-essential

# Set the working directory inside the container
WORKDIR /kernel

# Copy all our project files in
COPY . .

# Build the kernel when the container runs
CMD ["make"]