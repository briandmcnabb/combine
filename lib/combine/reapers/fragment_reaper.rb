module Combine
  class FragmentReaper
    include ProtoConfig
    proto_collaborators :_yield, :field_thresher, :link_thresher, :page_reaper

    def initialize(fragment, pattern, _yield=_yield.new)
      @fragment = fragment
      @pattern  = pattern
      @_yield  = _yield
    end

    def start(opts={})
      thresh_fields
      reap_sub_pages
      @_yield
    end


  private

    def thresh_fields
      @pattern.fields.inject(@_yield) do |memo,(name,pattern)|
        memo[name] = field_thresher.new(@fragment, pattern).start || memo[name]
        memo
      end
    end

    def reap_sub_pages
      @pattern.sub_pages.map do |pattern|
        uri = link_thresher.new(@fragment, pattern.uri_selector).start
        page_reaper.new(uri, pattern, @_yield)
      end
    end
  end
end