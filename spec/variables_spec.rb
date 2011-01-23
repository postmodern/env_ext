require 'spec_helper'
require 'env/variables'

describe Variables do
  subject { Object.new.extend(Variables) }

  let(:home) { '/home/alice' }
  let(:term) { 'xterm' }
  let(:shell) { '/bin/bash' }

  before(:each) do
    subject.stub!(:env_hash).and_return(
      'PATH' => '/usr/local/bin:/usr/bin:/bin',
      'HOME' => home,
      'TERM' => term,
      'LANG' => 'en_US.UTF8',
      'COLUMNS' => '80',
      'LINES' => '10',
      'SHELL' => '/bin/bash'
    )
  end

  it "should parse the contents of the PATH variable" do
    subject.paths.should == [
      Pathname.new('/usr/local/bin'),
      Pathname.new('/usr/bin'),
      Pathname.new('/bin')
    ]
  end

  it "should provide access to the HOME variable" do
    subject.home.should == Pathname.new(home)
  end

  it "should check HOMEPATH if HOME is not set" do
    subject.stub!(:env_hash).and_return('HOMEPATH' => home)

    subject.home.should == Pathname.new(home)
  end

  it "should parse the LANG variable" do
    name, encoding = subject.lang

    name.should == 'en_US'
    encoding.should == 'UTF8'
  end

  it "should parse the COLUMNS variable" do
    subject.columns.should == 80
  end

  it "should parse the LINES variable" do
    subject.lines.should == 10
  end

  it "should provide access to the SHELL variable" do
    subject.shell.should == shell
  end

  it "should determine the program name of the current Shell" do
    subject.shell_name.should == 'bash'
  end

  it "should determine the current Terminal" do
    subject.terminal.should == term
  end

  it "should check COLORTERM before the TERM variable" do
    subject.stub!(:env_hash).and_return(
      'COLORTERM' => 'gnome-terminal',
      'TERM' => term
    )

    subject.terminal.should == 'gnome-terminal'
  end
end
