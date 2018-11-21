require 'httpclient'
require 'json'

class ZipCloud
  
  URL = "http://zipcloud.ibsnet.co.jp/api/search"
  
  def self.get(zipcode: , callback: nil)
    query = {zipcode: zipcode}
    query[:callback] = callback if callback
    hc = HTTPClient.new
    response = hc.get(URL, query).body
    JSON.parse(response, symbolize_names: true)[:results].first
  end
  
end

if $0 == __FILE__
  ZipCloud.get zipcode:'6638186'
end
