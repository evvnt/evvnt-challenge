class API::VenuesController < ApplicationController
  def index
    render json: Venue.all.map { |v| {id: v.id, name: v.name} }
  end
end
