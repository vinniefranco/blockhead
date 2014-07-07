module Blockhead
  module Extractors
    class Array < Abstract
      def valid?
        @proc && @object.is_a?(::Array)
      end

      def extract_value
        @object.map { |obj| Schema.define(obj, &@proc).marshal }
      end
    end
  end
end
