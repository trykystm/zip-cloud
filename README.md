# ZipCloud

[zipcloud API](https://zipcloud.ibsnet.co.jp/doc/api) を利用して郵便番号から住所情報を取得するシンプルな Ruby クライアントです。

## 特徴

- **HTTPS通信**: 暗号化されたセキュアな通信（SSL/TLS）に対応
- **Ruby 4.0 完全対応**: 最新のRuby 4.0環境およびBundlerに対応
- **堅牢なエラーハンドリング**: ネットワーク障害やタイムアウト時も安全にエラーメッセージを返却
- **高速なテストスイート**: WebMockによる外部通信スタブ化により、約0.2秒でテストが完了

## 必要要件

- Ruby 4.0 以上
- Bundler

## インストール・環境構築

```bash
git clone https://github.com/trykystm/zip-cloud.git
cd zip-cloud
bundle install
```

## 使い方

```ruby
require_relative 'zip_cloud'

# 正常系: 郵便番号から住所情報を取得
result = ZipCloud.get(zipcode: '7830060')
# => {
#      :address1 => "高知県",
#      :address2 => "南国市",
#      :address3 => "蛍が丘",
#      :kana1 => "ｺｳﾁｹﾝ",
#      :kana2 => "ﾅﾝｺｸｼ",
#      :kana3 => "ﾎﾀﾙｶﾞｵｶ",
#      :prefcode => "39",
#      :zipcode => "7830060"
#    }

# 該当する住所が存在しない場合
ZipCloud.get(zipcode: '5368421')
# => {}

# 不正なパラメータの場合
ZipCloud.get(zipcode: 'illegal')
# => { :message => "パラメータ「郵便番号」に数字以外の文字が指定されています。" }
```

## テスト・静的解析の実行

### テスト (RSpec)

WebMockにより外部APIへの通信はすべてモック化されており、オフラインでもミリ秒単位で高速に実行できます。

```bash
bundle exec rspec
```

### 静的解析 (RuboCop)

```bash
bundle exec rubocop
```
