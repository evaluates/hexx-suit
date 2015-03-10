# encoding: utf-8

describe "Rake::Task['check:run']", :tasks do

  # The {#task_invoked?} helper is defined in the spec/support/config/tasks.rb
  # It checks if a task has been invoked.

  let(:task) { Rake::Task["check:run"] }

  describe ".invoke", :sandbox do

    subject { try_in_sandbox { task.invoke } }

    it "invokes check:coverage:run" do
      expect { subject }
        .to change { task_invoked? "check:coverage:run" }
        .to(true)
    end

    it "invokes check:rubocop:run" do
      expect { subject }
        .to change { task_invoked? "check:rubocop:run" }
        .to(true)
    end

    it "invokes check:fu:run" do
      expect { subject }
        .to change { task_invoked? "check:fu:run" }
        .to(true)
    end

    it "invokes check:yardstick:run" do
      expect { subject }
        .to change { task_invoked? "check:yardstick:run" }
        .to(true)
    end
  end
end
