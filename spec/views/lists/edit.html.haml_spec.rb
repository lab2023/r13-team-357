require 'spec_helper'

describe "lists/edit" do
  before(:each) do
    @list = assign(:list, stub_model(List,
      :name => "MyString",
      :sort => 1,
      :project => nil
    ))
  end

  it "renders the edit list form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", list_path(@list), "post" do
      assert_select "input#list_name[name=?]", "list[name]"
      assert_select "input#list_sort[name=?]", "list[sort]"
      assert_select "input#list_project[name=?]", "list[project]"
    end
  end
end
