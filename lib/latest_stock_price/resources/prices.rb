module LatestStockPrice
  module Resources
    class Prices < Base
      attr_reader :indicies

      def initialize(indicies)
        @indicies = indicies
      end

      def action
        'get'
      end

      def path
        '/prices'
      end

      def params
        { Indices: indicies }
      end
    end
  end
end
