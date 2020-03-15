# frozen_string_literal: true

module Mixins
  module StrFormatter
    def url_ready(str)
      str.split(',')
         .map(&:strip)
         .join(',')
         .split(' ')
         .join('+')
    end
  end
end
