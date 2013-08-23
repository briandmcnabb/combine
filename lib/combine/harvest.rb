module Combine
  class Harvest

  end
end

require 'hashie'

module Combine
  class HarvestYield < SimpleDelegator
    def initialize(metadata={})
      @metadata = metadata
      @delegate_sd_obj = Hashie::Mash.new
    end

    attr_reader :metadata

    def attributes
      self.keys
    end

    def log

    end

    def debug

    end

    def errors
      @errors ||= []
    end

    def errors?
      !errors.empty?
    end

    def serialize
      {
        value:    @delegate_sd_obj.to_hash,
        metadata: metadata,
        errors:   errors,
        log:      log,
        debug:    debug
      }
    end
  end
end