# Setup instructions:

Clone this repository:

    % git://github.com/noelrappin/madruby.git

Move into the repository directory

    % cd madruby

If you use RVM, you will be prompted to accept the .rvmrc file, which assumes
Ruby 2.0.0

Install gems -- install bunder if needed

    % gem install bundler

Then use bundler to install gems

    % bundle install

There is no further step, the application repo contains SQLite3 databases that
are already seeded with data.

Run the application with

    % rails server

Hit it in the browser at http://localhost:3000

Run tests with

    % rspec
