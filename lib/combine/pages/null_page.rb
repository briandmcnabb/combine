module Combine
  class NullPage
    def hexdigest() nil end

    def fragments_matching(pattern)
      Array.new
    end

    def fragment_matching(pattern)
      NullPageFragment.new
    end

    def to_fragment
      NullPageFragment.new
    end
  end
end