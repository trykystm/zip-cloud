require 'json'
require 'net/http'
require 'uri'

class HTTP
  def self.test
    uri = URI.parse('http://zipcloud.ibsnet.co.jp/api/search?zipcode=7830060')
    JSON.parse(Net::HTTP.get(uri))
  end
end




describe "HTTP" do
  describe ".test" do
    http = HTTP.test
    puts http
    subject {http["status"]}
    it {is_expected.to eq 200}
  end
end
