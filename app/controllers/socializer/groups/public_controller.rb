#
# Namespace for the Socializer engine
#
module Socializer
  module Groups
    class PublicController < ApplicationController
      before_action :authenticate_user

      # GET /groups/public
      def index
        @groups = Group.public
      end
    end
  end
end
