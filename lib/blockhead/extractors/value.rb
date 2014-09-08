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
        if object.is_a?(String) && Blockhead.pretty_print
          pretty
        else
          object
        end
      end

      def pretty
        object.split(/ |\_/).map(&:capitalize).join(' ').strip
      end
    end
  end
end
