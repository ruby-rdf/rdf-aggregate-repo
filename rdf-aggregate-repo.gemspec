#!/usr/bin/env ruby -rubygems
# -*- encoding: utf-8 -*-

Gem::Specification.new do |gem|
  gem.version            = File.read('VERSION').chomp
  gem.date               = File.mtime('VERSION').strftime('%Y-%m-%d')

  gem.name               = 'rdf-aggregate-repo'
  gem.homepage           = 'http://ruby-rdf.github.com/rdf-aggregate-repo'
  gem.license            = 'Unlicense'
  gem.summary            = 'An aggregate RDF::Repository supporting a subset of named graphs and zero or more named graphs mapped to the default graph.'
  gem.description        = %(A gem extending RDF.rb with SPARQL dataset construction semantics.)

  gem.authors            = ['Gregg Kellogg']
  gem.email              = 'public-rdf-ruby@w3.org'

  gem.platform           = Gem::Platform::RUBY
  gem.files              = %w(AUTHORS README.md UNLICENSE VERSION etc/doap.ttl) + Dir.glob('lib/**/*.rb')
  gem.require_paths      = %w(lib)
  gem.extensions         = %w()
  gem.test_files         = %w()
  gem.has_rdoc           = false

  gem.required_ruby_version      = '>= 2.0'
  gem.requirements               = []
  gem.add_runtime_dependency     'rdf',         '>= 2.0.0.beta', '< 3'
  gem.add_development_dependency 'rdf-spec',    '>= 2.0.0.beta', '< 3'
  gem.add_development_dependency 'rdf-turtle',  '>= 2.0.0.beta', '< 3'
  gem.add_development_dependency 'rspec',       '~> 3.2'
  gem.add_development_dependency 'rspec-its',   '~> 1.0'
  gem.add_development_dependency 'yard',        '~> 0.8'

  gem.post_install_message       = nil
end
