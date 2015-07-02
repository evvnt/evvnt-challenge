class EventImportWorker
  include Sidekiq::Worker

  def perform(event)
    STDERR.puts "Working: #{event['title']}"
  end
end
