#
# Namespace for the Socializer engine
#
module Socializer
  module Groups
    class OwnershipsController < ApplicationController
      before_action :authenticate_user

      # GET /groups/ownerships
      def index
        @ownerships = current_user.groups
      end
    end
  end
end
