class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :commentable, polymorphic: true

  attr_accessible :commentable, :user, :text
end
