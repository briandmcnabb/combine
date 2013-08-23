module Combine
  class PageReaper

    def initialize(uri, pattern, harvest=HarvestYield.new)
      @uri     = uri
      @pattern = pattern
      @harvest = harvest
    end

    def start
      fragment = page.fragment_matching(@pattern.wrapper)
      FragmentReaper.new(fragment, @pattern, @harvest).start
      @harvest
    end


  private

    def page
      begin
        Page.fetch(uri)
      rescue => exception
        msg = "Fetching #{uri.to_s} threw the following: #{exception}"
        @harvest.errors << msg and NullPage.new
      end
    end
  end
end