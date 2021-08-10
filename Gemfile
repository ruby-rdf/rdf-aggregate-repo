source "https://rubygems.org"

gemspec

gem "rdf",            github: "ruby-rdf/rdf",             branch: "develop"
gem "rdf-spec",       github: "ruby-rdf/rdf-spec",        branch: "develop"
gem 'rdf-isomorphic', github: "ruby-rdf/rdf-isomorphic",  branch: "develop"
gem "rdf-turtle",     github: "ruby-rdf/rdf-turtle",      branch: "develop"
gem 'ebnf',           github: "dryruby/ebnf",             branch: "develop"
gem 'sxp',            github: "dryruby/sxp.rb",           branch: "develop"

group :debug do
  gem "redcarpet",  platforms: :ruby
  gem "ruby-debug", platforms: :jruby
  gem "byebug",     platforms: :mri
end

group :test do
  gem 'simplecov', '~> 0.21',  platforms: :mri
  gem 'simplecov-lcov', '~> 0.8',  platforms: :mri
  gem 'coveralls',  platforms: :mri
  gem "rake"
end
