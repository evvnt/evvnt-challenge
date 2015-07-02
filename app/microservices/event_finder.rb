class EventFinder
  def initialize(event)
    @event = event
  end

  def find_or_create
    find_by_remote_id || create_from_hash
  end

  private

  attr_accessor :event

  def find_by_remote_id
    event = Event.find_by_remote_id(event['id'])
    update event
    event
  end

  def create_from_hash
    create_event.tap do |event|
      event.venue = VenueFinder.new(event['venue']).find_or_create
    end
  end

  def update(event)
    if event
      event.update_attributes(
        title: event['title'],
        summary: event['summary'],
        start_time: event['start_time'],
        end_time: event['end_time'],
        keywords: event['keywords'],
        last_updated: event['timestamp']
      )
    end
  end

  def create_event
    Event.create(
      title: event['title'],
      summary: event['summary'],
      start_time: event['start_time'],
      end_time: event['end_time'],
      keywords: event['keywords'],
      last_updated: event['timestamp'],
      remote_id: event['id']
    )
  end
end
