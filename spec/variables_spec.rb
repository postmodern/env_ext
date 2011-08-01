require 'spec_helper'
require 'env/variables'

describe Variables do
  subject { Object.new.extend(Variables) }

  let(:home) { '/home/alice' }
  let(:term) { 'xterm' }
  let(:shell) { '/bin/bash' }

  before(:each) do
    subject.stub!(:env).and_return(
      'PATH' => '/usr/local/bin:/usr/bin:/bin',
      'HOME' => home,
      'TERM' => term,
      'LANG' => 'en_US.UTF8',
      'COLUMNS' => '80',
      'LINES' => '10',
      'SHELL' => '/bin/bash',
      'DEBUG' => '1'
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

  it "should use the USERPROFILE variable if HOME is not set" do
    subject.stub!(:env).and_return('USERPROFILE' => home)

    subject.home.should == Pathname.new(home)
  end

  it "should use HOMEDRIVE and HOMEPATH if HOME is not set" do
    drive = 'C:'

    subject.stub!(:env).and_return(
      'HOMEDRIVE' => drive,
      'HOMEPATH' => home
    )

    subject.home.should == Pathname.new(drive + home)
  end

  it "should attempt to expand '~' if none of the HOME variables are set" do
    subject.stub!(:env).and_return({})

    subject.home.should be_directory
  end

  it "should parse the LANG variable" do
    name, encoding = subject.lang

    name.should == 'en_US'
    encoding.should == 'UTF8'
  end

  it "should return an empty Array if LANG is not set" do
    subject.stub!(:env).and_return({})

    subject.lang.should be_empty
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
    subject.stub!(:env).and_return(
      'COLORTERM' => 'gnome-terminal',
      'TERM' => term
    )

    subject.terminal.should == 'gnome-terminal'
  end

  it "should check if DEBUG was set" do
    subject.should be_debug
  end
end
