# The line below states we will base our new image on the Centos image which has systemd installed
# and configured - this extends the base centos:7 image (which you can technically use, but you need
# to do a bunch of other things as well)
FROM centos/systemd

# Update the image to the latest packages
RUN yum update -y

# Install FMS dependencies (all are here from completeness - during beta wget isn't needed)
RUN yum install wget -y
RUN yum install unzip -y
RUN yum install centos-release-scl-rh -y
RUN yum install rh-nodejs10 -y

# Copy the FMS installer
# NOTE: Make sure the correct version is given below, and that it's in the same folder as this file
COPY fms_8_linux_ets_1m3ck.zip /fms_8_linux_ets_1m3ck.zip
# Once Penguin is in production use this line instead
# wget [url] where [url] is the download link from your license email message

# Unzip the installer
RUN unzip /fms_8_linux_ets_1m3ck.zip

# Run the installer
# NOTE: Make sure the correct version is given below
RUN yum install /filemaker_server-19.0.1-8.x86_64.rpm -y

# Expose ports 80 and 443 for the web server, port 5003 from FMS itself and 16000 for the admin console
# also include 16002 if this container is a master and you have web workers, or it's a web worker.
EXPOSE 80 443 5003 16000 16002

