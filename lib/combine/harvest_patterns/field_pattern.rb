module Combine
  class FieldPattern
    def initialize(value)
      @value = normalize(value)
    end

    def selector
      @value['selector'].to_s
    end

    def nodes
      @value['nodes']
    end

    def html
      @value['html']
    end

    def text
      @value['text']
    end



  private

    def normalize(pattern)
      # TODO: Needs refactoring.  The intent of this code obfuscated.
      #       What happens when the selector value is an empty string?

      if pattern.respond_to?(:fetch)
        # If no selector is provided self select otherwise do nothing
        pattern['selector'] =  pattern.fetch('selector') { 'SELF' }
      else
        # If pattern isn't a hash, set the pattern value to hash key selector
        pattern = { 'selector' => pattern }
      end

      pattern['selector'] = SelectorPattern.new pattern['selector']#.presence this is a method provided by Rails CoreExt
      pattern
    end
  end
end