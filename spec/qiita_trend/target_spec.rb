# frozen_string_literal: true

RSpec.describe QiitaTrend::Target do
  describe '#initialize' do
    shared_examples 'need login' do |type, need_login|
      let(:target) { described_class.new(type) }

      it { expect(target.need_login).to eq need_login }
    end

    shared_examples 'url that matches the type' do |type, url|
      let(:target) { described_class.new(type) }

      it { expect(target.url).to eq url }
    end

    shared_examples 'cache name that matches the type and time' do |type, time, cache_name|
      let(:target) { described_class.new(type) }

      it "#{time.strftime('%Y-%m-%d %H:%M:%S')}の時 #{cache_name}であること" do
        allow(Time).to receive(:now).and_return(time)
        allow(Date).to receive(:today).and_return(Date.new(time.year, time.month, time.day))
        expect(target.cache).to eq cache_name
      end
    end

    context 'when target is daily' do
      it_behaves_like 'need login',
                      QiitaTrend::TrendType::DAILY,
                      false
      it_behaves_like 'url that matches the type',
                      QiitaTrend::TrendType::DAILY,
                      'https://qiita.com/'
      it_behaves_like 'cache name that matches the type and time',
                      QiitaTrend::TrendType::DAILY,
                      Time.new(Time.now.year, Time.now.month, Time.now.day, 12),
                      "#{Time.now.strftime('%Y%m%d')}05_#{QiitaTrend::TrendType::DAILY}.html"
      it_behaves_like 'cache name that matches the type and time',
                      QiitaTrend::TrendType::DAILY,
                      Time.new(Time.now.year, Time.now.month, Time.now.day, 18),
                      "#{Time.now.strftime('%Y%m%d')}17_#{QiitaTrend::TrendType::DAILY}.html"
      it_behaves_like 'cache name that matches the type and time',
                      QiitaTrend::TrendType::DAILY,
                      Time.new(Time.now.year, Time.now.month, Time.now.day + 1, 4),
                      "#{Time.now.strftime('%Y%m%d')}17_#{QiitaTrend::TrendType::DAILY}.html"
    end

    context 'when target is weekly' do
      it_behaves_like 'need login',
                      QiitaTrend::TrendType::WEEKLY,
                      true
      it_behaves_like 'url that matches the type',
                      QiitaTrend::TrendType::WEEKLY,
                      'https://qiita.com/?scope=weekly'
      it_behaves_like 'cache name that matches the type and time',
                      QiitaTrend::TrendType::WEEKLY,
                      Time.new(Time.now.year, Time.now.month, Time.now.day, 12),
                      "#{Time.now.strftime('%Y%m%d')}05_#{QiitaTrend::TrendType::WEEKLY}.html"
      it_behaves_like 'cache name that matches the type and time',
                      QiitaTrend::TrendType::WEEKLY,
                      Time.new(Time.now.year, Time.now.month, Time.now.day, 18),
                      "#{Time.now.strftime('%Y%m%d')}17_#{QiitaTrend::TrendType::WEEKLY}.html"
      it_behaves_like 'cache name that matches the type and time',
                      QiitaTrend::TrendType::WEEKLY,
                      Time.new(Time.now.year, Time.now.month, Time.now.day + 1, 4),
                      "#{Time.now.strftime('%Y%m%d')}17_#{QiitaTrend::TrendType::WEEKLY}.html"
    end

    context 'when target is monthly' do
      it_behaves_like 'need login',
                      QiitaTrend::TrendType::MONTHLY,
                      true
      it_behaves_like 'url that matches the type',
                      QiitaTrend::TrendType::MONTHLY,
                      'https://qiita.com/?scope=monthly'
      it_behaves_like 'cache name that matches the type and time',
                      QiitaTrend::TrendType::MONTHLY,
                      Time.new(Time.now.year, Time.now.month, Time.now.day, 12),
                      "#{Time.now.strftime('%Y%m%d')}05_#{QiitaTrend::TrendType::MONTHLY}.html"
      it_behaves_like 'cache name that matches the type and time',
                      QiitaTrend::TrendType::MONTHLY,
                      Time.new(Time.now.year, Time.now.month, Time.now.day, 18),
                      "#{Time.now.strftime('%Y%m%d')}17_#{QiitaTrend::TrendType::MONTHLY}.html"
      it_behaves_like 'cache name that matches the type and time',
                      QiitaTrend::TrendType::MONTHLY,
                      Time.new(Time.now.year, Time.now.month, Time.now.day + 1, 4),
                      "#{Time.now.strftime('%Y%m%d')}17_#{QiitaTrend::TrendType::MONTHLY}.html"
    end
  end
end
