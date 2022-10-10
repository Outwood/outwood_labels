# frozen_string_literal: true

module OutwoodLabels
  class OptionsValidator
    include Callable

    # @param opts [{Symbol => Object}]
    def initialize(opts)
      @options = opts
    end

    # @raise [OptionArgumentError] on errors
    # @return [Boolean]
    def call
      validate_compatibility
      validate_values
      true
    end

    private

    def validate_values
      return true unless @options.key?(:style) && !OutwoodLabels[@options[:style]]

      raise OptionArgumentError, 'Unknown style'
    end

    def validate_compatibility
      if !@options.fetch(:headers, true) && !@options[:style]
        raise OptionArgumentError, 'Style must be specified'
      end

      return true if exclusive_options.size <= 1

      raise OptionArgumentError, 'Incompatible options: ' \
                                 "#{exclusive_options.join(', ')}"
    end

    def exclusive_options
      @exclusive_options ||= @options.keys & Options::EXIT_ACTIONS
    end
  end
end
