# frozen_string_literal: true

RSpec.describe QiitaTrend::Trend do
  include CacheHelper

  let(:normal_trend) do
    VCR.use_cassette 'trend' do
      create_cache_mock(false, QiitaTrend::Target.new)
      described_class.new
    end
  end
  let(:personal_trend) do
    VCR.use_cassette 'personal_trend' do
      create_cache_mock(false, QiitaTrend::Target.new(QiitaTrend::TrendType::PERSONAL))
      described_class.new(QiitaTrend::TrendType::PERSONAL)
    end
  end

  describe '#initialize' do
    shared_examples 'scraping data is valid' do
      let(:first_element) { trend.data[0] }
      let(:node_keys)     { %w[author title uuid publishedAt likesCount] }
      let(:author_keys)   { %w[urlName profileImageUrl] }

      it 'TrendのデータがArrayであること' do
        expect(trend.data).to be_a Array
      end

      it 'Dataにnodeのキーが存在すること' do
        expect(first_element).to include('node')
      end

      it 'nodeの配下にスクレイピング対象のキーが存在すること' do
        node_keys.each { |key| expect(first_element['node'].keys).to include(key) }
      end

      it 'authorの配下にスクレイピング対象のキーが存在すること' do
        author_keys.each { |key| expect(first_element['node']['author'].keys).to include(key) }
      end
    end

    context 'when normal trend' do
      let(:trend) { normal_trend }

      it_behaves_like 'scraping data is valid'

      it 'DataにisNewArrivalのキーが存在すること' do
        expect(trend.data[0]).to include('isNewArrival')
      end
    end

    context 'when personal trend' do
      # include_context 'when set configuration', ENV['QIITA_TREND_USER_NAME'], ENV['QIITA_TREND_PASSWORD'], nil

      let(:trend) { personal_trend }

      it_behaves_like 'scraping data is valid'
    end
  end

  describe '#items' do
    subject(:first_items) { trend.items[0] }

    context 'when normal trend' do
      let(:trend) { normal_trend }

      it { is_expected.to include('title', 'user_name', 'user_image', 'likes_count', 'is_new_arrival', 'article', 'published_at', 'user_page') }

      it 'すべての値が取得できていること' do
        first_items.each_key { |key| expect(first_items[key]).not_to be_nil }
      end
    end

    context 'when personal trend' do
      let(:trend) { personal_trend }

      it { is_expected.to include('title', 'user_name', 'user_image', 'likes_count', 'is_new_arrival', 'article', 'published_at', 'user_page') }

      it 'is_new_arrival以外の値が取得できていること' do
        first_items.each_key do |key|
          next if key == 'is_new_arrival'

          expect(first_items[key]).not_to be_nil
        end
      end
    end
  end

  describe '#new_items' do
    let(:new_items) { trend.new_items }

    context 'when normal trend' do
      let(:trend) { normal_trend }

      it '全ての値でisNewArrivalがtrueであること' do
        expect(new_items).to all(include('is_new_arrival' => true))
      end
    end

    context 'when personal trend' do
      let(:trend) { personal_trend }

      it 'nilであること' do
        expect(new_items).to be_nil
      end
    end
  end
end
