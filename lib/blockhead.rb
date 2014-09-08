require 'blockhead/version'
require 'blockhead/schema'
require 'blockhead/marshaller'
require 'blockhead/option_key'
require 'blockhead/value_extractor'
require 'blockhead/extractors/abstract'
require 'blockhead/extractors/block'
require 'blockhead/extractors/enumerable'
require 'blockhead/extractors/proc'
require 'blockhead/extractors/value'

module Blockhead

  def self.configure
    yield self if block_given?
  end

  def self.pretty_print=(enabled = true)
    @pretty_print = enabled
  end

  def self.pretty_print
    @pretty_print
  end
end
