# frozen_string_literal: true

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :person_profile, class: Socializer::Person::Profile do
    display_name "test"
    url "http://test.org"
    association :person, factory: :person
  end
end
