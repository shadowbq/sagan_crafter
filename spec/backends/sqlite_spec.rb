require 'spec_helper'

describe SaganCrafter::Backends::SQLite do
  it 'can return the size' do
    expect(SaganCrafter::Backends::SQLite.new(SaganCrafter::Factory::FQDNlogger.new, test_fqdn_db).size()).to eq(5)
  end

end
