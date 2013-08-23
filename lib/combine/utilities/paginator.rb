module Combine
  class Paginator

    def initialize(page, selector, opts={})
      @current_page = page
      @selector     = selector
      @max_pages    = opts[:max_pages] || Combine.config.max_pages
      @total_pages  = 0
    end

    def paginate(&block)
      while (@total_pages += 1) <= @max_pages do
        block.call(@current_page)
        get_next_page or break
      end
    end

    def get_next_page
      uri = LinkThresher.new(@current_page.to_fragment, @selector).start

      unless uri.nil?
        @current_page = Page.fetch(uri)
      end
    end
  end
end