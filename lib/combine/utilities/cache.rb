module Combine
  class Cache
    def initialize(store=OpenStruct.new(fetch: nil))
      @store = store
    end

    def fetch(key, &block)
      value = cache.fetch(key)

      if value.nil?
        value = block.call(*args)
        cache.write(key, value)
      end

      value
    end
  end
end