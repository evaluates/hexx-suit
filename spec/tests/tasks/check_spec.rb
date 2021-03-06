# encoding: utf-8

describe "Rake::Task[:check]", :tasks do

  # The {#task_invoked?} helper is defined in the spec/support/config/tasks.rb
  # It checks if a task has been invoked.

  let(:task) { Rake::Task[:check] }

  describe ".invoke", :sandbox, :capture do

    subject { try_in_sandbox { task.invoke } }

    it "invokes test:coverage" do
      expect { subject }
        .to change { task_invoked? "test:coverage" }
        .to(true)
    end

    it "invokes check:rubocop" do
      expect { subject }
        .to change { task_invoked? "check:rubocop" }
        .to(true)
    end

    it "invokes check:fu" do
      expect { subject }
        .to change { task_invoked? "check:fu" }
        .to(true)
    end

    it "invokes check:inch" do
      expect { subject }
        .to change { task_invoked? "check:inch" }
        .to(true)
    end

    it "invokes check:yardstick" do
      expect { subject }
        .to change { task_invoked? "check:yardstick" }
        .to(true)
    end
  end
end
