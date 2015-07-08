class Event < ActiveRecord::Base
  attr_accessible :end_time, :keywords, :remote_id, :start_time, :summary, :title, :last_updated, :venue

  scope :recent, order('last_updated DESC').limit(1)
  scope :upcoming, where('events.start_time > ?', DateTime.now.iso8601)
  scope :ordered_by_start, order('start_time asc')

  validates :title, :start_time, :remote_id, presence: true
  validates :remote_id, uniqueness: true

  belongs_to :venue

  self.per_page = 20

  def last_updated
    super || (DateTime.now - 7.months).iso8601
  end
end
