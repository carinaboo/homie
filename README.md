Homie
=====

[homieapts.herokuapp.com](http://homieapts.herokuapp.com/)

### To Run The Application
1. `git clone https://github.com/carinaboo/homie.git`
1. `bundle install`
1. `rake db:migrate`
1. `rails s`
1. Go to `localhost:3000/` in your browser

### To Run The Tests
1. `bin/rake db:migrate RAILS_ENV=test`
1. `rspec`

### To View Test Coverage Report
1. `rspec`
1. Go into the `coverage` directory in `homie`.
1. Open `index.html` with your browser to see the test coverage.
