require 'spec_helper'

describe CsvProcessor do

  it "returns an array for elements" do
    processor = CsvProcessor.new({'1/1/2013' => { 'project1' => stub(feature_points: 23, other_points: 42) } })
    processor.result.should eq [
      ['Finish Date', 'project1 Feature Points', 'project1 Other points'],
      ['1/1/2013', 23, 42]
    ]
  end

  it "should order by date"

  it "should fill in missing values" do
    processor = CsvProcessor.new(
      '1/1/2013' => {
        'project1' => stub(feature_points: 23, other_points: 42),
        'project2' => stub(feature_points: 17, other_points: 12)
      },
      '2/1/2013' => {
        'project2' => stub(feature_points: 3, other_points: 4)
      }
    )
    processor.result.should eq [
      ['Finish Date', 'project1 Feature Points', 'project1 Other points', 'project2 Feature points', 'project2 Other points'],
      ['1/1/2013', 23, 42, 17, 12],
      ['2/1/2013', 0, 0, 3, 4]
    ]

  end

end
