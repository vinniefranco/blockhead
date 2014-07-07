module Blockhead
  module Extractors
    class Abstract
      attr_writer :next
      attr_reader :object

      def initialize(object, *args, proc)
        @object = object
        @args = args
        @proc = proc
      end

      def valid?
        fail '#valid? not implemented'
      end

      def extract_value
        fail '#extract_value not implemented'
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
