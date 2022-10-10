# frozen_string_literal: true

require 'outwood_labels/options'
require 'outwood_labels/file_namer'
require 'outwood_labels/csv_loader'
require 'csv'

module OutwoodLabels
  class CLI
    STATUS_SUCCESS = 0
    STATUS_ERROR = 1

    def initialize
      @options = {}
    end

    # @return [Integer] status
    def run(args = ARGV, input = ARGF)
      @options = Options.call(args)

      option_actions || write_csv(input)

      STATUS_SUCCESS
    rescue OutwoodLabels::Error,
           OutwoodLabels::OptionArgumentError,
           OptionParser::InvalidOption,
           OptionParser::MissingArgument => e
      warn e.message
      STATUS_ERROR
    end

    private

    def write_csv(input)
      output = @options[:output_path] || FileNamer.call("labels")
      template = OutwoodLabels[@options[:style]]

      data = CsvLoader.call(input.to_io, template, @options.fetch(:headers, true))
      template ||= detect_template(data)
      Generate.call(data, output, template, @options)
    end

    def detect_template(data)
      template = OutwoodLabels.infer_template(data.headers)
      raise Error, "No template found" unless template

      warn "Inferred template: #{template.name}"
      template
    end

    def option_actions
      return false if (Options::EXIT_ACTIONS & @options.keys).empty?

      list_styles if @options[:list]
      puts OutwoodLabels::VERSION.to_s if @options[:version]
      true
    end

    def list_styles
      OutwoodLabels.default_mapping.reverse_each do |k, v|
        puts "#{k}:"
        puts v.columns.join(',').prepend('  ')
      end
    end
  end
end
