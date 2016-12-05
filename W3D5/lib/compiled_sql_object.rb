require_relative 'db_connection'
require 'active_support/inflector'

module Searchable
  def where(params)
    attr_names = params.keys
    values = attr_names.map { |attr_name| params[attr_name] }
    where_line = attr_names.map { |attr_name| "#{attr_name} = ?" }.join(" AND ")

    results = DBConnection.execute(<<-SQL, *values)
      SELECT *
      FROM #{self.table_name}
      WHERE #{where_line}
    SQL

    self.parse_all(results)
  end
end

class AssocOptions
  attr_accessor(
    :foreign_key,
    :class_name,
    :primary_key
  )

  def model_class
    @class_name.constantize
  end

  def table_name
    model_class.table_name
  end
end

class BelongsToOptions < AssocOptions
  def initialize(name, options = {})
    @primary_key = options[:primary_key] || :id
    @foreign_key = options[:foreign_key] || "#{name}_id".to_sym
    @class_name = options[:class_name] || name.to_s.camelcase
  end
end

class HasManyOptions < AssocOptions
  def initialize(name, self_class_name, options = {})
    @primary_key = options[:primary_key] || :id
    @foreign_key =
      options[:foreign_key] || "#{self_class_name.underscore}_id".to_sym
    @class_name =
      options[:class_name] || name.to_s.singularize.camelcase
  end
end

module Associatable
  def assoc_options
    @assoc_options ||= {}
  end

  def belongs_to(name, options = {})
    assoc_options[name] = BelongsToOptions.new(name, options)

    define_method(name) do
      options = self.class.assoc_options[name]

      foreign_id = self.send(options.foreign_key)
      target_class = options.model_class

      results = target_class.where(options.primary_key => foreign_id)
      results.first
    end
  end

  def has_many(name, options = {})
    assoc_options[name] = HasManyOptions.new(name, self.name, options)

    define_method(name) do
      options = self.class.assoc_options[name]

      primary_id = self.send(options.primary_key)
      target_class = options.model_class
      target_class.where(options.foreign_key => primary_id)
    end
  end

  def has_one_through(name, through_name, source_name)
    define_method(name) do
      through_options = self.class.assoc_options[through_name]
      source_options = through_options.model_class.assoc_options[source_name]

      through_table = through_options.table_name
      through_pkey = through_options.primary_key
      through_fkey = through_options.foreign_key

      source_table = source_options.table_name
      source_pkey = source_options.primary_key
      source_fkey = source_options.foreign_key

      results = DBConnection.execute(<<-SQL, self.send(through_fkey))
        SELECT #{source_table}.*
        FROM #{through_table}
        JOIN #{source_table}
          ON #{source_table}.#{source_pkey} = #{through_table}.#{source_fkey}
        WHERE #{through_table}.#{through_pkey} = ?
      SQL

      source_options.model_class.parse_all(results).first
    end
  end
end

class SQLObject
  extend Searchable
  extend Associatable

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
