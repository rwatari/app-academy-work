require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    @columns ||= DBConnection.execute2(<<-SQL).first.map(&:to_sym)
      SELECT *
      FROM #{self.table_name}
    SQL

    @columns
  end

  def self.finalize!
    self.columns.each do |column|
      define_method(column) do
        attributes[column]
      end

      define_method("#{column}=") do |val|
        attributes[column] = val
      end
    end
  end

  def self.table_name=(table_name)
    @table_name = table_name
  end

  def self.table_name
    @table_name ||= self.name.tableize
  end

  def self.all
    objects = DBConnection.execute(<<-SQL)
      SELECT #{self.table_name}.*
      FROM #{self.table_name}
    SQL

    self.parse_all(objects)
  end

  def self.parse_all(results)
    results.map { |params| self.new(params) }
  end

  def self.find(id)
    objects = DBConnection.execute(<<-SQL, id)
      SELECT #{self.table_name}.*
      FROM #{self.table_name}
      WHERE id = ?
    SQL

    self.parse_all(objects).first
  end

  def initialize(params = {})
    params.each do |attr_name, val|
      unless self.class.columns.include?(attr_name.to_sym)
        raise "unknown attribute '#{attr_name}'"
      end

      self.send("#{attr_name}=", val)
    end
  end

  def attributes
    @attributes ||= {}
  end

  def attribute_values
    no_id_columns.map { |column| self.send(column) }
  end

  def insert
    col_names = no_id_columns.join(', ')
    question_marks = (["?"] * no_id_columns.size).join(', ')

    DBConnection.execute(<<-SQL, *attribute_values)
      INSERT INTO #{self.class.table_name} (#{col_names})
      VALUES (#{question_marks})
    SQL

    self.id = DBConnection.last_insert_row_id
  end

  def update
    set_str = no_id_columns.map { |attr_name| "#{attr_name} = ?" }.join(', ')

    DBConnection.execute(<<-SQL, *attribute_values, id)
      UPDATE #{self.class.table_name}
      SET #{set_str}
      WHERE id = ?
    SQL
  end

  def save
    if id.nil?
      insert
    else
      update
    end
  end

  private

  def no_id_columns
    self.class.columns.drop(1)
  end
end
