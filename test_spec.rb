class Test
  def self.get
    [{a: 'a'}].first
  end
end

RSpec.describe Test do
  describe '.get' do
    subject do
      test = Test.get
    end
    
    context 'that return Array include Hash' do
      it {is_expected.to eq ({a: 'a'})}
    end
  end
end
    
      
