require 'delegate'
require 'hashie'

module Combine
  class Yield < SimpleDelegator
    include ProtoConfig

    def initialize
      @errors   = []
      @delegate_sd_obj = Hashie::Mash.new
    end

    def attributes
      self.keys
    end

    def log

    end

    def debug

    end

    def errors
      @errors
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

    def to_json
      serialize.to_json
    end


  private

    def metadata
      @metadata ||= config.fetch(:metadata){ Hash.new }
    end
  end
end