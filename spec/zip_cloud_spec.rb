# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ZipCloud do
  describe '.get' do
    subject { described_class.get(zipcode: zipcode) }

    context 'when address is not found' do
      let(:zipcode) { '5368421' }
      let(:expected_result) { {} }

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

      it { is_expected.to match expected_result }
    end

    context 'when argument is empty' do
      let(:zipcode) { '' }
      let(:expected_result) { { message: '必須パラメータが指定されていません。' } }

      it { is_expected.to match expected_result }
    end

    context 'when argument contains non-numeric characters' do
      let(:zipcode) { 'illegal' }
      let(:expected_result) { { message: 'パラメータ「郵便番号」に数字以外の文字が指定されています。' } }

      it { is_expected.to match expected_result }
    end

    context 'when zipcode has invalid length' do
      let(:zipcode) { '53684' }
      let(:expected_result) { { message: 'パラメータ「郵便番号」の桁数が不正です。' } }

      it { is_expected.to match expected_result }
    end
  end
end
