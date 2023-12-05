module LatestStockPrice
  module Resources
    class PriceAll < Base
      attr_reader :identifier

      def initialize(identifier)
        @identifier = identifier
      end

      def action
        'get'
      end

      def path
        '/any'
      end

      def params
        { Identifier: identifier }
      end
    end
  end
end
