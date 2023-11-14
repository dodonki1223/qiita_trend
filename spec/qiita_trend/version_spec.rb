# frozen_string_literal: true

RSpec.describe QiitaTrend do # rubocop:disable  RSpec/FilePath, RSpec/SpecFilePathFormat
  it 'has a version number' do
    expect(QiitaTrend::VERSION).not_to be_nil
  end
end
