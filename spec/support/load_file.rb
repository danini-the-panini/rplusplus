def load_file name
  File.read Pathname.new(File.dirname(__FILE__)).join(name)
end
