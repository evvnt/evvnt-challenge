class Event < ActiveRecord::Base
  attr_accessible :end_time, :keywords, :remote_id, :start_time, :summary, :title

  scope :recent, order('events.last_updated DESC').limit(1)

  def last_updated
    super || DateTime.now.utc - 20.days
  end
end
