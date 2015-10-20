require 'spec_helper'

describe ActiveTriples::Resource do

  subject { resource_class.new }

  let(:resource_class) do
    Class.new(described_class) do
      property :title, predicate: ::RDF::DC.title

      validates_presence_of :title
    end
  end

  describe "validation" do
    it { is_expected.to be_invalid }
  end

end
