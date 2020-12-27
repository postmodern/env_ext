require 'spec_helper'
require 'env'

describe Env do
  let(:var_name) { 'PATH' }
  let(:var_value) { ENV[var_name] }

  it "should have a VERSION constant" do
    expect(subject.const_get('VERSION')).not_to be_empty
  end

  it "should provide direct Hash access to env variables" do
    expect(subject[var_name]).to eq(var_value)
  end

  it "should allow directly setting env variables" do
    subject['FOO'] = 'bar'

    expect(subject['FOO']).to eq('bar')
  end

  it "should provide transparent CONSTANT access to env variables" do
    expect(subject.const_get(var_name)).to eq(var_value)
  end

  it "should provide transparent method access to env variables" do
    method_name = var_name.downcase

    expect(subject.send(method_name)).to eq(var_value)
  end

  it "should allow setting of environment variables via methods" do
    subject.shell = '/bin/zsh'

    expect(subject['SHELL']).to eq('/bin/zsh')
  end
end
