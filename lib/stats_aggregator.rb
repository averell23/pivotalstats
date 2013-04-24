class StatsAggregator

  def initialize(number_of_iterations = 1)
    @number_of_iterations = number_of_iterations
  end


  def add_project(project)
    get_iterations(project).each do |iteration|
      add_iteration(project.name, iteration)
    end
  end

  def iterations
    @iterations ||= {}
  end

  private

  def get_iterations(project)
    PivotalTracker::Iteration.done(project, offset: -@number_of_iterations) rescue []
  end

  def add_iteration_stats(project_name, iteration_stat)
    iteration_stat.update!
    iterations[iteration_stat.finish_date] ||= {}
    iterations[iteration_stat.finish_date][project_name] = iteration_stat
  end

  def add_iteration(project_name, iteration)
    add_iteration_stats project_name, IterationStats.new(iteration)
  end

end
