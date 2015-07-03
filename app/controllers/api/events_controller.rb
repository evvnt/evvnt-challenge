class API::EventsController < ApplicationController
  respond_to :json

  def index
    @events = Event.scoped.paginate(page: params[:page])

    respond_with @events
  end

  def search
    # Search
  end
end
