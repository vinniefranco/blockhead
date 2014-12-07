module Blockhead
  class ValueExtractor
    extend Forwardable

    def_delegator :@extractor, :extract
    attr_reader :extractor

    def initialize(value, arg, &block)
      proc = block.to_proc if block

      @extractor = Extractors::Enumerable.new value, arg, proc

      extractors.inject(extractor) do |fallback, link|
        fallback.next = link.new value, arg, proc
      end
    end

    private

    def extractors
      [Extractors::Block, Extractors::Proc, Extractors::Value]
    end
  end
end
