module Blockhead
  class ValueExtractor
    attr_reader :extractor

    def initialize(value, *args, &block)
      proc = block.to_proc if block

      @extractor = Extractors::Array.new(value, *args, proc)

      extractors.inject(extractor) do |fallback, link|
        fallback.next = link.new(value, *args, proc)
      end
    end

    def extract
      extractor.extract
    end

    private

    def extractors
      [Extractors::Block, Extractors::Proc, Extractors::Value]
    end
  end
end