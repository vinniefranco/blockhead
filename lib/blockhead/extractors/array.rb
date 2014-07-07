module Blockhead
  module Extractors
    class Array < Abstract
      def valid?
        @proc && @value.is_a?(::Array)
      end

      def extract_value
        @value.map { |obj| Schema.define(obj, &@proc).marshal }
      end
    end
  end
end
