module Blockhead
  module Extractors
    class Array < Abstract
      def valid?
        @proc && object.is_a?(::Array)
      end

      def extract_value
        object.map { |obj| Block.new(obj, [], @proc).extract_value }
      end
    end
  end
end
