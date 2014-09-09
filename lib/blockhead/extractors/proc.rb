module Blockhead
  module Extractors
    class Proc < Abstract
      def valid?
        arg.is_a?(::Proc)
      end

      def extract_value
        arg.call
      end
    end
  end
end
