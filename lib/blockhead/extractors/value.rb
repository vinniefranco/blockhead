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
        if arg.is_a?(Hash) && object.is_a?(String) && modifier
          send(:"#{modifier}_modifier")
        else
          object
        end
      end

      def modifier
        arg[:with]
      end

      def pretty_print_modifier
        object.split(/ |\_/).map(&:capitalize).join(' ').strip
      end
    end
  end
end
