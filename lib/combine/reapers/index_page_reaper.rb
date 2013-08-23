module Combine
  class IndexPageReaper

    def initialize(uri, pattern, opts={})
      @uri     = uri
      @pattern = PagePattern.new(pattern)
      @opts    = opts
    end

    def start
      output = Array.new

      paginator.paginate do |page|
        page.fragments_matching(@pattern.wrapper).each do |fragment|
          harvest = Harvest.new(@opts[:metatdata])
          @output << FragmentReaper.new(fragment, @pattern, harvest).start
        end
      end

      output
    end


  private

    def paginator
      @paginator ||= Paginator.new(
        Page.fetch(@uri),
        @pattern.next_page_url,
        @opts
      )
    end
  end
end