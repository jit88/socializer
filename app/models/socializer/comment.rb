#
# Namespace for the Socializer engine
#
module Socializer
  class Comment < ActiveRecord::Base
    include ObjectTypeBase

    attr_accessible :content

    belongs_to :activity_author, class_name: 'ActivityObject', foreign_key: 'author_id'

    def author
      @author ||= activity_author.activitable
    end
  end
end
