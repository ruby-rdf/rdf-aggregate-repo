require File.join(File.dirname(__FILE__), 'spec_helper')

shared_examples "MergeGraph" do
  require 'rdf/spec/countable'
  require 'rdf/spec/enumerable'
  require 'rdf/spec/queryable'

  it_behaves_like "an RDF::Enumerable" do
    let(:enumerable) {@merge_graph}
  end
  it_behaves_like "an RDF::Countable" do
    let(:countable) {@merge_graph}
  end
  it_behaves_like "an RDF::Queryable" do
    let(:queryable) {@merge_graph}
  end
end

describe RDF::MergeGraph do
  subject {RDF::MergeGraph.new}

  it {should be_graph}
  it {should be_unnamed}
  it {should_not be_named}
  it {should_not be_writable}

  context "no sources" do
    subject {RDF::MergeGraph.new}
    it {should be_empty}
    its(:count) {should == 0}
    its(:size) {should == 0}
    its(:statements) {expect(subject.statements).to be_empty}
  end

  context "source which is empty" do
    subject {RDF::MergeGraph.new { source RDF::Graph.new, false}}
    it {should be_empty}
    its(:count) {should == 0}
    its(:size) {should == 0}
    its(:statements) {expect(subject.statements).to be_empty}
  end

  context "multiple sources which are empty" do
    subject {
      RDF::MergeGraph.new do
       source RDF::Graph.new, false
       source RDF::Repository.new, false
     end
   }

    it {should be_empty}
    its(:count) {should == 0}
    its(:size) {should == 0}
    its(:statements) {expect(subject.statements).to be_empty}
  end

  context "single source" do
    before(:each) do
      graph = RDF::Graph.new {|g| RDF::Spec.triples.each {|s| g << s}}
      @merge_graph = RDF::MergeGraph.new do
        source graph, false
      end
    end
    include_examples "MergeGraph", @merge_graph
  end

  context "with context" do
    before(:each) do
      graph = RDF::Graph.new {|g| RDF::Spec.triples.each {|s| g << s}}
      @merge_graph = RDF::MergeGraph.new do
        source graph, false
        name RDF::URI("http://example")
      end
    end
    subject {@merge_graph}
    it {should be_named}
    it "each statement should have a context" do
      subject.each {|s| expect(s.graph_name).to eq RDF::URI("http://example")}
    end
  end

  context "multiple sources" do
    before(:each) do
      graph1 = RDF::Graph.new {|g| RDF::Spec.triples[0..9].each {|s| g << s}}
      graph2 = RDF::Graph.new {|g| RDF::Spec.triples[10..-1].each {|s| g << s}}
      @merge_graph = RDF::MergeGraph.new do
        source graph1, false
        source graph2, false
      end
    end
    include_examples "MergeGraph", @merge_graph
  end
end