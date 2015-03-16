# encoding: utf-8

describe "Rake::Task['check:display']", :tasks do

  # The {#task_invoked?} helper is defined in the spec/support/config/tasks.rb
  # It checks if a task has been invoked.

  let(:task) { Rake::Task["check:display"] }

  describe ".invoke", :sandbox, :capture do

    subject { try_in_sandbox { task.invoke } }

    it "invokes check:inch" do
      expect { subject }
        .to change { task_invoked? "check:inch" }
        .to(true)
    end

    it "invokes check:rubocop:display" do
      expect { subject }
        .to change { task_invoked? "check:rubocop:display" }
        .to(true)
    end

    it "invokes check:fu:display" do
      expect { subject }
        .to change { task_invoked? "check:fu:display" }
        .to(true)
    end

    it "invokes test:coverage:display" do
      expect { subject }
        .to change { task_invoked? "test:coverage:display" }
        .to(true)
    end

    it "invokes check:yardstick:display" do
      expect { subject }
        .to change { task_invoked? "check:yardstick:display" }
        .to(true)
    end
  end
end
