require_relative '02_searchable'
require 'active_support/inflector'

# Phase IIIa
class AssocOptions
  attr_accessor(
    :foreign_key,
    :class_name,
    :primary_key
  )

  def model_class
    @class_name.to_s.constantize
  end

  def table_name
    model_class.table_name
  end
end

class BelongsToOptions < AssocOptions
  def initialize(name, options = {})
    default = {
      foreign_key: "#{name}_id".to_sym,
      class_name: name.to_s.camelcase,
      primary_key: :id
    }

    default.keys.each do |key|
      self.send("#{key}=", options[key] || default[key])
    end
  end
end

class HasManyOptions < AssocOptions
  def initialize(name, self_class_name, options = {})
    default = {
      foreign_key: "#{self_class_name.downcase}_id".to_sym,
      class_name: name.singularize.to_s.camelcase,
      primary_key: :id
    }

    default.keys.each do |key|
      self.send("#{key}=", options[key] || default[key])
    end
  end
end

module Associatable
  # Phase IIIb
  def belongs_to(name, options = {})
    options =
    define_method(name.to_s) do
      send(@foreign_key)
      model_class
    end
  end

  def has_many(name, options = {})
    # ...
  end

  def assoc_options
    # Wait to implement this in Phase IVa. Modify `belongs_to`, too.
  end
end

class SQLObject
  extend Associatable
end
