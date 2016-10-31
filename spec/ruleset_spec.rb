require 'spec_helper'

describe SaganCrafter::FQDNRuleset do
  it 'can generate a ruleset' do
    expect(SaganCrafter::FQDNRuleset.new(['sqlite3_testdb'], test_fqdn_db).rules[0].size).to eq(5)
  end
end
