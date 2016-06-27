# frozen_string_literal: true

require "rails_helper"

module Socializer
  class Activity
    module Services
      RSpec.describe Unlike, type: :service do
        let(:liking_person) { create(:person) }
        let(:liked_activity_object) { create(:activity_object) }
        let(:like) { Like.new(unlike_attributes) }
        let(:unlike) { Unlike.new(unlike_attributes) }
        let(:results) { unlike.call }

        let(:unlike_attributes) do
          { actor: liking_person,
            activity_object: liked_activity_object }
        end

        context "check return type when unliking a liked object" do
          before do
            like.call
          end

          it { expect(results.persisted?).to eq(true) }
          it { expect(results.verb.display_name).to eq("unlike") }
          it { expect(results).to be_kind_of(Socializer::Activity) }
        end

        context "check the like_count and liked_by" do
          before do
            like.call
            unlike.call

            liked_activity_object.reload
          end

          it { expect(liked_activity_object.like_count).to eq(0) }
          it { expect(liked_activity_object.liked_by.size).to eq(0) }
        end

        context "can't unlike without a like" do
          before do
            unlike.call

            liked_activity_object.reload
          end

          it { expect(liked_activity_object.like_count).to eq(0) }
          it { expect(liked_activity_object.liked_by.size).to eq(0) }

          it "should be Socializer::Activity::ActiveRecord_Relation" do
            expect(results)
              .to be_kind_of(Socializer::Activity::ActiveRecord_Relation)
          end
        end
      end
    end
  end
end
