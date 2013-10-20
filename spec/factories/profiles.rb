# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :profile do
    twitter "MyString"
    stackoverflow "MyString"
    github "MyString"
    facebook "MyString"
    blog "MyString"
    linkedin "MyString"
    bio "MyText"
    user nil
  end
end
