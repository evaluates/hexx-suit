# encoding: utf-8

describe "Rake::Task['check:rubocop']", :tasks do

  # The {#task_invoked?} helper is defined in the spec/support/config/tasks.rb
  # It checks if a task has been invoked.

  let(:task) { Rake::Task["check:rubocop"] }

  describe ".invoke", :sandbox do

    subject { try_in_sandbox { task.invoke } }

    it "invokes check:rubocop:run" do
      expect { subject }
        .to change { task_invoked? "check:rubocop:run" }
        .to(true)
    end

    it "invokes check:rubocop:display" do
      expect { subject }
        .to change { task_invoked? "check:rubocop:display" }
        .to(true)
    end
  end
end
