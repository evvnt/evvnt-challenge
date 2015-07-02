class EvvntService
  include HTTParty

  format :json
  base_uri 'api.sandbox.evvnt.com'

  class EvvntApiError < HTTParty::Error; end

  def initialize(username, password)
    @basic_auth = {
      username: username,
      password: password
    }
  end

  def events(query={})
    self.class.get('/events', {
      basic_auth: @basic_auth,
      query: query
    })
  end
end
