require 'test_helper'
require 'net/ping'
require 'httparty'

class WelcomeControllerTest < ActionController::TestCase
	# THIS TEST WAS AUTOMATICALLY GENERATED
	test "should get index" do
		get :index
		assert_response :success
	end

	# REQUIRES THE 'net-ping' GEM AND WILL FAIL IF THE API CANNOT BE REACHED
	def test_net_ping
		p Net::Ping::TCP.new('api.sandbox.evvnt.com', 'https').ping?
	end

	# ALTERNATIVE TO ABOVE, THE 'httparty' GEM ALSO CONNECTS TO THE API
	def test_httparty
		HTTParty.get('https://api.sandbox.evvnt.com')
	end
end