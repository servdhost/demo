# Servd Demo Project

You can use this repo to test out some of Servd's functionality.

It contains:

* A simple Craft 3 project
* The [Servd Assets and Helpers Plugin](https://servd.host/docs/the-assets-and-helpers-plugin)
* Docker configuration to run the project locally
* A dockerised buildchain for compiling CSS and JS assets, and optimising static images

## Run Locally

1. Copy `.env.example` to `.env`
2. `chmod 777 -R src/config`
2. `docker-compose up`  
3. Visit http://localhost in your browser

Optionally import the database dump in the root of this repo.

## Launch on Servd

* Fork this repo
* Create a new project on Servd
* Select your fork as the source
* Accept the default suggestions for all the settings
* Wait for your project to be deployed
* Run through the Craft install process in order to apply the included project config settings

## Set Up Asset Volume

A Servd Asset Volume is defined in the included project config. Once your site is live you can 
test it out by uploading a jpeg, gif or png via the craft dashboard. If you preview the uploaded image and check 
the URL that it was served from you should see that it originated from either:

`https://optimise2.assets-servd.host` or `https://cdn2.assets-servd.host`

The assets platform is working! Image transforms and optimisations are being performed off server
so they can't impact your site's visitors or content authors.

## Using the assets platform locally

If you want to test this project in a local development environment, please follow the instructions included 
in the Servd Assets and Helpers Plugin README regarding how to use Servd's assets platform locally.


## Database Dump

This repo contains a database dump called `servd-demo.sql` which you can use to test Servd's database import functionality.

Once imported you can log into the Craft Control Panel by visiting `/admin` and using the following credentials:

Username: `admin`

Password: `password`

