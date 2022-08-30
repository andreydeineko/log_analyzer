To run the analyzer you would want to:
- `git clone git@github.com:andreydeineko/log_analyzer.git`
- `cd log_analyzer`
- `./run.rb filename` where filename is, as one might guess, the name of the file containing the log (ensure the file actually exists).

To run specs:
- `bundle install --path .bundle`
- `bundle exec rspec spec --format documentation`
