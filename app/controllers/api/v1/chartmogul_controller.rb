class Api::V1::ChartmogulController < ApplicationController
	def helloworld
		render :json => {:hello => :world}

	end

	def metrics
		data = Rails.cache.fetch('api:open:chartmogul', {expires_in: 5.minutes, public: true, raw: true}) do
			auth = {:username => ENV['CHARTMOGUL_TOKEN'], :password => ENV['CHARTMOGUL_KEY']}
			today = Time.now.strftime("%Y-%m-%d")
			return HTTParty.get("https://api.chartmogul.com/v1/metrics/all?start-date=2019-09-11&end-date=#{today}", :basic_auth => auth)
		end
		render :json => @data
	end

end
