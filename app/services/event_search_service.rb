class EventSearchService
  attr_accessor :venue_ids, :page, :results, :total_entries

  def initialize(venues, page)
    @venue_ids ||= venues.nil? ? [] : venues
    @page = page || 1
    @total_entries = 0
    get_events
  end

  def get_events
    query = Event.scoped
    query = query.where(venue_id: @venue_ids) if @venue_ids.length > 0
    @results = query.paginate(page: @page)
    @total_entries = @results.total_entries
  end

  def json_results
    return {
      total_entries: @total_entries,
      page_size: @results.length,
      page: @page.to_i,
      events: @results.map { |event| {
        id: event.id,
        title: event.title,
        summary: event.summary,
        start_time: event.start_time,
        end_time: event.end_time
      }}
    }.to_json
  end
end
