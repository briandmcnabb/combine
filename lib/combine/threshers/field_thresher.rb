# TODOs ########################################################
#
#   1.) Can we pass the array of nodes directly to the
#       HtmlToTextConverter so that we can avoid superfluous
#       document parsing.


module Combine
  class FieldThresher < AbstractThresher

    def initialize(fragment, pattern)
      super
      @html_winnower = HtmlWinnower.new
    end

    attr_accessor :html, :text

    def start
      return if @pattern.blank? # TODO: Is this necessary? Let's try to get rid of it.
      self.nodes = get_nodes

      unless nodes.empty?
        self.html = get_html
        self.text = get_text
        post_process('text')

        { html: html, text: text.strip }
      end
    end


  private

    def get_html
      get_custom('html') || nodes.map(&:to_html)
    end

    def get_text
      @html_winnower.start(nodes)
    end
  end
end