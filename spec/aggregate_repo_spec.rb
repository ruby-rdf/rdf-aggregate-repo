require File.join(File.dirname(__FILE__), 'spec_helper')
require 'rdf/turtle'

shared_examples "AggregateRepo" do
  #require 'rdf/spec/repository'

  #include RDF_Repository
  require 'rdf/spec/countable'
  require 'rdf/spec/enumerable'
  require 'rdf/spec/queryable'

  before(:each) {@queryable = @enumerable = @countable = @repository}

  include RDF_Enumerable
  include RDF_Countable
  include RDF_Queryable
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

  context "with specific named entities" do
    let(:repo) {RDF::Repository.new {|r| RDF::Spec.quads.each {|s| r << s}}}
    let(:gkellogg) {RDF::Graph("http://greggkellogg.net/foaf#me", :data => repo)}
    let(:bendiken) {RDF::Graph("http://ar.to/#self", :data => repo)}
    let(:bhuga) {RDF::Graph("http://bhuga.net/#ben", :data => repo)}
    before(:each) do
      r = repo
      @repository = RDF::AggregateRepo.new do
        source r
        default RDF::URI("http://greggkellogg.net/foaf#me")
        named RDF::URI("http://ar.to/#self")
        named RDF::URI("http://bhuga.net/#ben")
      end
    end
    subject {@repository}

    it {should_not be_empty}
    its(:count) {should == [gkellogg, bendiken, bhuga].map(&:count).reduce(:+)}
  end

  context "dataset-12b" do
    before(:each) do
      @repo = RDF::Repository.new
      @repository = RDF::AggregateRepo.new(@repo)
      Dir.glob(File.expand_path("..", __FILE__) + "/data/*.ttl").each do |f|
        base = RDF::URI("http://www.w3.org/2001/sw/DataAccess/tests/data-r2/dataset/#{f.split('/').last}")
        @repo.load(f, :base_uri => base, :context => base)
        if f =~ /dup/
          @repository.defaults << base
        else
          @repository.named base
        end
      end
    end
    let(:repo) {@repo}
    subject {@repository}

    its(:sources) {should_not be_empty}
    its(:defaults) {should_not be_empty}

    it "has distinct BNodes in each graph" do
      subject.each_graph do |graph1|
        graph1.each_subject.select {|s| s.node?}.each do |bnode|
          subject.each_graph do |graph2|
            next if graph1 == graph2
            graph2.subjects.select(&:node?).each {|n| n.should_not be_eql(bnode)}
          end
        end
      end
    end
  end
end