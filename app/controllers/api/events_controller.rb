class API::EventsController < ApplicationController
  def index
    @event_search_service = EventSearchService.new(params[:venue_ids], params[:start_time], params[:end_time], params[:page])
    render json: @event_search_service.json_results
  end
end
