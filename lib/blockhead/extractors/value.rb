module Blockhead
  module Extractors
    class Value < Abstract
      def valid?
        true
      end

      def extract_value
        value
      end

      private

      def value
        if object.is_a?(String) && args.first == :pretty_print
          object.split(/ |\_/).map(&:capitalize).join(' ').strip
        else
          object
        end
      end
    end
  end
end
