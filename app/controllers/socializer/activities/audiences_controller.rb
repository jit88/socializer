#
# Namespace for the Socializer engine
#
module Socializer
  module Activities
    class AudiencesController < ApplicationController
      before_action :authenticate_user!

      def index
        activity = Activity.find_by(id: params[:id])

        get_audience_for_activity(activity: activity)

        respond_to do |format|
          format.html { render layout: false if request.xhr? }
        end
      end

      private

      # REFACTOR: Move out of the controller.
      def get_audience_for_activity(activity:)
        @object_ids = []

        activity.audiences.each do |audience|
          audience_object_ids(audience)
        end

        # The actor of the activity is always part of the audience.
        @object_ids << activity.activitable_actor unless @object_ids.include?('public')

        # Remove any duplicates from the list. It can happen when, for example, someone
        # post a message to itself.
        @object_ids.uniq!
      end

      # REFACTOR: Move with build_audience and simplify
      def audience_object_ids(audience)
        # In case of CIRCLES audience, add each contacts of every circles
        # of the actor of the activity.
        privacy = audience.privacy

        case privacy
        when privacy.public?
          @object_ids << privacy
        when privacy.circles?
          @activity.actor.circles.each do |circle|
            circle.activity_contacts.each do |contact|
              @object_ids << contact
            end
          end
        else
          activity_object = audience.activity_object

          # The target audience is either a group or a person,
          # which means we can add it as it is in the audience list.
          return @object_ids << activity_object unless activity_object.circle?

          # In the case of LIMITED audience, then go through all the audience
          # circles and add contacts from those circles in the list of allowed
          # audience.
          activity_object.activitable.activity_contacts.each do |contact|
            @object_ids << contact
          end
        end
      end
    end
  end
end