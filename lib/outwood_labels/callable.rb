# frozen_string_literal: true

module OutwoodLabels
  # Callable mixin
  module Callable
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def call(...)
        new(...).call
      end
    end
  end
end
