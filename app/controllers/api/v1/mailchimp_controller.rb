class Api::V1::MailchimpController < ApplicationController

	def subscribers
		mailchimp_root = "https://#{ENV['MAILCHIMP_DC']}.api.mailchimp.com/3.0"
		@data = Rails.cache.fetch('api:open:mailchimp', {expires_in: 5.minutes, public: true, raw: true}) do
			puts "Fetching fresh data"
			auth = {:username => "mailchimp docs say any string is ok here", :password => ENV['MAILCHIMP_API_KEY']}
			HTTParty.get("#{mailchimp_root}/lists/#{ENV['MAILCHIMP_LIST_ID']}", :basic_auth => auth)
		end
		render :json => @data['stats']
	end

end
