require 'spec_helper'

describe "cards/edit" do
  before(:each) do
    @card = assign(:card, stub_model(Card,
      :owner_id => 1,
      :assignment_id => 1,
      :list => nil,
      :title => "MyString",
      :body => "MyText",
      :done => false,
      :comment_count => 1,
      :document_count => 1,
      :checklist_total_count => 1,
      :checklist_done_count => 1,
      :private => false,
      :sort => 1
    ))
  end

  it "renders the edit card form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", card_path(@card), "post" do
      assert_select "input#card_owner_id[name=?]", "card[owner_id]"
      assert_select "input#card_assignment_id[name=?]", "card[assignment_id]"
      assert_select "input#card_list[name=?]", "card[list]"
      assert_select "input#card_title[name=?]", "card[title]"
      assert_select "textarea#card_body[name=?]", "card[body]"
      assert_select "input#card_done[name=?]", "card[done]"
      assert_select "input#card_comment_count[name=?]", "card[comment_count]"
      assert_select "input#card_document_count[name=?]", "card[document_count]"
      assert_select "input#card_checklist_total_count[name=?]", "card[checklist_total_count]"
      assert_select "input#card_checklist_done_count[name=?]", "card[checklist_done_count]"
      assert_select "input#card_private[name=?]", "card[private]"
      assert_select "input#card_sort[name=?]", "card[sort]"
    end
  end
end
