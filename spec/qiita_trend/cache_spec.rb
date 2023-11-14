# frozen_string_literal: true

RSpec.describe QiitaTrend::Cache do
  let(:cache) { described_class.new('test_cache') }

  describe '#create_cache' do
    before do
      allow(FileUtils).to receive(:mkdir_p).with(cache.directory).and_return(true)
      allow(File).to receive(:open).and_yield(string_io)
    end

    let(:string_io) { StringIO.new }

    it 'フォルダが作成されること' do
      cache.create_cache('Hello World!!')
      expect(FileUtils).to have_received(:mkdir_p).with(cache.directory)
    end

    it 'キャッシュファイルに書き込まれること' do
      cache.create_cache('Hello World!!')
      expect(string_io.string).to eq 'Hello World!!'
    end
  end

  describe '#load_cache' do
    it 'キャッシュファイルに書き込まれている内容が取得できること' do
      string_io = StringIO.new('Hello World!!')
      allow(File).to receive(:read).and_return(string_io.string)

      expect(cache.load_cache).to eq 'Hello World!!'
    end
  end
end
