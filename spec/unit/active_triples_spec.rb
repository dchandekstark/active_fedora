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
    it "should have a presence validator on the class" do
      expect(resource_class.validators.first).to be_a(ActiveModel::Validations::PresenceValidator)
    end
    it "should have validation callbacks" do
      expect(resource_class._validate_callbacks).to be_present
    end
    it "should run the validations" do
      expect(subject).to receive(:run_validations!)
      subject.valid?
    end
  end

end
