class API::VenuesController < ApplicationController
  def index
    render json: Venue.paginate(page: params[:page]).map { |v| {id: v.id, name: v.name} }
  end
end
