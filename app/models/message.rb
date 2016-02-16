class Message < ActiveRecord::Base
  belongs_to :conversation
  belongs_to :user


  def message_time
    created_at.strftime("%m/%d/%y at %l:%M %p")
  end
end