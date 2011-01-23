require 'spec_helper'
require 'env/variables'

describe Variables do
  subject { Object.new.extend(Variables) }

  it "should parse the contents of the PATH variable" do
    subject.paths.should_not be_empty
  end

  it "should provide access to the HOME variable" do
    subject.home.should_not be_nil
  end

  it "should parse the LANG variable" do
    name, encoding = subject.lang

    name.should_not be_nil
    encoding.should_not be_nil
  end

  it "should parse the COLUMNS variable" do
    subject.columns.should be_kind_of(Integer)
  end

  it "should parse the LINES variable" do
    subject.lines.should be_kind_of(Integer)
  end

  it "should provide access to the SHELL variable" do
    subject.shell.should_not be_nil
  end

  it "should determine the program name of the current Shell" do
    subject.shell_name.should_not be_nil
  end

  it "should determine the current Terminal" do
    subject.terminal.should_not be_nil
  end
end
