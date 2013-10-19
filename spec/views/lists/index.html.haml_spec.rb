require 'spec_helper'

describe "lists/index" do
  before(:each) do
    assign(:lists, [
      stub_model(List,
        :name => "Name",
        :sort => 1,
        :project => nil
      ),
      stub_model(List,
        :name => "Name",
        :sort => 1,
        :project => nil
      )
    ])
  end

  it "renders a list of lists" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
