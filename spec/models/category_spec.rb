require 'rails_helper'
require 'spec_helper'

describe Category do
  it 'should be valid' do
    expect(build(:category)).to be_valid
  end

  it 'should have name' do
    expect(build(:category, name: nil)).not_to be_valid
  end
  it 'should have ctype' do
    expect(build(:category, ctype: nil)).not_to be_valid
  end
end
