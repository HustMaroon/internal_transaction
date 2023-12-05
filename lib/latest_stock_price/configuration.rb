module LatestStockPrice
  class configuration
    attr_accessor :base_url, :time_out, :http_adapter

    def initialize
      @http_adapter = Faraday.default_adapter
      @time_out = 3
    end
  end
end
