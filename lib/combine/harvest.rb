module Combine
  class Harvest
    def initialize(config={})
      @config = config
    end

    def index_page_reaper
      IndexPageReaper.config(self)
    end

    def page_reaper
      PageReaper.config(self)
    end

    def fragment_reaper
      FragmentReaper.config(self)
    end

    def field_thresher
      FieldThresher.config(self)
    end

    def link_thresher
      LinkThresher.config(self)
    end

    def html_winnower
      HTMLWinnower.config(self)
    end

    def _yield
      Yield.config(self)
    end
  end
end