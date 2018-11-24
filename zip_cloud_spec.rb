# -*- coding: utf-8 -*-
require './zip_cloud'

RSpec.describe ZipCloud do
  describe 'get' do
    
    subject {ZipCloud.get zipcode: zipcode}
    
    context 'address is not found' do
      let(:zipcode){'5368421'}
      it {is_expected.to be_nil}
    end
    
    context 'with argument 7830060' do
      let(:get){{:address1=>"高知県", :address2=>"南国市", :address3=>"蛍が丘", :kana1=>"ｺｳﾁｹﾝ", :kana2=>"ﾅﾝｺｸｼ", :kana3=>"ﾎﾀﾙｶﾞｵｶ", :prefcode=>"39", :zipcode=>"7830060"}}
      let(:zipcode){'7830060'}
      it {is_expected.to eq get}
    end
    
    context 'when argument is nothing' do
      let(:zipcode){''}
      it {is_expected.to eq {massage: "必須パラメータが指定されていません。"}}
    end
    
    context 'when argument is illegal' do
      let(:zipcode){'illegal'}
      it {is_expected.to be false}
    end
    
    context 'when zipcode is wrong figure length' do
      let(:zipcode){'53684'}
      it {is_expected.to be false}
    end
    
  end
end
