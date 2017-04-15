require_relative 'db_connection'
require_relative '01_sql_object'

module Searchable
  def where(params)
    insert_this = params.keys.map { |key| "#{key} = ?" }.join(" AND ")
    matches = DBConnection.execute(<<-SQL, *params.values)
      SELECT
        *
      FROM
        #{table_name}
      WHERE
        #{insert_this}
    SQL
    parse_all(matches)
  end
end

class SQLObject
  extend Searchable
end
