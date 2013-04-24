class IterationStats

  attr_reader :story_count, :feature_points, :other_points, :finish

  def initialize(iteration)
    @iteration = iteration
  end

  def finish_date
    finish.strftime('%m/%d/%Y')
  end

  def update!
    @story_count = @iteration.stories.count
    @feature_points = 0
    @other_points = 0
    @iteration.stories.each { |s| add_story(s) }
    @finish = @iteration.finish
  end

  private

  def add_story(story)
    return unless(story.current_state == 'accepted')
    if(story.story_type == 'feature')
      @feature_points += (story.estimate || 0)
    else
      @other_points += (story.estimate || 0)
    end
  end
end
