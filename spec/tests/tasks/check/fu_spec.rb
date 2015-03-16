# encoding: utf-8

describe "Rake::Task['check:fu']", :tasks do

  # The {#task_invoked?} helper is defined in the spec/support/config/tasks.rb
  # It checks if a task has been invoked.

  let(:task) { Rake::Task["check:fu"] }

  describe ".invoke", :sandbox, :capture do

    subject { try_in_sandbox { task.invoke } }

    it "invokes check:fu:run" do
      expect { subject }.to change { task_invoked? "check:fu:display" }.to true
    end
  end
end
