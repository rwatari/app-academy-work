# == Schema Information
#
# Table name: countries
#
#  name        :string       not null, primary key
#  continent   :string
#  area        :integer
#  population  :integer
#  gdp         :integer

require_relative './sqlzoo.rb'

# BONUS QUESTIONS: These problems require knowledge of aggregate
# functions. Attempt them after completing section 05.

def highest_gdp
  # Which countries have a GDP greater than every country in Europe? (Give the
  # name only. Some countries may have NULL gdp values)
  execute(<<-SQL)
    SELECT
      name
    FROM
      countries
    WHERE
      gdp > (
        SELECT
          MAX(gdp)
        FROM
          countries
        WHERE
          continent = 'Europe'
      )
  SQL
end

def largest_in_continent
  # Find the largest country (by area) in each continent. Show the continent,
  # name, and area.
  execute(<<-SQL)
    SELECT
      countries.continent, countries.name, countries.area
    FROM (
      SELECT
        continent, MAX(area) AS area
      FROM
        countries
      GROUP BY
        continent
    ) AS max_areas
    JOIN
      countries ON (
        max_areas.continent = countries.continent AND
        max_areas.area = countries.area
      )
  SQL
end

def large_neighbors
  # Some countries have populations more than three times that of any of their
  # neighbors (in the same continent). Give the countries and continents.
  execute(<<-SQL)
    SELECT
    FROM (
      SELECT
        continent, MAX(population) AS max_population
      FROM
        countries
      GROUP BY
        continent
    ) AS max_pops
    JOIN
      countries ON (
        max_pops.continent = 
      )
  SQL
end
