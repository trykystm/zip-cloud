# -*- coding: utf-8 -*-
require 'json'
require 'net/http'
require 'uri'
require 'open-uri'
require 'rspec/its'
#require 'rest-open-uri'

class HTTP01
  def self.test
    uri = URI.parse('http://zipcloud.ibsnet.co.jp/api/search?zipcode=7830060')
    res = Net::HTTP.get(uri)
    JSON.parse(res)
  end
end

class HTTP02
  def self.test
    uri = URI.parse('http://zipcloud.ibsnet.co.jp/api/search')
    req = Net::HTTP::Post.new(uri.path) #writting 'Net::HTTP::Get' brings error
    req.body = 'zipcode=7830060'
    http = Net::HTTP.new(uri.host)
    res = http.request(req)
    JSON.parse(res.body)
  end
end

class HTTP03
  def self.test
    uri = URI.parse('http://zipcloud.ibsnet.co.jp/api/search')
    req = Net::HTTP::Get.new(uri.path)
    req.body = 'zipcode=7830060'
    http = Net::HTTP.new(uri.host)
    res = http.request(req)
  end
end

class HTTP04
  def self.test
    uri = URI.parse('http://zipcloud.ibsnet.co.jp/api/search?zipcode=7830060')
    uri.open do |io|
      JSON.parse(io.read)
    end
  end
end

class HTTP05
  def self.test(zipcode)
    uri = URI.parse("http://zipcloud.ibsnet.co.jp/api/search?zipcode=#{zipcode}")
    uri.open do |io|
      JSON.parse(io.read)
    end
  end
end
    
                                                                                



describe "HTTP" do
  let(:get){{"message"=>nil, "results"=>[{"address1"=>"高知県", "address2"=>"南国市", "address3"=>"蛍が丘", "kana1"=>"ｺｳﾁｹﾝ", "kana2"=>"ﾅﾝｺｸｼ", "kana3"=>"ﾎﾀﾙｶﾞｵｶ", "prefcode"=>"39", "zipcode"=>"7830060"}], "status"=>200}}
  describe "HTTP01" do
    describe ".test" do
      context "with Net::HTTP.get method" do
        subject {HTTP01.test}
        it {is_expected.to eq get}
      end
    end
  end
  
  describe "HTTP02" do
    describe ".test" do
      context "with Net::HTTP::Post request class" do
        subject {HTTP02.test}
        it {is_expected.to eq get}
      end
    end
  end
  
  describe "HTTP03" do
    describe ".test" do
      context "Net::HTTP::Get with body brings error" do
        subject {HTTP03.test}
        it {is_expected.to be_a(Net::HTTPBadRequest)}
      end
    end
  end
  
  describe "HTTP04" do
    describe ".test" do
      context "with Net::HTTP.get method" do
        subject {HTTP04.test}
        it {is_expected.to eq get}
      end
    end
  end
  
  describe "HTTP05" do
    describe ".test" do
      context "with argument 7830060" do
        let(:zipcode){'7830060'}
        subject {HTTP05.test zipcode}
        it {is_expected.to eq get}
      end
    end
  end
end
