# encoding: utf-8

RSpec.configure do |config|

  # Array of commands that was sent to system
  #
  # @return [Array<String>]
  def commands
    @commands ||= []
  end

  # Checks whether a task with given name has been invoked
  #
  # @param [String] name
  #
  # @return [Boolean]
  def task_invoked?(name)
    Rake::Task[name].instance_eval { @already_invoked }
  end

  config.before :example, :tasks do

    # Resets Rake application and reinstalls all tasks to be available
    Rake.application = nil
    Hexx::Suit.install_tasks

    # Captures commands that System utility sends to system
    # and stores them in {#commands} array.
    allow(Hexx::RSpec).to receive(:[]) { |command| commands << command }
  end
end
