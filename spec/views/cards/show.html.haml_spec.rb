require 'spec_helper'

describe "cards/show" do
  before(:each) do
    @card = assign(:card, stub_model(Card,
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
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(//)
    rendered.should match(/Title/)
    rendered.should match(/MyText/)
    rendered.should match(/false/)
    rendered.should match(/3/)
    rendered.should match(/4/)
    rendered.should match(/5/)
    rendered.should match(/6/)
    rendered.should match(/false/)
    rendered.should match(/7/)
  end
end
