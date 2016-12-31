source "https://rubygems.org"

gemspec

gem "rdf",            github: "ruby-rdf/rdf",             branch: "develop"
gem "rdf-spec",       github: "ruby-rdf/rdf-spec",        branch: "develop"
gem 'rdf-isomorphic', github: "ruby-rdf/rdf-isomorphic",  branch: "develop"
gem "rdf-turtle",     github: "ruby-rdf/rdf-turtle",      branch: "develop"
gem 'ebnf',           github: "gkellogg/ebnf",            branch: "develop"
gem 'sxp',            github: "dryruby/sxp.rb",           branch: "develop"

group :debug do
  gem "redcarpet",  platforms: :ruby
  gem "ruby-debug", platforms: :jruby
  gem "byebug",     platforms: :mri
end

group :test do
  gem "rake"
end

platforms :rbx do
  gem 'rubysl', '~> 2.0'
  gem 'rubinius', '~> 2.0'
end

