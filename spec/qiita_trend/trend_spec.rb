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

    it 'TrendのデータがArrayであること' do
      expect(trend.data).to be_a Array
    end
    it 'DataにisNewArrival,nodeのキーが存在すること' do
      expect(first_element).to include('isNewArrival', 'node')
    end
  end

  describe '#items' do
    subject(:first_items) { trend.items[0] }

    it { is_expected.to include('title', 'user_name', 'user_image', 'likes_count', 'is_new_arrival', 'article') }
  end

  describe '#new_items' do
    let(:new_items) { trend.new_items }

    it '全ての値でisNewArrivalがtrueであること' do
      expect(new_items).to all(include('is_new_arrival' => true))
    end
  end
end
