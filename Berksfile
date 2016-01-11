site :opscode

Dir['./cookbooks/**'].each do |path|
  cookbook File.basename(path), path: path
end
