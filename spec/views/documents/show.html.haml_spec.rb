require 'spec_helper'

describe "documents/show" do
  before(:each) do
    @document = assign(:document, stub_model(Document,
      :card => nil,
      :user => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    rendered.should match(//)
  end
end
