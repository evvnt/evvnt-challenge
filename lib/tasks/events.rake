namespace :events do
  desc 'Import from API events which are newer than locally stored ones'
  task import: :environment do
    # We need to use the HTTParty class for the Evvnt API
    require 'evvnt_service'

    # Get last event in the database
    last_updated_event = Event.recent.first.last_updated

    # Connect to & store Evvnt API
    evvnt_api = EvvntService.new(ENV['API_USERNAME'], ENV['API_PASSWORD'])

    # Start at page 1
    page = 1

    # Loop through events from API newer than last_updated_event
    loop do
      events_from_api ||= evvnt_api.events({
        max_results: 20,
        page: page,
        newer_than: last_updated_event
      })

      # Break if HTTParty responds with nothing
      break if events_from_api.length == 0

      # Add to local results array
      events_from_api.each do |event|
        (@events_to_import ||= []) << event
      end

      # Make sure array is reset for next go
      events_from_api = nil

      # Increment page integer
      page += 1
    end

    # Cycle through found events if any to play with
    unless @events_to_import.length.blank?
      @events_to_import.each do |event|
        # Add to worker to add or update
        EventImportWorker.perform_async(event)
      end
    end
  end
end
