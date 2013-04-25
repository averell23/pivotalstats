class CsvProcessor

  def initialize(hash)
    @data = hash
  end

  def result
    result = []
    result << columns
    @data.each do |date, project_data|
      row = [ date ]
      projects.each do |project|
        row << project_data[project].feature_points
        row << project_data[project].other_points
      end
      result << row
    end
    result
  end

  private

  def columns
    columns = [ 'Finish Date' ]
    projects.each { |p| columns += [ "#{p} Feature Points", "#{p} Other points" ] }
    columns
  end

  def projects
    projects = {}
    @data.each_value do |project_data|
      project_data.each_key { |project_name| projects[project_name] = true }
    end
    projects.keys
  end
end
