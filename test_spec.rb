class Test
  def self.get arg
    [{a: arg}].first
  end
end

RSpec.describe Test do
  describe '.get' do
    subject do
      test = Test.get 'abc'
    end
    
    context 'that return Array include Hash' do
      it {is_expected.to eq ({a: 'abc'})}
    end
  end
end
    
      
