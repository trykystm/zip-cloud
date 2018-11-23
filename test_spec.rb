class Test
  def self.get arg
    if arg
      [{a: arg}].first
    else
      false
    end
  end
end

RSpec.describe Test do
  describe '.get' do
    subject do
      test = Test.get arg
    end
    
    context 'that return Array include Hash' do
      let(:arg){'abc'}
      it {is_expected.to eq ({a: 'abc'})}
    end
    
    context 'when arg is nil' do
      let(:arg){nil}
    end
  end
end
    
      
