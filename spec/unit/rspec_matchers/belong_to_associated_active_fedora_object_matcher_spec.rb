require "spec_helper"
require 'ostruct'
require "active_fedora/rspec_matchers/belong_to_associated_active_fedora_object_matcher"

describe RSpec::Matchers, ".belong_to_associated_active_fedora_object" do
  subject { OpenStruct.new(id: id) }
  let(:id) { 123 }
  let(:object1) { Object.new }
  let(:object2) { Object.new }
  let(:association) { :association }

  it 'matches when association is properly stored in fedora' do
    expect(subject.class).to receive(:find).with(id).and_return(subject)
    expect(subject).to receive(association).and_return(object1)
    expect(subject).to belong_to_associated_active_fedora_object(association).with_object(object1)
  end

  it 'does not match when association is different' do
    expect(subject.class).to receive(:find).with(id).and_return(subject)
    expect(subject).to receive(association).and_return(object1)
    expect {
      expect(subject).to belong_to_associated_active_fedora_object(association).with_object(object2)
    }.to raise_error RSpec::Expectations::ExpectationNotMetError,
                     /expected #{subject.class} ID=#{id} association: #{association.inspect}/
  end

  it 'requires :with_object option' do
    expect {
      expect(subject).to belong_to_associated_active_fedora_object(association)
    }.to(
      raise_error(
        ArgumentError,
        "expect(subject).to belong_to_associated_active_fedora_object(<association_name>).with_object(<object>)"
      )
    )
  end
end
