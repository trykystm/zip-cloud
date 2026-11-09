# frozen_string_literal: true

require 'httpclient'
require 'json'

# ZipCloud APIクライアント
class ZipCloud
  URL = 'https://zipcloud.ibsnet.co.jp/api/search'

  # 郵便番号から住所情報を取得する
  #
  # @param zipcode [String] 郵便番号（ハイフンなし7桁）
  # @param callback [String, nil] JSONPコールバック関数名
  # @return [Hash] 検索結果またはエラーメッセージ
  def self.get(zipcode:, callback: nil)
    query = {
      zipcode: zipcode,
      callback: callback
    }.compact

    hc = HTTPClient.new
    response = JSON.parse(hc.get(URL, query).body, symbolize_names: true)

    return { message: response[:message] } unless response[:status] == 200

    response[:results]&.first || {}
  rescue StandardError => e
    { message: "通信エラーが発生しました: #{e.message}" }
  end
end

if $PROGRAM_NAME == __FILE__
  p ZipCloud.get(zipcode: '7830060')
  p ZipCloud.get(zipcode: '')
  p ZipCloud.get(zipcode: 'illegal')
  p ZipCloud.get(zipcode: '8659512')
  p ZipCloud.get(zipcode: '7457')
end
