require 'spec_helper'

describe SaganCrafter::Factory::FQDNlogger do

  let(:factory) {SaganCrafter::Factory::FQDNlogger.new}

  before :each do


  end

  it 'can return the size' do
    expect(factory.rule("futuras.com", "vxvault", "url_reputation", 10, 1477926621)).to be_kind_of(Snort::Rule)
  end

  it 'can create a signature' do
    expect(factory.rule("futuras.com", "vxvault", "url_reputation", 10, 1477926621).to_s[45..115]).to eq("SIVEDNS] vxvault url_reputation - futuras.com\"; content:\"futuras.com\"; ")
  end
end
