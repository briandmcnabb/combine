module Combine
  module Factory
    def self.build(uri, pattern, opts={})
      pattern  = PagePattern.new(pattern)
      reaper = get_reaper(pattern.title)
      opts.merge(metadata)
      reaper.new(uri, pattern, opts)
    end

    def self.get_reaper(name)
      name = name.to_sym
      reaper.fetch(name) { PageReaper }
    end

    def self.reaper
      { index_page: IndexPageReaper }
    end

    def metadata
      {
        harvest_uuid: SecureRandom.uuid
      }
    end
  end
end
