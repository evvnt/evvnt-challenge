class EventImportWorker
  include Sidekiq::Worker

  def perform(event)
    puts event['title']
  end
end
