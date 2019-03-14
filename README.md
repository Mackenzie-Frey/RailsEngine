# README
## Description

Rails Engine is a 7-day solo project, during module three, of Turing School's Backend Engineering Program. The application utilizes the language of Ruby, ActiveRecord, and the web framework of Rails to deliver Fast JSON-formatted data. A rake task was utilized to import CSV files and to create the corresponding records in the Postgresql database.

## Schema
![Alt text](./public/schema_diagram.png?raw=true "Database Schema")

## Getting Started

To run Rails Engine on your local machine, navigate to the directory in which you would like the project to be located in, then execute the following commands:

```
$ git clone git@github.com:Mackenzie-Frey/RailsEngine.git
$ cd RailsEngine
$ bundle
$ rails g rspec:install
```
To seed the database with the CSV files, run the following:
```bundle exec rake import_all```

## Running Tests

To run the test suite, execute the following command: `rspec`.
To run the application against the spec harness, navigate to the same level directory as your application:
```
git clone https://github.com/turingschool/rales_engine_spec_harness.git
cd rales_engine_spec_harness
bundle
```
To run the spec harness, navigate to the directory of your application, utilize 'rails s' to run the server. Open another tab in the terminal, navigate to the directory of your spec harness. While the server is running, type the command `rake`, to run the spec harness.

## Deployment

To view Rails Engine in development, execute the following command from the project directory: `rails s`. In a browser, visit `localhost:3000`, to view the application.

To view the application in production, from the project directory, execute the following commands:
```
$ createuser -s -r RailsEngine
$ RAILS_ENV=production rake db:{drop,create,migrate}
$ rake assets:precompile
$ rails s -e production
```

## Built Utilizing
* Rails
* Fast JSON API
* PostgreSQL
* RSpec
* Pry
* FactoryBot
* Shoulda Matchers
* SimpleCov
* Hound CI
* Postman
* Waffle.io
* GitHub

## Rubric/Project Description
#### [**_View the Project Description and Rubric_**]http://backend.turing.io/module3/projects/rails_engine

## Author
[Mackenzie Frey](https://github.com/Mackenzie-Frey)
