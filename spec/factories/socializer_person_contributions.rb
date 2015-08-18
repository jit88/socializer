# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :person_contribution, class: Socializer::Person::Contribution do
    label "test"
    url "http://test.org"
    association :person, factory: :person
  end
end
