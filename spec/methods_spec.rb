require 'spec_helper'
require 'env/variables'

describe Env::Methods do
  subject { Object.new.extend(Methods) }

  let(:home) { '/home/alice' }
  let(:term) { 'xterm' }
  let(:shell) { '/bin/bash' }

  before(:each) do
    allow(subject).to receive(:env).and_return(
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
    expect(subject.paths).to eq([
      Pathname.new('/usr/local/bin'),
      Pathname.new('/usr/bin'),
      Pathname.new('/bin')
    ])
  end

  it "should provide access to the HOME variable" do
    expect(subject.home).to eq(Pathname.new(home))
  end

  it "should use the USERPROFILE variable if HOME is not set" do
    allow(subject).to receive(:env).and_return('USERPROFILE' => home)

    expect(subject.home).to eq(Pathname.new(home))
  end

  it "should use HOMEDRIVE and HOMEPATH if HOME is not set" do
    drive = 'C:'

    allow(subject).to receive(:env).and_return(
      'HOMEDRIVE' => drive,
      'HOMEPATH' => home
    )

    expect(subject.home).to eq(Pathname.new(drive + home))
  end

  it "should attempt to expand '~' if none of the HOME variables are set" do
    allow(subject).to receive(:env).and_return({})

    expect(subject.home).to be_directory
  end

  it "should parse the LANG variable" do
    name, encoding = subject.lang

    expect(name).to eq('en_US')
    expect(encoding).to eq('UTF8')
  end

  it "should return an empty Array if LANG is not set" do
    allow(subject).to receive(:env).and_return({})

    expect(subject.lang).to be_empty
  end

  it "should parse the COLUMNS variable" do
    expect(subject.columns).to eq(80)
  end

  it "should parse the LINES variable" do
    expect(subject.lines).to eq(10)
  end

  it "should provide access to the SHELL variable" do
    expect(subject.shell).to eq(shell)
  end

  it "should determine the program name of the current Shell" do
    expect(subject.shell_name).to eq('bash')
  end

  it "should determine the current Terminal" do
    expect(subject.terminal).to eq(term)
  end

  it "should check COLORTERM before the TERM variable" do
    allow(subject).to receive(:env).and_return(
      'COLORTERM' => 'gnome-terminal',
      'TERM' => term
    )

    expect(subject.terminal).to eq('gnome-terminal')
  end

  it "should check if DEBUG was set" do
    expect(subject).to be_debug
  end
end
