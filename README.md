# Marley Spoon Recipes

This is an example application for the Marley Spoon's web challenge.

# Prerequisites

Before you start, make sure you have installed the required dependencies:

  * Ruby = 2.6.3
  * Ruby Gems (see 'bundler' below)

# Setting up

1. Get the [Marley Spoon](https://github.com/LucoLe/marley-spoon) source code from
   GitHub.

   ```sh
   git@github.com:LucoLe/marley-spoon.git
   cd marley-spoon
   ```

2. Install [Bundler](http://bundler.io):

   ```sh
   gem install bundler
   ```

   **Note:** Make sure to use local (user-install) gem store and not the system-wide.

3. Install the code dependencies

   ```sh
   bundle install
   ```

4. This application is not using a database so it's not needed to setup a database.

5. It shouldn't be needed to configure anything but I've intentionally added the `config/master.key` file to git so you
   can make some changes to or inspect the `config/credentials.yml.enc`.

Now we are ready to start the application.

# Running the application

All you need to do to run the application is run the following command in the terminal:

```sh
bin/rails server
```

# Running tests

To start the tests, run:

```sh
bin/rspec
```
or
```sh
bundle exec rspec
```
