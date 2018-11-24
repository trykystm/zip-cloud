require 'httpclient'
require 'json'

class ZipCloud
  
  URL = "http://zipcloud.ibsnet.co.jp/api/search"
  
  def self.get(zipcode: , callback: nil)
    query = {zipcode: zipcode}
    query[:callback] = callback if callback
    hc = HTTPClient.new
    response = JSON.parse(hc.get(URL, query).body, symbolize_names: true)
    if response[:status] == 200
      results = response[:results]
      results ? results.first : {}
    else
      {message: response[:message]}
    end
  end
  
end

if $0 == __FILE__
  p ZipCloud.get zipcode:'7830060'
  p ZipCloud.get zipcode:''
  p ZipCloud.get zipcode:'illigal'
  p ZipCloud.get zipcode:'8659512'
  p ZipCloud.get zipcode:'7457'
end
