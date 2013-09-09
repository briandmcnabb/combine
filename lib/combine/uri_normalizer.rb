module Combine
  module URINormalizer
    Error = Class.new(StandardError)

    def build(base, path)
      raise Error.new('Args cannot be nil') if base.nil? || path.nil?
      ::URI.join base, soft_encode(path.strip)
    end

    def self.normalize(uri)
      ::URI.parse soft_encode(uri)
    end

    def self.soft_encode(uri)
      ::URI.encode(uri) unless uri.include?('%')
    end
  end
end