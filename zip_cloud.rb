require 'httpclient'
require 'json'

class ZipCloud
  
  URL = "http://zipcloud.ibsnet.co.jp/api/search/"
  
  def self.get(zipcode: , callback: nil)
    query = {zipcode: zipcode, callback: callback}
    hc = HTTPClient.new
    JSON.perse(hc.get(URL, query).body)
  end
  
end
