class ProjectStats

  attr_reader :iterations

  def initialize(project)
    @project = project
  end

  def update!
    @iterations = {}
    PivotalTracker::Iteration.done(@project, offset: -10).each { |i| add_iteration i }
  end

  private

  def add_iteration(iteration)
    stats = IterationStats.new(iteration)
    stats.update!
    @iterations[stats.finish] = stats
  end
end
