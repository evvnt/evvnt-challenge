class EventSearchService
  attr_accessor :keywords, :venue_ids, :start_time, :end_time, :page, :results, :total_entries

  def initialize(options={})
    @keywords = options[:keywords]
    @venue_ids = options[:venues].nil? ? [] : options[:venues]
    @start_time = options[:start_time]
    @end_time = options[:end_time]
    @page = options[:page].blank? ? 1 : options[:page]
    @total_entries = 0
    get_events
  end

  def get_events
    query = Event.scoped
    query = query.joins(:venue)
    query = query.upcoming if @start_time.blank?
    query = query.ordered_by_start
    query = query.where('events.keywords like ? or events.title like ?', "%#{@keywords}%", "%#{@keywords}%") if !@keywords.blank?
    query = query.where(venue_id: @venue_ids) if @venue_ids && @venue_ids.length > 0
    query = query.where('events.start_time >= ?', self.formatted_start_time) if !@start_time.blank?
    query = query.where('events.end_time <= ?', self.formatted_end_time) if !@end_time.blank?
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

  protected

  def formatted_start_time
    DateTime.parse(@start_time).iso8601
  end

  def formatted_end_time
    DateTime.parse(@end_time).iso8601
  end
end
