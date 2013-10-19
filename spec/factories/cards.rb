# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :card do
    owner_id 1
    assignment_id 1
    list nil
    title "MyString"
    body "MyText"
    due_date "2013-10-19"
    done false
    comment_count 1
    document_count 1
    checklist_total_count 1
    checklist_done_count 1
    private false
    sort 1
  end
end
