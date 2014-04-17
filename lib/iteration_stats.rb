class IterationStats

  attr_reader :story_count, :feature_points, :other_points, :finish, :feature_count, :other_count

  def initialize(iteration)
    @iteration = iteration
  end

  def finish_date
    finish.strftime('%Y-%m-%d')
  end

  def update!
    @story_count = @iteration.stories.count
    @feature_points = 0
    @other_points = 0
    @feature_count = 0
    @other_count = 0
    @iteration.stories.each { |s| add_story(s) }
    @finish = @iteration.finish
  end

  private

  def add_story(story)
    return unless(story.current_state == 'accepted')
    if(story.story_type == 'feature')
      @feature_points += (story.estimate || 0)
      @feature_points += 1
    else
      @other_points += (story.estimate || 0)
      @other_count += 1
    end
  end
end
