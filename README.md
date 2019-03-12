# README
## Description

Rails Engine is a 7-day solo project, during module three, of Turing School's Backend Engineering Program. The application utilizes the language of Ruby, ActiveRecord, and the web framework of Rails to build a JSON API, which exposes the SalesEngine data schema.
rake task which imports all of the CSV’s and creates the corresponding records

## Getting Started

To run Rails Engine on your local machine, navigate to the directory in which you would like the project to be located in, then execute the following commands:

```
$ git clone git@github.com:Mackenzie-Frey/RailsEngine.git
$ cd RailsEngine
$ bundle
$ rails g rspec:install
```

## Running Tests

To run the test suite, execute the following command: `rspec`.

## Deployment

To view Rails Engine in development, execute the following command from the project directory: `rails s`. In a browser, visit `localhost:3000`, to view the application.

To view the application in production, from the project directory, execute the following commands:
```
$ createuser -s -r RailsEngine
$ RAILS_ENV=production rake db:{drop,create,migrate}
$ rake assets:precompile
$ rails s -e production
```

## Tools
* Faraday
* Waffle.io
* GitHub
* RSpec
* Pry
* SimpleCov
* Hound CI
* Postman
* Webmock
* VCR
* JSON API

## Rubric/Project Description
#### [**_View the Project Description and Rubric_**]http://backend.turing.io/module3/projects/rails_engine

## Author
[Mackenzie Frey](https://github.com/Mackenzie-Frey)
