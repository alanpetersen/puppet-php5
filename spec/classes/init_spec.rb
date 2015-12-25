require 'spec_helper'
describe 'php5' do

  context 'with defaults for all parameters' do
    it { should contain_class('php5') }
  end
end
