class API::VenuesController < ApplicationController
  def index
    render json: Venue.scoped.paginate(page: params[:page])
  end
end
