class Api::V1::ChartmogulController < ApplicationController
	def metrics
		auth = {:username => ENV['CHARTMOGUL_TOKEN'], :password => ENV['CHARTMOGUL_KEY']}
		today = Time.now.strftime("%Y-%m-%d")
		@metrics = HTTParty.get("https://api.chartmogul.com/v1/metrics/all?start-date=2019-09-11&end-date=#{today}", :basic_auth => auth)
		render :json => @metrics
	end
end
