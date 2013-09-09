module Combine
  class PageReaper
    include ProtoConfig
    proto_collaborators :_yield, :fragment_reaper

    def initialize(uri, pattern, _yield=_yield.new)
      @uri     = uri
      @pattern = pattern
      @_yield = _yield
    end

    def start
      fragment = page.fragment_matching(@pattern.wrapper)
      fragment_reaper.build(fragment, @pattern, @_yield).start
      @_yield
    end


  private

    def page
      begin
        Page.fetch(uri)
      rescue => exception
        msg = "Fetching #{uri.to_s} threw the following: #{exception}"
        @_yield.errors << msg and NullPage.new
      end
    end
  end
end