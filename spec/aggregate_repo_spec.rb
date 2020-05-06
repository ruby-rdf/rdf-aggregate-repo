require File.join(File.dirname(__FILE__), 'spec_helper')
require 'rdf/turtle'

shared_examples "AggregateRepo" do
  require 'rdf/spec/dataset'
  it_behaves_like "an RDF::Dataset" do
    let(:dataset) {@dataset}
  end
end

describe RDF::AggregateRepo do
  subject {RDF::AggregateRepo.new}

  it {is_expected.not_to be_writable}

  context "no sources" do
    subject {RDF::AggregateRepo.new}
    it {is_expected.to be_empty}
    its(:count) {is_expected.to eql 0}
    its(:size) {is_expected.to eql 0}
    its(:statements) {expect(subject.statements).to be_empty}
  end

  context "source which is empty" do
    subject {RDF::AggregateRepo.new { source RDF::Repository.new}}
    it {is_expected.to be_empty}
    its(:count) {is_expected.to eql 0}
    its(:size) {is_expected.to eql 0}
    its(:statements) {expect(subject.statements).to be_empty}
  end

  context "multiple sources which are empty" do
    subject {
      RDF::AggregateRepo.new do
       source RDF::Graph.new
       source RDF::Repository.new
     end
   }

    it {is_expected.to be_empty}
    its(:count) {is_expected.to eql 0}
    its(:size) {is_expected.to eql 0}
    its(:statements) {expect(subject.statements).to be_empty}
  end

  context "single source" do
    let(:repo) {RDF::Repository.new {|r| RDF::Spec.quads.each {|s| r << s}}}
    before(:each) do
      r = repo
      @dataset = RDF::AggregateRepo.new do
        source r
        default false
      end
      # Add all named graphs
      repo.each_graph {|c| @dataset.named(c.graph_name) if c.graph_name}
    end
    subject {@dataset}

    it {is_expected.not_to be_empty}
    its(:count) {is_expected.to eql repo.count}
    its(:graph_names) {is_expected.to include(*@dataset.graph_names)}
    describe "#default_graph" do
      subject {@dataset.default_graph}
      its(:count) {is_expected.to eql repo.reject(&:graph_name).length}
      it "statements have no graph_name" do
        expect(subject.statements.map(&:graph_name)).to all(be_nil)
      end
    end
    describe "#enum_graph" do
      subject {@dataset.enum_graph}
      its(:count) {is_expected.to eql repo.each_graph.count}
    end

    include_examples "AggregateRepo", @dataset
  end

  context "with specific named entities" do
    let(:repo) {RDF::Repository.new {|r| RDF::Spec.quads.each {|s| r << s}}}
    let(:gkellogg) {RDF::Graph(graph_name: "https://greggkellogg.net/foaf#me", data: repo)}
    let(:bendiken) {RDF::Graph(graph_name: "https://ar.to/#self", data: repo)}
    let(:bhuga) {RDF::Graph(graph_name: "https://bhuga.net/#ben", data: repo)}
    before(:each) do
      r = repo
      @dataset = RDF::AggregateRepo.new do
        source r
        default RDF::URI("https://greggkellogg.net/foaf#me")
        named RDF::URI("https://ar.to/#self")
        named RDF::URI("https://bhuga.net/#ben")
      end
    end
    subject {@dataset}

    it {is_expected.not_to be_empty}
    its(:count) {is_expected.to eql [gkellogg, bendiken, bhuga].map(&:count).reduce(:+)}
    its(:graph_names) {is_expected.to eql [RDF::URI("https://ar.to/#self"), RDF::URI("https://bhuga.net/#ben")]}
    describe "#default_graph" do
      subject {@dataset.default_graph}
      its(:count) {is_expected.to eql gkellogg.count}
      it "statements have no graph_name" do
        expect(subject.statements.map(&:graph_name)).to all(be_nil)
      end
    end
    describe "#enum_graph" do
      subject {@dataset.enum_graph}
      its(:count) {is_expected.to eql 3}
    end
  end

  context "dataset-12b" do
    before(:each) do
      @repo = RDF::Repository.new
      @dataset = RDF::AggregateRepo.new(@repo)
      Dir.glob(File.expand_path("..", __FILE__) + "/data/*.ttl").each do |f|
        base = RDF::URI("http://www.w3.org/2001/sw/DataAccess/tests/data-r2/dataset/#{f.split('/').last}")
        @repo.load(f, base_uri: base, graph_name: base)
        if f =~ /dup/
          @dataset.defaults << base
        else
          @dataset.named base
        end
      end
    end
    let(:repo) {@repo}
    subject {@dataset}

    its(:sources) {is_expected.not_to be_empty}
    its(:defaults) {is_expected.not_to be_empty}

    it "has distinct BNodes in each graph" do
      subject.each_graph do |graph1|
        graph1.each_subject.select {|s| s.node?}.each do |bnode|
          subject.each_graph do |graph2|
            next if graph1 == graph2
            graph2.subjects.select(&:node?).each {|n| expect(n).not_to be_eql(bnode)}
          end
        end
      end
    end
  end
end