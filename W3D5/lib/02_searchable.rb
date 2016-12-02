require_relative 'db_connection'
require_relative '01_sql_object'

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

class SQLObject
  extend Searchable
end
