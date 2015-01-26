require 'spec_helper'

describe CsvProcessor do

  it "returns an array for elements" do
    processor = CsvProcessor.new({'1/1/2013' => { 'project1' => stub(feature_points: 23, other_points: 42, feature_count: 17, other_count: 2) } })
    processor.result.should eq [
      ['Finish Date', 'project1 feature points', 'project1 Other points', 'project1 feature stories', 'project1 other stories'],
      ['1/1/2013', 23, 42, 17, 2]
    ]
  end

  it "should order by date" do
    processor = CsvProcessor.new(
      '2013-03-01' => {
        'project' => stub(feature_points: 17, other_points: 12, feature_count: 16, other_count: 2)
      },
      '2013-01-02' => {
        'project' => stub(feature_points: 3, other_points: 4, feature_count: 1, other_count: 1)
      }
    )
    processor.result.should eq [
      ['Finish Date', 'project feature points', 'project Other points', 'project feature stories', 'project other stories'],
      ['2013-01-02', 3, 4, 1, 1],
      ['2013-03-01', 17, 12, 16, 2]
    ]

  end

  it "should fill in missing values" do
    processor = CsvProcessor.new(
      '1/1/2013' => {
        'project1' => stub(feature_points: 23, other_points: 42, feature_count: 17, other_count: 3),
        'project2' => stub(feature_points: 17, other_points: 12, feature_count: 23, other_count: 2)
      },
      '2/1/2013' => {
        'project2' => stub(feature_points: 3, other_points: 4, feature_count: 42, other_count: 1)
      }
    )
    processor.result.should eq [
      ['Finish Date', 'project1 feature points', 'project1 Other points', 'project1 feature stories', 'project1 other stories', 'project2 feature points', 'project2 Other points', 'project2 feature stories', 'project2 other stories'],
      ['1/1/2013', 23, 42, 17, 3, 17, 12, 23, 2],
      ['2/1/2013', 0, 0, 0, 0, 3, 4, 42, 1]
    ]
  end

end
