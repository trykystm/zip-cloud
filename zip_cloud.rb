require 'httpclient'
require 'json'

class ZipCloud
  
  URL = "http://zipcloud.ibsnet.co.jp/api/search"
  
  def self.get(zipcode: , callback: nil)
    query = {zipcode: zipcode}
    query[:callback] = callback if callback
    hc = HTTPClient.new
    rtn = JSON.parse(hc.get(URL, query).body, symbolize_names: true)
    rtn[:results].first
  end
  
end

if $0 == __FILE__
  ZipCloud.get zipcode: '6638186'
end
