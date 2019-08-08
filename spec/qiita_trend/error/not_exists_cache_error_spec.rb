# frozen_string_literal: true

RSpec.describe QiitaTrend::Error::NotExistsCacheError do
  include CacheHelper

  let(:target) { QiitaTrend::Target.new }
  let(:cache) { create_cache_mock(true, target) }
  let(:not_exists_cache) { described_class.new(cache) }

  describe '#message' do
    it 'メッセージにキャッシュのフルパスが含まれていること' do
      expect(not_exists_cache.message).to include(cache.full_path)
    end
  end
end
