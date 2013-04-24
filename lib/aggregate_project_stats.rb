class AggregateProjectStats

  attr_reader :project_stats

  def initialize(projects)
    @projects = projects
  end

  def update!
    @project_stats = {}
    @projects.each do |p|
      pstats = ProjectStats.new(p)
      pstats.update!
      pstats.iterations.each do |finish, stats|
        finish = finish.strftime('%m/%d/%Y')
        @project_stats[finish] ||= {}
        @project_stats[finish][p.name] = stats
      end
    end
  end

end
