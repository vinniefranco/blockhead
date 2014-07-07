module Blockhead
  module Extractors
    class Value < Abstract
      def valid?
        true
      end

      def extract_value
        @value
      end
    end
  end
end
