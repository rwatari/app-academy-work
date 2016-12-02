require_relative '03_associatable'

# Phase IV
module Associatable
  # Remember to go back to 04_associatable to write ::assoc_options

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
