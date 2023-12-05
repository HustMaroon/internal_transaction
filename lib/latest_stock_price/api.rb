module LatestStockPrice
  class Api
    def connection
      @connection ||= Faraday.new(configuration.base_url) do |f|
        f.request :retry
        f.request :json
        f.response :json
        f.adapter configuration.adapter
        f.option.time_out = configuration.time_out
      end
    end

    def configuration
      @configuration ||= Configuration.new
    end

    def handle_response
      raise Error, '' unless response.success?

      response.body
    end
  end
end
