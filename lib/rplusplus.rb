require "rplusplus/version"

module RPlusPlus
  def self.immediate_deps source
    source.each_line.map do |l|
      m = /#include "(?<file>.*)"/.match(l)
      m[:file] if m
    end.delete_if { |x| x.nil? }.to_set
  end

  def self.deps filename
    these = immediate_deps(File.read filename)
    those = these.map do |f|
      deps f
    end
    those.each do |d|
      these.merge d
    end
    these
  end

  def self.objectify filename
    filename.gsub(/cpp$/,'o')
  end

  def self.each_cpp &block
    Dir[Pathname('.').join('**/*.cpp')].each(&block)
  end

  def self.deps_hash
    hash = {}
    each_cpp do |cpp|
      hash[objectify cpp] = [cpp] + deps(cpp).to_a
    end
    hash
  end
end
