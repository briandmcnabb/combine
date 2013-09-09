require 'forwardable'

module Combine
  class SelectorPattern
    extend Forwardable

    def_delegators :@value, :to_s

    def initialize(value)
      @value = normalize(value)
    end

  private

    def normalize(selector)
      selector = selector.values     if selector.respond_to?(:values)
      selector = selector.join(', ') if selector.respond_to?(:join)
      selector
    end
  end
end