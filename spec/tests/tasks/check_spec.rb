# encoding: utf-8

describe "Rake::Task[:check]", :tasks do

  # The {#task_invoked?} helper is defined in the spec/support/config/tasks.rb
  # It checks if a task has been invoked.

  let(:task) { Rake::Task[:check] }

  describe ".invoke", :sandbox do

    subject { try_in_sandbox { task.invoke } }

    it "invokes check:pippi:configure" do
      expect { subject }
        .to change { task_invoked? "check:pippi:configure" }
        .to(true)
    end

    it "invokes check:pippi:display" do
      expect { subject }
        .to change { task_invoked? "check:pippi:display" }
        .to(true)
    end

    it "invokes check:coverage" do
      expect { subject }
        .to change { task_invoked? "check:coverage" }
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
