#
# Namespace for the Socializer engine
#
module Socializer
  module Memberships
    class ConfirmController < ApplicationController
      before_action :authenticate_user

      # POST /memberships/1/confirm
      def create
        @membership = Membership.find_by(id: params[:id])
        @membership.confirm

        redirect_to @membership.group
      end
    end
  end
end
