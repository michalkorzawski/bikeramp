require 'rails_helper'

class DummyClass
  include Mixins::StrFormatter
end

RSpec.describe Mixins::StrFormatter do
  let(:dummy_class) { DummyClass.new }

  it do
    str = 'Plac Europejski 2, Warszawa, Polska'
    str_after = 'Plac+Europejski+2,Warszawa,Polska'

    expect(dummy_class.url_ready(str)).to eq(str_after)
  end

  it do
    str = 'Plac  Europejski  2 , Polska'
    str_after = 'Plac+Europejski+2,Polska'

    expect(dummy_class.url_ready(str)).to eq(str_after)
  end
end
