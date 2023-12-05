module LatestStockPrice
  module Resources
    class Base
      def call
        response = connection.send(:action, path, params)
        handle_response(response)
      end
    end
  end
end
