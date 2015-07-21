require "rails_helper"

module Socializer
  RSpec.describe Groups::InvitationsController, type: :controller do
    routes { Socializer::Engine.routes }

    # Create a user and a group
    let(:user) { create(:person) }

    let(:group) do
      create(:group, activity_author: user.activity_object)
    end

    describe "when not logged in" do
      describe "POST #create" do
        let(:invited_user) { create(:person) }

        it "requires login" do
          post :create, id: group, person_id: invited_user
          expect(response).to redirect_to root_path
        end
      end
    end

    describe "when logged in" do
      # Setting the current user
      before { cookies.signed[:user_id] = user.guid }

      describe "POST #create" do
        let(:invited_user) { create(:person) }

        it "redirects to groups#show" do
          post :create, id: group, person_id: invited_user
          expect(response).to redirect_to group_path(group)
        end
      end
    end
  end
end
