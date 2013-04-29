require File.join(File.dirname(__FILE__), 'spec_helper')

shared_examples "AggregateRepo" do
  #require 'rdf/spec/repository'

  #include RDF_Repository
  require 'rdf/spec/countable'
  require 'rdf/spec/enumerable'
  #require 'rdf/spec/queryable'

  before(:each) {@enumerable = @countable = @repository}

  include RDF_Enumerable
  include RDF_Countable
end

describe RDF::AggregateRepo do
  subject {RDF::AggregateRepo.new}

  it {should_not be_writable}

  context "no sources" do
    subject {RDF::AggregateRepo.new}
    it {should be_empty}
    its(:count) {should == 0}
    its(:size) {should == 0}
    its(:statements) {subject.statements.to_a.should == []}
  end

  context "source which is empty" do
    subject {RDF::AggregateRepo.new { source RDF::Repository.new}}
    it {should be_empty}
    its(:count) {should == 0}
    its(:size) {should == 0}
    its(:statements) {subject.statements.to_a.should == []}
  end

  context "multiple sources which are empty" do
    subject {
      RDF::AggregateRepo.new do
       source RDF::Graph.new
       source RDF::Repository.new
     end
   }

    it {should be_empty}
    its(:count) {should == 0}
    its(:size) {should == 0}
    its(:statements) {subject.statements.to_a.should == []}
  end

  context "single source" do
    let(:repo) {RDF::Repository.new {|r| RDF::Spec.quads.each {|s| r << s}}}
    before(:each) do
      r = repo
      @repository = RDF::AggregateRepo.new do
        source r
        default false
      end
      repo.each_context {|c| @repository.named(c)}  # Add all named contexts
    end
    subject {@repository}

    it {should_not be_empty}
    its(:count) {should == repo.count}

    include_examples "AggregateRepo", @repository
  end

  context "multiple sources" do
  end
end