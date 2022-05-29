#!/usr/bin/env ruby -rubygems
# -*- encoding: utf-8 -*-

Gem::Specification.new do |gem|
  gem.version            = File.read('VERSION').chomp
  gem.date               = File.mtime('VERSION').strftime('%Y-%m-%d')

  gem.name               = 'rdf-aggregate-repo'
  gem.homepage           = 'https://github.com/ruby-rdf/rdf-aggregate-repo'
  gem.license            = 'Unlicense'
  gem.summary            = 'An aggregate RDF::Repository supporting a subset of named graphs and zero or more named graphs mapped to the default graph.'
  gem.description        = %(A gem extending RDF.rb with SPARQL dataset construction semantics.)
  gem.metadata           = {
    "documentation_uri" => "https://ruby-rdf.github.io/rdf-aggregate-repo",
    "bug_tracker_uri"   => "https://github.com/ruby-rdf/rdf-aggregate-repo/issues",
    "homepage_uri"      => "https://github.com/ruby-rdf/rdf-aggregate-repo",
    "mailing_list_uri"  => "https://lists.w3.org/Archives/Public/public-rdf-ruby/",
    "source_code_uri"   => "https://github.com/ruby-rdf/rdf-aggregate-repo",
  }

  gem.authors            = ['Gregg Kellogg']
  gem.email              = 'public-rdf-ruby@w3.org'

  gem.platform           = Gem::Platform::RUBY
  gem.files              = %w(AUTHORS README.md UNLICENSE VERSION etc/doap.ttl) + Dir.glob('lib/**/*.rb')
  gem.require_paths      = %w(lib)

  gem.required_ruby_version      = '>= 2.6'
  gem.requirements               = []
  gem.add_runtime_dependency     'rdf',         '~> 3.2'
  gem.add_development_dependency 'rdf-spec',    '~> 3.2'
  gem.add_development_dependency 'rdf-turtle',  '~> 3.2'
  gem.add_development_dependency 'rspec',       '~> 3.10'
  gem.add_development_dependency 'rspec-its',   '~> 1.3'
  gem.add_development_dependency 'yard',        '~> 0.9'

  gem.post_install_message       = nil
end
