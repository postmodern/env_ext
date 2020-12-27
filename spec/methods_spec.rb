require 'spec_helper'
require 'env_ext/methods'

describe EnvExt::Methods do
  subject { Object.new.extend(Methods) }

  let(:home) { '/home/alice' }
  let(:term) { 'xterm' }
  let(:shell) { '/bin/bash' }

  let(:env) do
    {
      'PATH' => '/usr/local/bin:/usr/bin:/bin',
      'HOME' => home,
      'TERM' => term,
      'LANG' => 'en_US.UTF8',
      'COLUMNS' => '80',
      'LINES' => '10',
      'SHELL' => '/bin/bash',
      'DEBUG' => '1'
    }
  end

  subject do
    env.tap { |hash| hash.extend described_class }
  end

  describe "#path" do
    it "should parse the contents of the PATH variable" do
      expect(subject.paths).to eq([
        Pathname.new('/usr/local/bin'),
        Pathname.new('/usr/bin'),
        Pathname.new('/bin')
      ])
    end
  end

  describe "#home" do
    it "should provide access to the HOME variable" do
      expect(subject.home).to eq(Pathname.new(home))
    end

    context "whne USERPROFILE is set, but HOME is not set" do
      let(:env) do
        {
          'USERPROFILE' => home
        }
      end

      it "should use the USERPROFILE variable if HOME is not set" do
        expect(subject.home).to be == Pathname.new(home)
      end
    end

    context "when HOMEDRIVE and HOMEPATH are set, but HOME is not" do
      let(:drive) { 'C:' }
      let(:env) do
        {
          'HOMEDRIVE' => drive,
          'HOMEPATH' => home
        }
      end

      it "should use HOMEDRIVE and HOMEPATH if HOME is not set" do
        expect(subject.home).to be == Pathname.new(drive + home)
      end
    end

    context "when HOME isn't set" do
      let(:env) { {} }

      it "should attempt to expand '~' if none of the HOME variables are set" do
        expect(subject.home).to be_directory
      end
    end
  end

  describe "#lang" do
    it "should parse the LANG variable" do
      name, encoding = subject.lang

      expect(name).to eq('en_US')
      expect(encoding).to eq('UTF8')
    end

    context "when LANG is not set" do
      let(:env) { {} }

      it "should return an empty Array if LANG is not set" do
        expect(subject.lang).to be_empty
      end
    end
  end

  describe "#columns" do
    it "should parse the COLUMNS variable" do
      expect(subject.columns).to eq(80)
    end
  end

  describe "#lines" do
    it "should parse the LINES variable" do
      expect(subject.lines).to eq(10)
    end
  end

  describe "#shell" do
    it "should provide access to the SHELL variable" do
      expect(subject.shell).to eq(shell)
    end
  end

  describe "#shell_name" do
    it "should determine the program name of the current Shell" do
      expect(subject.shell_name).to eq('bash')
    end
  end

  describe "#terminal" do
    it "should determine the current Terminal" do
      expect(subject.terminal).to eq(term)
    end

    context "when COLORTERM and TERM are set" do
      let(:env) do
        {
          'COLORTERM' => 'gnome-terminal',
          'TERM' => term
        }
      end

      it "should check COLORTERM before the TERM variable" do
        expect(subject.terminal).to eq('gnome-terminal')
      end
    end
  end

  describe "#debug" do
    it "should check if DEBUG was set" do
      expect(subject).to be_debug
    end
  end
end
