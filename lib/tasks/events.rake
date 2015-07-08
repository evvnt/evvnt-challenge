namespace :events do
  desc 'Import from API events which are newer than locally stored ones'
  task import: :environment do
    require 'evvnt_service'

    last_updated_event = Event.recent.first_or_initialize.last_updated
    evvnt_api = EvvntService.new(ENV['API_USERNAME'], ENV['API_PASSWORD'])
    page = 1

    loop do
      events_from_api ||= evvnt_api.events({
        max_results: 20,
        page: page,
        newer_than: last_updated_event
      })

      break if events_from_api.length == 0

      events_from_api.each do |event|
        (@events_to_import ||= []) << event
      end

      page += 1
    end

    if !@events_to_import.nil? && @events_to_import.length > 0
      @events_to_import.each do |event|
        EventImportWorker.perform_async(event)
      end
    end
  end
end
