require 'spec_helper'
require 'env'

describe Env do
  let(:var_name) { 'PATH' }
  let(:var_value) { ENV[var_name] }

  it "should have a VERSION constant" do
    subject.const_get('VERSION').should_not be_empty
  end

  it "should provide direct Hash access to env variables" do
    subject[var_name].should == var_value
  end

  it "should allow directly setting env variables" do
    subject['FOO'] = 'bar'

    subject['FOO'].should == 'bar'
  end

  it "should provide transparent CONSTANT access to env variables" do
    subject.const_get(var_name).should == var_value
  end

  it "should provide transparent method access to env variables" do
    method_name = var_name.downcase

    subject.send(method_name).should == var_value
  end

  it "should allow setting of environment variables via methods" do
    subject.shell = '/bin/zsh'

    subject['SHELL'].should == '/bin/zsh'
  end
end
