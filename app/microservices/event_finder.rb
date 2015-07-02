class EventFinder
  def initialize(hash)
    @hash = hash
  end

  def find_or_create
    find_by_remote_id || create_from_hash
  end

  private

  attr_accessor :hash

  def find_by_remote_id
    event = Event.find_by_remote_id(hash['id'])
    update(event)
    event
  end

  def create_from_hash
    create_event.tap do |event|
      event.venue = VenueFinder.new(hash['venue']).find_or_create
    end
  end

  def update(event)
    if event
      event.update_attributes(
        title: hash['title'],
        summary: hash['summary'],
        start_time: hash['start_time'],
        end_time: hash['end_time'],
        keywords: hash['keywords'],
        last_updated: hash['timestamp']
      )
    end
  end

  def create_event
    Event.create(
      title: hash['title'],
      summary: hash['summary'],
      start_time: hash['start_time'],
      end_time: hash['end_time'],
      keywords: hash['keywords'],
      last_updated: hash['timestamp'],
      remote_id: hash['id']
    )
  end
end
