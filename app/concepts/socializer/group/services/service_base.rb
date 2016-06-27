# frozen_string_literal: true
#
# Namespace for the Socializer engine
#
module Socializer
  #
  # Namespace for Group related objects
  #
  class Group
    #
    # Namespace for Service related objects
    #
    module Services
      #
      # Base class for Group::Service
      #
      class ServiceBase
        include ActiveModel::Model
        include Utilities::Message

        attr_reader :group, :person

        validates :group, presence: true, type: Socializer::Group
        validates :person, presence: true, type: Socializer::Person

        # Initializer
        #
        # @param [Socializer:Group] group: the group to invite the person to
        # @param [Socializer:Person] person: the person that is being invited
        # to the group
        #
        # @return [Socializer::Group::Services] returns an instance of
        # the object that inherits from [ServiceBase]
        def initialize(group:, person:)
          @group  = group
          @person = person

          raise(ArgumentError, errors.full_messages.to_sentence) unless valid?
        end

        # @return [Socializer:Membership/FalseClass] Deletes the record in the
        # database and freezes this instance to reflect that no changes should
        # be made (since they can't be persisted). If the before_destroy
        # callback returns false the action is cancelled and leave returns
        # false.
        def call
          raise(NotImplementedError, "You must implement the call method")
        end
      end
    end
  end
end
