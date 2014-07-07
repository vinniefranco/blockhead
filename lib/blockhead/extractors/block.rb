module Blockhead
  module Extractors
    class Block < Abstract
      def valid?
        !!@proc
      end

      def extract_value
        Schema.define(@object, &@proc).marshal
      end
    end
  end
end
