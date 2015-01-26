require 'date'
require 'csv'

class CsvProcessor

  def initialize(hash)
    @data = hash
  end

  def result
    result = []
    result << columns
    iterations.each do |iteration|
      result << add_iteration(iteration)
    end
    result
  end

  def csv
    CSV.generate do |csv|
      result.each { |line| csv << line }
    end
  end

  private

  def add_iteration(iteration)
    row = [ iteration ]
    projects.each do |project|
      row << (@data[iteration][project].full?(:feature_points)  || 0)
      row << (@data[iteration][project].full?(:other_points) || 0)
      row << (@data[iteration][project].full?(:feature_count) || 0)
      row << (@data[iteration][project].full?(:other_count) || 0)
    end
    row
  end

  def iterations
    @data.keys.sort
  end

  def columns
    columns = [ 'Finish Date' ]
    projects.each { |p| columns += [ "#{p} feature points", "#{p} Other points", "#{p} feature stories", "#{p} other stories" ] }
    columns
  end

  def projects
    @projects ||= begin
      projects = {}
      @data.each_value do |project_data|
        project_data.each_key { |project_name| projects[project_name] = true }
      end
      projects.keys.sort
    end
  end
end
