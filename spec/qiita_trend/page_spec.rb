# frozen_string_literal: true

RSpec.describe QiitaTrend::Page do
  include CacheHelper

  let(:exists_cache_page) do
    create_cache_mock(true, QiitaTrend::Target.new)
    described_class.new
  end
  let(:not_exists_cache_page) do
    create_cache_mock(false, QiitaTrend::Target.new)
    VCR.use_cassette 'page' do
      described_class.new
    end
  end

  describe '#initialize' do
    let(:need_login_page) do
      create_cache_mock(false, QiitaTrend::Target.new(QiitaTrend::TrendType::PERSONAL))
      VCR.use_cassette 'need_login_page' do
        described_class.new(QiitaTrend::TrendType::PERSONAL)
      end
    end

    it 'Qiitaのページが取得できていること' do
      expect(not_exists_cache_page.html).to include('<title>Trend - Qiita</title>')
    end

    context 'when cannot log in' do
      include_context 'when set configuration', 'hoge', 'hoge1234', nil

      it 'LoginFailureErrorが発生すること' do
        expect { need_login_page }.to raise_error(QiitaTrend::Error::LoginFailureError)
      end
    end

    context 'when a cache file exists' do
      it 'キャッシュファイルからロードされること' do
        expect(exists_cache_page.cache).to have_received(:load_cache).once
      end
    end

    context 'when a cache file does not exists' do
      it 'キャッシュファイルが作成されること' do
        expect(not_exists_cache_page.cache).to have_received(:create_cache).once
      end

      it 'キャッシュファイルからロードされないこと' do
        expect(not_exists_cache_page.cache).not_to have_received(:load_cache)
      end
    end

    context 'when a cache file is specified and cache file exists' do
      let(:exists_specified_cache) do
        create_cache_mock(true, QiitaTrend::Target.new(QiitaTrend::TrendType::PERSONAL, 'hogehoge'))
        described_class.new(QiitaTrend::TrendType::PERSONAL, 'hogehoge')
      end

      it 'キャッシュファイルからロードされること' do
        expect(exists_specified_cache.cache).to have_received(:load_cache)
      end
    end

    context 'when a cache file is specified and cache file does not exists' do
      let(:not_exists_specified_cache) { described_class.new(QiitaTrend::TrendType::PERSONAL, 'hogehoge') }
      let(:cache) { not_exists_specified_cache.cache }

      it 'NotExistsCacheErrorが発生すること' do
        expect { not_exists_specified_cache }.to raise_error(QiitaTrend::Error::NotExistsCacheError)
      end
    end
  end
end
