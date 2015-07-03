class API::EventsController < ApplicationController
  def index
    @events = Event.scoped.paginate(page: params[:page])
    render json: @events
  end

  def search
    # Search
  end
end
