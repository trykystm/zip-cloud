# -*- coding: utf-8 -*-
require './zip_cloud'

RSpec.describe ZipCloud do
  describe '#get' do
    
    subject {ZipCloud.get zipcode: zipcode}
    
    context 'address is not found' do
      let(:zipcode){'5368421'}
      res = {}
      it {is_expected.to match res}
    end
    
    context 'with argument 7830060' do
      let(:zipcode){'7830060'}
      res = {:address1=>"高知県", :address2=>"南国市", :address3=>"蛍が丘", :kana1=>"ｺｳﾁｹﾝ", :kana2=>"ﾅﾝｺｸｼ", :kana3=>"ﾎﾀﾙｶﾞｵｶ", :prefcode=>"39", :zipcode=>"7830060"}
      it {is_expected.to match res}
    end
    
    context 'when argument is nothing' do
      let(:zipcode){''}
      res = {:message=>"必須パラメータが指定されていません。"}
      it {is_expected.to match res}
    end
    
    context 'when argument is illegal' do
      let(:zipcode){'illegal'}
      res = {:message=>"パラメータ「郵便番号」に数字以外の文字が指定されています。"}      
      it {is_expected.to match res}
    end
    
    context 'when zipcode is wrong figure length' do
      let(:zipcode){'53684'}
      res = {:message=>"パラメータ「郵便番号」の桁数が不正です。"}
      it {is_expected.to match res}
    end
    
  end
end
