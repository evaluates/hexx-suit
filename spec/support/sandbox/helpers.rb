# encoding: utf-8
require "yaml"

# Yields block and captures stdout stream.
#
# @example
#   capture_stdout { do_something }
#
# @return [String] The captured stream.
def capture_stdout
  begin
    $stdout = StringIO.new
    yield
    result = $stdout.string
  ensure
    $stdout = STDOUT
  end
  result.to_s
end

# Returns the path to the temporary `spec/sandbox`.
# @return [String] The absolute path.
def sandbox
  @sandbox ||= File.expand_path "../../../sandbox", __FILE__
end

# Clears the temporary `spec/sandbox`.
def clear_sandbox
  FileUtils.rm_rf sandbox
end

# Re-creates the temporary `spec/sandbox`.
def prepare_sandbox
  clear_sandbox
  FileUtils.mkdir_p sandbox
end

# Runs code from the temporary `spec/sandbox`.
def try_in_sandbox
  FileUtils.cd(sandbox) { capture_stdout { yield } }
end

# Reads file in sandbox and returns file content.
# Returns a blank string when the file is absent.
# @return [String] The content.
def read_in_sandbox(filename)
  file = Dir[File.join(sandbox, filename)].first
  file ? File.read(file) : ""
end

# Creates settings file in a sandbox
#
# @param [Hash] settings ({})
#   The list of settings to be stored in 'sandbox/.metrics.yml'
#
# @return [undefined]
def prepare_settings(settings, file = ".metrics.yml")
  try_in_sandbox do
    ::FileUtils.mkdir_p ::File.dirname(file)
    ::File.write file, settings.to_yaml
  end
end
