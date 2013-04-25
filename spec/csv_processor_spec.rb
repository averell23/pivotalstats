require 'spec_helper'

describe CsvProcessor do

  it "returns an array for elements" do
    processor = CsvProcessor.new({'1/1/2013' => { 'project1' => stub(feature_points: 23, other_points: 42) } })
    processor.result.should eq [
      ['Finish Date', 'project1 Feature Points', 'project1 Other points'],
      ['1/1/2013', 23, 42]
    ]
  end

end
