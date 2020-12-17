# frozen_string_literal: true

RSpec.describe QiitaTrend::Trend do
  include CacheHelper

  let(:trend) do
    VCR.use_cassette 'trend' do
      create_cache_mock(false, QiitaTrend::Target.new)
      described_class.new
    end
  end

  describe '#initialize' do
    let(:first_element) { trend.data[0] }
    let(:node_keys) { %w[author title uuid createdAt likesCount] }
    let(:author_keys) { %w[urlName profileImageUrl] }

    it 'TrendのデータがArrayであること' do
      expect(trend.data).to be_a Array
    end

    it 'DataにisNewArrival,nodeのキーが存在すること' do
      expect(first_element).to include('isNewArrival', 'node')
    end

    it 'nodeの配下にスクレイピング対象のキーが存在すること' do
      node_keys.each { |key| expect(first_element['node'].keys).to include(key) }
    end

    it 'authorの配下にスクレイピング対象のキーが存在すること' do
      author_keys.each { |key| expect(first_element['node']['author'].keys).to include(key) }
    end
  end

  describe '#items' do
    subject(:first_items) { trend.items[0] }

    let(:item_keys) { first_items.keys }

    it { is_expected.to include('title', 'user_name', 'user_image', 'likes_count', 'is_new_arrival', 'article', 'created_at', 'user_page') }

    it 'すべての値が取得できていること' do
      item_keys.each { |key| expect(first_items[key]).not_to eq nil }
    end
  end

  describe '#new_items' do
    let(:new_items) { trend.new_items }

    it '全ての値でisNewArrivalがtrueであること' do
      expect(new_items).to all(include('is_new_arrival' => true))
    end
  end
end
