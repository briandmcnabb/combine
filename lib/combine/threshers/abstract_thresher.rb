# TODOs ########################################################
#
#   1.) Need to define a dsl for what code can be executed?
#       Create an object that defines the dsl and then
#       pass in self along with the string to be eval'd.
#
#   2.) Need to improve the error handling logging around
#       get_custom and post_process
#

module Combine
  class AbstractThresher
    Error = Class.new(StandardError)

    def initialize(fragment, pattern)
      @fragment = fragment
      @pattern  = pattern
    end

    attr_accessor :nodes

  private

    def get_nodes
      get_custom('nodes') || @fragment.select(@pattern.selector)
    end


    def get_custom(field)
      eval(@pattern[field].to_s)
    rescue
      nil
    end

    def post_process(field)
      unless @pattern[field].nil?
        self.instance_variable_set "@#{field.to_s}", get_custom(field)
      end
    end
  end
end