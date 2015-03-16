# encoding: utf-8

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
