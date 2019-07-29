# frozen_string_literal: true

RSpec.describe QiitaTrend::Cache do
  let(:cache) { described_class.new('test_cache') }

  describe '#create_cache' do
    before do
      allow(Dir).to receive(:mkdir).with(cache.directory).and_return(true)
      allow(File).to receive(:open).and_yield(string_io)
    end

    let(:string_io) { StringIO.new }

    context 'when not exists cache folder' do
      it 'フォルダが作成されること' do
        allow(Dir).to receive(:exist?).with(cache.directory).and_return(false)
        cache.create_cache('Hello World!!')
        expect(Dir).to have_received(:mkdir).with(cache.directory)
      end

      it 'キャッシュファイルに書き込まれること' do
        cache.create_cache('Hello World!!')
        expect(string_io.string).to eq 'Hello World!!'
      end
    end

    context 'when exists cache folder' do
      it 'フォルダが作成されないこと' do
        allow(Dir).to receive(:exist?).with(cache.directory).and_return(true)
        cache.create_cache('Hello World!!')
        expect(Dir).not_to have_received(:mkdir).with(cache.directory)
      end

      it 'キャッシュファイルに書き込まれること' do
        cache.create_cache('Hello World!!')
        expect(string_io.string).to eq 'Hello World!!'
      end
    end
  end

  describe '#load_cache' do
    it 'キャッシュファイルに書き込まれている内容が取得できること' do
      string_io = StringIO.new('Hello World!!')
      allow(File).to receive(:open).and_yield(string_io)

      expect(cache.load_cache).to eq 'Hello World!!'
    end
  end

  describe '#clear_cache' do
    it 'ファイルの削除に失敗した時、例外が発生すること' do
      # Fileクラスのexist?がtrueを返すように偽装する
      allow(File).to receive(:exist?).and_return(true)
      # FileクラスのdeleteがStandardErrorを返すように偽装する
      allow(File).to receive(:delete).and_raise(StandardError)

      expect { cache.clear_cache }.to raise_error(StandardError, 'キャッシュファイルの削除に失敗しました')
    end
  end
end
