FROM nginx
MAINTAINER Dave Barman, dave.barman@odysseusinc.com

#parameter to choose password for the webservice
ARG achilles_pw

#Opening up ports
EXPOSE 443
EXPOSE 80

#Install software that will be used for this image
RUN apt-get update && apt-get install -y git
RUN apt-get -y install openssl

#Steps to set password in nginx
RUN echo -n 'admin:' >> /etc/nginx/.htpasswd
RUN openssl passwd -apr1 $achilles_pw >> /etc/nginx/.htpasswd

#Edit config file to enable basic authentication
RUN sed -i '$d' /etc/nginx/nginx.conf
RUN echo 'auth_basic	"Restricted Access!";' >> /etc/nginx/nginx.conf
RUN echo 'auth_basic_user_file	/etc/nginx/.htpasswd;' >> /etc/nginx/nginx.conf
RUN echo '}' >> /etc/nginx/nginx.conf

#Set the working directory
WORKDIR /usr/share/nginx/html

#Remove the content that comes in nginx
RUN rm -f *

#Getting the AchillesWeb content and placing it in the webserver content directory
RUN git clone https://github.com/OHDSI/AchillesWeb.git  /usr/share/nginx/html

#Create the data directory in the contents folder for JSON data from Achilles analysis
RUN mkdir /usr/share/nginx/html/data/



