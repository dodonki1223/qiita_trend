# frozen_string_literal: true

RSpec.describe QiitaTrend::Target do
  describe '#initialize' do
    shared_examples 'need login' do
      let(:trend_type) { QiitaTrend::TrendType::NORMAL }
      let(:need_login) { false }
      let(:target)     { described_class.new(trend_type) }

      it { expect(target.need_login).to eq need_login }
    end

    shared_examples 'url that matches the type' do
      let(:trend_type) { QiitaTrend::TrendType::NORMAL }
      let(:target)     { described_class.new(trend_type) }
      let(:url)        { QiitaTrend::Page::QIITA_URI }

      it { expect(target.url).to eq url }
    end

    shared_examples 'cache name that matches the type and time' do
      let(:trend_type)  { QiitaTrend::TrendType::NORMAL }
      let(:target)      { described_class.new(trend_type) }
      let(:target_time) { Time.new }
      let(:cache_hour)  { '05' }
      let(:cache_name) do
        today = Time.now.hour < 5 ? Date.today.prev_day(1) : Date.today
        "#{today.strftime('%Y%m%d')}#{cache_hour}_#{trend_type}.html"
      end

      it 'キャッシュファイル名が正しいこと' do
        allow(Time).to receive(:now).and_return(target_time)
        allow(Date).to receive(:today).and_return(Date.new(target_time.year, target_time.month, target_time.day))
        expect(target.cache).to eq cache_name
      end
    end

    context 'when target is normal' do
      let(:trend_type) { QiitaTrend::TrendType::NORMAL }

      it_behaves_like 'need login'
      it_behaves_like 'url that matches the type'
      it_behaves_like 'cache name that matches the type and time' do
        let(:target_time) { Time.new(Date.today.year, Date.today.month, Date.today.day, 12) }
      end
      it_behaves_like 'cache name that matches the type and time' do
        let(:cache_hour)  { '17' }
        let(:target_time) { Time.new(Date.today.year, Date.today.month, Date.today.day, 18) }
      end
      it_behaves_like 'cache name that matches the type and time' do
        let(:cache_hour)  { '17' }
        let(:target_time) { Time.new(Date.today.next_day(1).year, Date.today.next_day(1).month, Date.today.next_day(1).day, 4) }
      end
    end

    context 'when target is personal' do
      let(:trend_type) { QiitaTrend::TrendType::PERSONAL }

      it_behaves_like 'need login'
      it_behaves_like 'url that matches the type'
      it_behaves_like 'cache name that matches the type and time' do
        let(:target_time) { Time.new(Date.today.year, Date.today.month, Date.today.day, 12) }
      end
      it_behaves_like 'cache name that matches the type and time' do
        let(:cache_hour)  { '17' }
        let(:target_time) { Time.new(Date.today.year, Date.today.month, Date.today.day, 18) }
      end
      it_behaves_like 'cache name that matches the type and time' do
        let(:cache_hour)  { '17' }
        let(:target_time) { Time.new(Date.today.next_day(1).year, Date.today.next_day(1).month, Date.today.next_day(1).day, 4) }
      end
    end
  end
end
