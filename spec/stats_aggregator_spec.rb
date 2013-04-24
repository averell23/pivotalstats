require 'spec_helper'

describe StatsAggregator do

  let(:aggregator) { StatsAggregator.new }

  context "adding stats from one project" do

    it "adds gets all iterations for aggregating" do
      project = stub(:project, name: 'projectname')
      aggregator.should_receive(:get_iterations).with(project).and_return([:an_iteration])
      aggregator.should_receive(:add_iteration).with('projectname', :an_iteration)
      aggregator.add_project(project)
    end

    it "adds the stats for one iteration" do
      iteration = stub(:iteration)
      IterationStats.should_receive(:new).with(iteration).and_return(:iteration_stat)
      aggregator.should_receive(:add_iteration_stats).with('some_project', :iteration_stat)
      aggregator.__send__(:add_iteration, 'some_project', iteration)
    end

    it "adds the data for one stat" do
      iteration_stats = stub(:iteration_stat, finish_date: 'abc' )
      iteration_stats.should_receive(:update!)
      aggregator.__send__(:add_iteration_stats, 'some_project', iteration_stats)
      aggregator.iterations.should eq('abc' => { 'some_project' => iteration_stats})
    end
  end

end
