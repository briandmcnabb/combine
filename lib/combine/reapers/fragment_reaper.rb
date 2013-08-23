module Combine
  class FragmentReaper

    def initialize(fragment, pattern, harvest=HarvestYield.new)
      @fragment = fragment
      @pattern  = pattern
      @harvest  = harvest
    end

    def start(opts={})
      thresh_fields
      reap_sub_pages
      @harvest
    end


  private

    def thresh_fields
      @pattern.fields.inject(@harvest) do |memo,(name,pattern)|
        memo[name] = FieldThresher.new(@fragment, pattern).start || memo[name]
        memo
      end
    end

    def reap_sub_pages
      @pattern.sub_pages.map do |pattern|
        uri = LinkThresher.new(@fragment, pattern.uri_selector).start
        PageReaper.new(uri, pattern, @harvest)
      end
    end
  end
end