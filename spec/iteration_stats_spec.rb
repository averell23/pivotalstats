require 'spec_helper'

describe IterationStats do

  it "adds the stories and save the story count" do
    iteration = stub(:iteration, stories: [:a_story], finish: :end_time)
    stats = IterationStats.new(iteration)
    stats.should_receive(:add_story).with(:a_story)
    stats.update!
    stats.story_count.should eq 1
    stats.finish.should eq :end_time
  end

  context "#add_story" do

    let(:stats) { IterationStats.new(stub(stories: [], finish: Time.new(2013,4,4))) }

    before(:each) { stats.update! }

    it "returns the formatted finish date" do
      stats.finish_date.should eq '04/04/2013'
    end

    it "ignores non-accepted stories" do
      story = stub(:story, current_state: "finished")
      stats.__send__(:add_story, story)
      stats.feature_points.should eq 0
    end

    it "adds feature points for feature stories" do
      story = stub(:story, current_state: "accepted", story_type: "feature", estimate: 23)
      stats.__send__(:add_story, story)
      stats.feature_points.should eq 23
    end

    it "add other points for non-feature stories" do
      story = stub(:story, current_state: "accepted", story_type: "chore", estimate: 23)
      stats.__send__(:add_story, story)
      stats.other_points.should eq 23
    end

  end

end
