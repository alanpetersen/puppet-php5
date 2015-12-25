# Fact: phpversion
#
# Purpose: gets the current php version
#
# Resolution:
#   Tests for presence of any php instances
#
# Caveats:
#   p4 must be found on the standard path
#
# Notes:
#   None

path = ENV['PATH'] + ':/usr/local/bin'
ENV['PATH'] = path

versions = Hash.new

matches = `which -a php`.split()
matches.each do |line|
  f = IO.popen(line + ' --version', 'r')
  while output = f.gets
    if output.start_with?('PHP ')
      ver = output.split[1]
      versions[line] = ver
    end
  end
  f.close
end

if versions.length > 0
  Facter.add(:phplist) do
    setcode do
      versions.inspect
    end
  end
  max_version = '0'
  if versions.length > 1
    # need to find the highest version
    versions.keys.each do |k|
      if versions[k] > max_version
        max_version = versions[k]
      end
    end
  else
    max_version = versions.values[0]
  end
  Facter.add(:phpversion) do
    setcode do
      max_version
    end
  end
end
