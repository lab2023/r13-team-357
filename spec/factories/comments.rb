# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :comment do
    card nil
    user nil
    body "MyText"
  end
end
