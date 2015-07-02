class VenueFinder
  def initialize(venue)
    @venue = venue
  end

  def find_or_create
    find_by_remote_id || create_from_hash
  end

  private

  attr_accessor :venue

  def find_by_remote_id
    venue = Venue.find_by_remote_id(venue['id'])
    update venue
    venue
  end

  def update(venue)
    if venue
      venue.update_attributes(
        name: venue['name'],
        keywords: venue['keywords']
      )
    end
  end

  def create_from_hash
    Event.create(
      name: venue['name'],
      keywords: venue['keywords'],
      remote_id: venue['id']
    )
  end
end
