class VenueFinder
  def initialize(hash)
    @hash = hash
  end

  def find_or_create
    find_by_remote_id || create_from_hash
  end

  private

  attr_accessor :hash

  def find_by_remote_id
    venue = Venue.find_by_remote_id(hash['id'])
    update(venue)
    venue
  end

  def update(venue)
    if venue
      venue.update_attributes(
        name: hash['name'],
        keywords: hash['keywords']
      )
    end
  end

  def create_from_hash
    Venue.create(
      name: hash['name'],
      keywords: hash['keywords'],
      remote_id: hash['id']
    )
  end
end
