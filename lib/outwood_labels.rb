# frozen_string_literal: true

require 'logger'
require 'outwood_labels/callable'
require 'outwood_labels/generate'
require 'outwood_labels/template'
require 'outwood_labels/version'

module OutwoodLabels
  class Error < StandardError; end

  @templates = {}

  # @param klass [Class] template class to add
  def self.register(klass)
    default_mapping[klass.name] = klass
  end

  # @param name [String] name of a template
  def self.[](name)
    default_mapping[name]
  end

  # @param columns [Array<String>] list of column names
  # @return [Template::Base, nil]
  def self.infer_template(columns = [])
    default_mapping.each_value.reverse_each do |t|
      return t if t.valid_for? columns
    end
    nil
  end

  # @return [{String => Template::Base}]
  def self.default_mapping
    @templates
  end

  # Register in ascending preference order
  register(Template::EmailPasswordInitial)
  register(Template::EmailPassword)
end
