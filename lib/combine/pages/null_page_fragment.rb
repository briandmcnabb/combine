module Combine
  class NullPageFragment
    def checksum() nil end

    def select(selector)
      Array.new
    end
  end
end