# frozen_string_literal: true

RSpec.describe QiitaTrend::Page do
  let(:page) do
    VCR.use_cassette 'page' do
      described_class.new('Mac Safari')
    end
  end

  describe '#initialize' do
    let(:html) { page.html }

    it 'Qiitaのページが取得できていること' do
      expect(html).to include('<title>Qiita</title>')
    end
  end
end
