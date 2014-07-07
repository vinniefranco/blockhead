module Blockhead
  module Extractors
    class Value < Abstract
      def valid?
        true
      end

      def extract_value
        object
      end
    end
  end
end
