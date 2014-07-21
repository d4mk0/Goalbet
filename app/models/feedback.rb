class Feedback < ActiveRecord::Base
  validates_presence_of :subject, :text, :user_name
end
