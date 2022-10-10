# frozen_string_literal: true

require 'optparse'
require 'outwood_labels/options_validator'

module OutwoodLabels
  class OptionArgumentError < StandardError; end

  class Options
    include Callable

    EXIT_ACTIONS = %i[version list].freeze

    # @param cli_args [<String>]
    def initialize(cli_args)
      @args = cli_args
      @options = {}
    end

    # @return [{String => Object}]
    def call
      define_options.parse!(@args)
      OptionsValidator.call(@options)

      @options
    end

    private

    def define_options
      OptionParser.new do |opts|
        opts.banner = "Usage: #{$PROGRAM_NAME} [OPTIONS]"
        opts.separator ''
        opts.separator 'OPTIONS'

        opts.on('-o', '--out FILE', 'Output file') do |opt|
          @options[:output_path] = opt
        end

        opts.on('--[no-]headers', 'Expect a header row') do |opt|
          @options[:headers] = opt
        end

        opts.on('-b', '--break BREAK', 'Break column') do |opt|
          @options[:break_on] = opt
        end

        opts.on('-s', '--style NAME', 'Label template') do |opt|
          @options[:style] = opt
        end

        opts.on('-d', '--debug') do |opt|
          @options[:debug] = opt
        end

        opts.on('--list', 'List templates') do |opt|
          @options[:list] = opt
        end

        opts.on('--version') do |opt|
          @options[:version] = opt
        end
      end
    end
  end
end
