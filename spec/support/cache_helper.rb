# frozen_string_literal: true

# Cacheクラスのヘルパーモジュール
# CacheのMockの機能を提供します
module CacheHelper
  # CacheクラスのMockを作成する
  #   キャッシュファイルの作成しない、読み込まない、クリアしないものを作成する
  def create_cache_mock(cached, target)
    cache = QiitaTrend::Cache.new(target.cache)
    allow(cache).to receive_messages(cached?: cached, clear_cache: '', load_cache: '', create_cache: '')
    allow(QiitaTrend::Cache).to receive(:new).with(target.cache, QiitaTrend::Cache::DEFAULT_CACHE_DIRECTORY).and_return(cache)
    cache
  end
end
