class WelcomeController < ApplicationController
	def index
		# CREATE 'BASIC AUTHORISATION' VARIABLE/TOKEN
		# ACTUAL KEYS REMOVED FOR SECURITY
		api_name = 0
		api_key = 0
		auth = {:username => api_name,
			:password => api_key }

		# CONNECT TO THE API AND PASS IN THE ABOVE CREDENTIALS
		response = HTTParty.get('https://api.sandbox.evvnt.com/events/',
			:basic_auth => auth)

		# PARSE THE RESULTS IN JSON FOR DISPLAY IN THE VIEW
		@result = JSON.parse(response.body)
	end
end