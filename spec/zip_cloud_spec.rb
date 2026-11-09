# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ZipCloud do
  describe '.get' do
    subject { described_class.get(zipcode: zipcode) }

    let(:api_url) { 'https://zipcloud.ibsnet.co.jp/api/search' }

    context 'when address is not found' do
      let(:zipcode) { '5368421' }
      let(:expected_result) { {} }

      before do
        stub_request(:get, api_url)
          .with(query: { zipcode: zipcode })
          .to_return(
            status: 200,
            body: { message: nil, results: nil, status: 200 }.to_json
          )
      end

      it { is_expected.to match expected_result }
    end

    context 'with valid zipcode 7830060' do
      let(:zipcode) { '7830060' }
      let(:expected_result) do
        {
          address1: '高知県',
          address2: '南国市',
          address3: '蛍が丘',
          kana1: 'ｺｳﾁｹﾝ',
          kana2: 'ﾅﾝｺｸｼ',
          kana3: 'ﾎﾀﾙｶﾞｵｶ',
          prefcode: '39',
          zipcode: '7830060'
        }
      end

      before do
        stub_request(:get, api_url)
          .with(query: { zipcode: zipcode })
          .to_return(
            status: 200,
            body: {
              message: nil,
              results: [expected_result],
              status: 200
            }.to_json
          )
      end

      it { is_expected.to match expected_result }
    end

    context 'when argument is empty' do
      let(:zipcode) { '' }
      let(:expected_result) { { message: '必須パラメータが指定されていません。' } }

      before do
        stub_request(:get, api_url)
          .with(query: { zipcode: zipcode })
          .to_return(
            status: 200,
            body: {
              message: '必須パラメータが指定されていません。',
              results: nil,
              status: 400
            }.to_json
          )
      end

      it { is_expected.to match expected_result }
    end

    context 'when argument contains non-numeric characters' do
      let(:zipcode) { 'illegal' }
      let(:expected_result) { { message: 'パラメータ「郵便番号」に数字以外の文字が指定されています。' } }

      before do
        stub_request(:get, api_url)
          .with(query: { zipcode: zipcode })
          .to_return(
            status: 200,
            body: {
              message: 'パラメータ「郵便番号」に数字以外の文字が指定されています。',
              results: nil,
              status: 400
            }.to_json
          )
      end

      it { is_expected.to match expected_result }
    end

    context 'when zipcode has invalid length' do
      let(:zipcode) { '53684' }
      let(:expected_result) { { message: 'パラメータ「郵便番号」の桁数が不正です。' } }

      before do
        stub_request(:get, api_url)
          .with(query: { zipcode: zipcode })
          .to_return(
            status: 200,
            body: {
              message: 'パラメータ「郵便番号」の桁数が不正です。',
              results: nil,
              status: 400
            }.to_json
          )
      end

      it { is_expected.to match expected_result }
    end

    context 'when network timeout occurs' do
      let(:zipcode) { '7830060' }

      before do
        stub_request(:get, api_url)
          .with(query: { zipcode: zipcode })
          .to_timeout
      end

      it 'returns error message hash' do
        expect(subject[:message]).to include('通信エラーが発生しました')
      end
    end
  end
end
