require 'spec_helper'
require 'env_ext/core_ext'

describe "core_ext" do
  describe "ENV" do
    subject { ENV }

    it { expect(subject).to be_kind_of(EnvExt::Methods) }
  end
end
