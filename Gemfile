source "https://rubygems.org"

gemspec

gem "rdf",        git: "git://github.com/ruby-rdf/rdf.git",         branch: "develop"
gem "rdf-spec",   git: "git://github.com/ruby-rdf/rdf-spec.git",    branch: "develop"
gem 'rdf-isomorphic', git: "git://github.com/ruby-rdf/rdf-isomorphic.git",  branch: "develop"
gem "rdf-turtle", git: "git://github.com/ruby-rdf/rdf-turtle.git",  branch: "develop"
gem 'ebnf',       git: "git://github.com/gkellogg/ebnf.git",        branch: "develop"
gem 'sxp',        git: "git://github.com/gkellogg/sxp-ruby.git"

group :debug do
  gem "wirble"
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

