module Blockhead
  module Extractors
    class Abstract
      def initialize(value, *args, proc)
        @value = value
        @args = args
        @proc = proc
      end

      def next=(extractor)
        @next = extractor
      end

      def extract
        if valid?
          extract_value
        else
          @next.extract
        end
      end
    end
  end
end
