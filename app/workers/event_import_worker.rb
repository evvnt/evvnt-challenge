class EventImportWorker
  include Sidekiq::Worker

  def perform(event)
    EventFinder.new(event).find_or_create
  end
end
