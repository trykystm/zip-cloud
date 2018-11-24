# -*- coding: utf-8 -*-
require './zip_cloud'

RSpec.describe ZipCloud do
  describe 'get' do
    
    subject {ZipCloud.get zipcode: zipcode}
    
    context 'address is not found' do
      let(:zipcode){'5368421'}
      it {is_expected.to match {}}
    end
    
    context 'with argument 7830060' do
      let(:get){{:address1=>"高知県", :address2=>"南国市", :address3=>"蛍が丘", :kana1=>"ｺｳﾁｹﾝ", :kana2=>"ﾅﾝｺｸｼ", :kana3=>"ﾎﾀﾙｶﾞｵｶ", :prefcode=>"39", :zipcode=>"7830060"}}
      let(:zipcode){'7830060'}
      it {is_expected.to match get}
    end
    
    context 'when argument is nothing' do
      let(:get){{:message=>"必須パラメータが指定されていません。"}}
      let(:zipcode){''}
      it {is_expected.to match get}
    end
    
    context 'when argument is illegal' do
      let(:get){{:message=>"パラメータ「郵便番号」に数字以外の文字が指定されています。"}}
      let(:zipcode){'illegal'}
      it {is_expected.to match get}
    end
    
    context 'when zipcode is wrong figure length' do
      let(:get){{:message=>"パラメータ「郵便番号」の桁数が不正です。"}}
      let(:zipcode){'53684'}
      it {is_expected.to match get}
    end
    
  end
end
