class EventImportWorker
  include Sidekiq::Worker

  def perform(event)
    STDERR.puts "Working: #{event['title']}"
    EventFinder.new(event).find_or_create
  end
end
