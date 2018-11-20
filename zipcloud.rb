require 'httpclient'
require 'json'

class Zipcloud
  URL = "http://zipcloud.ibsnet.co.jp/api/search"
  def self.get(zipcode: zipcode, callback: callback)
    hc = HTTPClient.new
    hc.get_content(URL, zipcode)
  end
end