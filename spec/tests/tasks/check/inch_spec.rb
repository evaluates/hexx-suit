# encoding: utf-8

describe "Rake::Task['check:inch']", :tasks do

  let(:task) { Rake::Task["check:inch"] }

  describe ".invoke", :sandbox, :capture do

    subject { try_in_sandbox { task.invoke } }

    it "runs inch metric" do
      expect { subject }.to change { commands }.to ["inch --pedantic"]
    end
  end
end
