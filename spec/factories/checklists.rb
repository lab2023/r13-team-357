# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :checklist do
    card nil
    title "MyString"
    done false
    done_at "2013-10-20 08:17:13"
  end
end
