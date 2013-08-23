module Combine
  module URINormalizer
    def self.normalize(uri)
      ::URI.parse soft_encode(uri)
    end

    def self.soft_encode(uri)
      ::URI.encode(uri) unless uri.include?('%')
    end
  end
end