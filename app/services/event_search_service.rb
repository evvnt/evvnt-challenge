class EventSearchService
  attr_accessor :keywords, :venue_ids, :start_time, :end_time, :page, :results, :total_entries

  def initialize(keywords, venues, start_time, end_time, page)
    @keywords = keywords
    @venue_ids = venues.nil? ? [] : venues
    @start_time = start_time
    @end_time = end_time
    @page = page.blank? ? 1 : page

    @total_entries = 0
    get_events
  end

  def get_events
    query = Event.scoped
    query = query.joins(:venue)
    query = query.where('events.keywords like ? or events.title like ?', "%#{@keywords}%", "%#{@keywords}%") if !@keywords.blank?
    query = query.where(venue_id: @venue_ids) if @venue_ids && @venue_ids.length > 0
    query = query.where('events.start_time >= ?', parsed_date_time(@start_time)) if !@start_time.blank?
    query = query.where('events.end_time <= ?', parsed_date_time(@end_time)) if !@end_time.blank?
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
        end_time: event.end_time,
        venue: event.venue.name
      }}
    }.to_json
  end

  private

  def parsed_date_time(date_time)
    DateTime.parse(date_time).iso8601
  end
end
