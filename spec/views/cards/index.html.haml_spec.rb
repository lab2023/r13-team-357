require 'spec_helper'

describe "cards/index" do
  before(:each) do
    assign(:cards, [
      stub_model(Card,
        :owner_id => 1,
        :assignment_id => 2,
        :list => nil,
        :title => "Title",
        :body => "MyText",
        :done => false,
        :comment_count => 3,
        :document_count => 4,
        :checklist_total_count => 5,
        :checklist_done_count => 6,
        :private => false,
        :sort => 7
      ),
      stub_model(Card,
        :owner_id => 1,
        :assignment_id => 2,
        :list => nil,
        :title => "Title",
        :body => "MyText",
        :done => false,
        :comment_count => 3,
        :document_count => 4,
        :checklist_total_count => 5,
        :checklist_done_count => 6,
        :private => false,
        :sort => 7
      )
    ])
  end

  it "renders a list of cards" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => 5.to_s, :count => 2
    assert_select "tr>td", :text => 6.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => 7.to_s, :count => 2
  end
end
