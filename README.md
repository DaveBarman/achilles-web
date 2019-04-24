# Dockerize achillesWeb

This project aims to provide a simple way to view results from the Achilles analysis without the need to install Atlas. To facilitate engagments which do not have the Atlas compoment, the intent is to use this dockerfile and docker image to quickly stand up a password protected webservice to view the results.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Prerequisites

Docker installed and set to run linux containers
A datasource.json file with the listed data source names
The results of Achilles analysis exported into JSON format

```
 { "datasources":[ { "name":"My Sample Database", "folder":"SAMPLE", "cdmVersion": 5 } ] } 
```
The results of Achilles analysis exported into JSON format. 
* [Achilles](https://github.com/OHDSI/Achilles) - The Achilles tool used to produce JSON files from Analysis

## Build a new image 

Using the dockerfile, build a new image with the syntax below

```
docker build -t <tagged_name> -f Dockerfile --build-arg achilles_pw=<your_password> .

Build docker image with and provide password
```

An example:

```
docker build -t achillesweb -f Dockerfile --build-arg achilles_pw=supersecretpassword .
```

## Running the image

The achillesWeb docker image requires an export of JSON data from the results of the Achilles tool. With that data available in the host filesystem, it can be bound at run-time with the following command:

```
docker run --name achillesWEB -v <path_to_data_on_host>:/usr/share/nginx/html/data:ro -P -d achillesweb
```

## Accessing the website after image is up

You can determine the port which the docker container is serving by issuing the statement

```
docker ps
```

Security will be determined by the password that is entered into the argument during the build step. Username is 'admin'.


## Built With

* [Docker](http://www.docker.com) - For creating and managing containers
* [achillesWeb](https://github.com/OHDSI/AchillesWeb) - Web content for hosting Achilles analysis
* [Achilles](https://github.com/OHDSI/Achilles) - Achilles tool for analyzing OMOP CDM conversions

