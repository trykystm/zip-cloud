# -*- coding: utf-8 -*-
require 'rspec'
require './zip_cloud'

describe 'ZipCloud' do
  describe 'get' do
    
    subject {ZipCloud.get zipcode: zipcode}

    context 'with argument 7830060' do
      let(:get){{:message=>nil, :results=>[{:address1=>"高知県", :address2=>"南国市", :address3=>"蛍が丘", :kana1=>"ｺｳﾁｹﾝ", :kana2=>"ﾅﾝｺｸｼ", :kana3=>"ﾎﾀﾙｶﾞｵｶ", :prefcode=>"39", :zipcode=>"7830060"}], :status=>200}}
      let(:zipcode){'7830060'}
      it {is_expected.to eq get}
    end
    
    context 'address is not found' do
      xit {is_expected.to be_nil}
    end
    
    context 'when argument is nothing' do
      xit {is_expected.to be false}
    end
    
    context 'when argument is illegal' do
      xit {is_expected.to be false}
    end
    
    context 'when zipcode is wrong figure length' do
      xit {is_expected.to be false}
    end
    
  end
end
