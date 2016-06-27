# frozen_string_literal: true

require "rails_helper"

module Socializer
  RSpec.describe Person::Education, type: :model do
    let(:education) { build(:person_education) }

    it "has a valid factory" do
      expect(education).to be_valid
    end

    context "mass assignment" do
      it { is_expected.to allow_mass_assignment_of(:school_name) }
      it { is_expected.to allow_mass_assignment_of(:major_or_field_of_study) }
      it { is_expected.to allow_mass_assignment_of(:started_on) }
      it { is_expected.to allow_mass_assignment_of(:ended_on) }
      it { is_expected.to allow_mass_assignment_of(:current) }
      it { is_expected.to allow_mass_assignment_of(:courses_description) }
    end

    context "relationships" do
      it { is_expected.to belong_to(:person) }
    end

    context "validations" do
      it { is_expected.to validate_presence_of(:person) }
      it { is_expected.to validate_presence_of(:school_name) }
      it { is_expected.to validate_presence_of(:started_on) }
    end
  end
end
