# frozen_string_literal: true

require "rails_helper"

module Socializer
  RSpec.describe Groups::ActivitiesController, type: :routing do
    routes { Socializer::Engine.routes }

    describe "routing" do
      it "does not route to #index" do
        expect(get: "/groups/1/invitations").not_to be_routable
      end

      it "does not route to #new" do
        expect(get: "/groups/1/invitations/new").not_to be_routable
      end

      it "does not route to #show" do
        expect(get: "/groups/1/invitations/1/show").not_to be_routable
      end

      it "does not route to #edit" do
        expect(get: "/groups/1/invitations/1/edit").not_to be_routable
      end

      it "routes to #create" do
        expect(post: "/groups/1/invite/1")
          .to route_to("socializer/groups/invitations#create",
                       id: "1",
                       person_id: "1")
      end

      context "does not route to #update" do
        it { expect(patch: "/groups/1/invitations/1").not_to be_routable }
        it { expect(put: "/groups/1/invitations/1").not_to be_routable }
      end

      it "does not route to #destroy" do
        expect(delete: "/groups/1/invitations/1").not_to be_routable
      end
    end
  end
end
