require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    return @columns if @columns
    cols = DBConnection.execute2(<<-SQL)
      SELECT
        *
      FROM
        #{table_name}
    SQL
    cols = cols.first.map!(&:to_sym)
    @columns = cols
  end

  def self.finalize!
    self.columns.each do |column|
      define_method(column) { self.attributes[column] }

      define_method("#{column}=") { |val| self.attributes[column] = val }
    end
  end

  def self.table_name=(table_name)
    @table_name = table_name
  end

  def self.table_name
    @table_name || self.name.tableize
  end

  def self.all
    deets = DBConnection.execute(<<-SQL)
      SELECT
        *
      FROM
        #{table_name}
    SQL
    parse_all(deets)
  end

  def self.parse_all(results)
    objs = []
    results.map do |deets|
      objs << self.new(deets)
    end
    objs
  end

  def self.find(id)
    match = DBConnection.execute(<<-SQL, id)
    SELECT
      *
    FROM
      #{table_name}
    WHERE
      id == ?
    SQL
    return nil if match.empty?
    parse_all(match).first
  end

  def initialize(params = {})
    params.each do |attr_name, val|
      col = attr_name.to_sym
      if self.class.columns.include?(col)
        self.send("#{col}=", val)
      else
        raise "unknown attribute '#{col}'"
      end
    end
  end

  def attributes
    @attributes || @attributes = {}
  end

  def attribute_values
    self.class.columns.map { |attr| self.send(attr) }
  end

  def insert
    columns = self.class.columns.drop(1)
    col_names = columns.map(&:to_s).join(", ")
    question_marks = (["?"] * columns.count).join(", ")

    DBConnection.execute(<<-SQL, attribute_values.drop(1))
      INSERT INTO
        #{self.class.table_name} (#{col_names})
      VALUES
        (#{question_marks})
    SQL

    self.id = DBConnection.last_insert_row_id
  end

  def update
    attr_set = self.class.columns.map { |attr| "#{attr} = ?" }.join(", ")
    DBConnection.execute(<<-SQL, attribute_values, id)
      UPDATE
        #{self.class.table_name}
      SET
        #{attr_set}
      WHERE
        #{self.class.table_name}.id = ?
    SQL
  end

  def save
    if self.id.nil?
      self.insert
    else
      self.update
    end
  end
end
