module LatestStockPrice
  module Resources
    class Price < Base
      attr_reader :indicies

      def initialize(indicies)
        @indicies = indicies
      end

      def action
        'get'
      end

      def path
        '/price'
      end

      def params
        { Indices: indicies }
      end
    end
  end
end
