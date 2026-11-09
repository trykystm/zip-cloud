# frozen_string_literal: true

require 'httpclient'
require 'json'

# ZipCloud APIを利用して郵便番号から住所情報を取得するクラス
class ZipCloud
  URL = 'https://zipcloud.ibsnet.co.jp/api/search'

  # 郵便番号を指定して住所情報を取得する
  # @param zipcode [String] 郵便番号（7桁）
  # @param callback [String, nil] JSONPコールバック関数名（任意）
  # @return [Hash] 検索結果またはエラーメッセージを含むハッシュ
  def self.get(zipcode:, callback: nil)
    query = { zipcode: zipcode }
    query[:callback] = callback if callback
    hc = HTTPClient.new
    response = JSON.parse(hc.get(URL, query).body, symbolize_names: true)

    if response[:status] == 200
      results = response[:results]
      results&.first || {}
    else
      { message: response[:message] }
    end
  end
end

if $PROGRAM_NAME == __FILE__
  p ZipCloud.get zipcode: '7830060'
  p ZipCloud.get zipcode: ''
  p ZipCloud.get zipcode: 'illigal'
  p ZipCloud.get zipcode: '8659512'
  p ZipCloud.get zipcode: '7457'
end
