require 'spec_helper.rb'

$count = 0

describe "let" do
  let(:count) { $count += 1 }

  it 'memoizes the value' do
    count.should be(1)
    count.should be(1)
  end

  it 'is not cached across examples' do
    count.should be(2)
  end

  it 'is now should be 3' do
    count.should be(3)
  end
end
