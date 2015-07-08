class Venue < ActiveRecord::Base
  attr_accessible :keywords, :name, :remote_id

  validates :name, presence: true
  validates :remote_id, uniqueness: true

  has_many :events
end
