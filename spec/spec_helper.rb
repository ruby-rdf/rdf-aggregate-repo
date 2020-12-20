require "bundler/setup"
require 'rdf/aggregate_repo'
require 'rdf/spec'
require 'rdf/spec/matchers'

RSpec.configure do |config|
  config.include(RDF::Spec::Matchers)
  config.filter_run focus: true
  config.run_all_when_everything_filtered = true
  config.exclusion_filter = {
    ruby:       lambda {|version| RUBY_VERSION.to_s !~ /^#{version}/},
  }
end

begin
  require 'simplecov'
  require 'coveralls'
  SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new([
    SimpleCov::Formatter::HTMLFormatter,
    Coveralls::SimpleCov::Formatter
  ])
  SimpleCov.start do
    add_filter "/spec/"
  end
  Coveralls.wear!
rescue LoadError => e
  STDERR.puts "Coverage Skipped: #{e.message}"
end
