module Combine
  class LinkValidator
    Error = Class.new(StandardError)

    def initialize(uri)
      @raw_uri = uri
    end

    def normalize
      @uri ||= normalize_uri(@raw_uri)
    end

    def test
      normalize

      begin
        evaluate_response Net::HTTP.new(host, port).request_head(path)
      rescue => exception
        raise Error.new("#{uri} returned the following exception at #{Time.now}: #{exception}")
      end
    end



  private

    def normalize_uri(uri)
      uri = URI.encode(uri) unless uri.include?('%')
      uri = URI.parse(uri)
    rescue => exception
      raise Error.new("#{uri} could not be parsed, resulting in: #{exception}")
    end

    def evaluate_response(response)
      case response
      when Net::HTTPSuccess, Net::HTTPRedirection
        true
      else
        raise Error.new("#{uri} returned a #{response.code} status code at #{Time.now}.")
      end
    end

    def host() @uri.host end
    def port() @uri.port end
    def path() @uri.path end
  end
end