source "https://rubygems.org"

gemspec

gem "rdf",      git: "git://github.com/ruby-rdf/rdf.git", branch: "develop"
gem "rdf-spec", git: "git://github.com/ruby-rdf/rdf-spec.git", branch: "develop"
gem "rdf-turtle", git: "git://github.com/ruby-rdf/rdf-turtle.git", branch: "develop"

group :debug do
  gem "wirble"
  gem "redcarpet",  platforms: :ruby
  gem "debugger",   platforms: :mri_19
  gem "ruby-debug", platforms: :jruby
  gem "byebug",     platforms: [:mri_20, :mri_21]
end

group :test do
  gem "rake"
end

platforms :rbx do
  gem 'rubysl', '~> 2.0'
  gem 'rubinius', '~> 2.0'
end

