require "rake"
require "erb"

desc "install the dot files into user's home directory"
task :install do
  replace_all = false
  Dir["*"].each do |file|
    if file.include?("terminfo")
      system %(tic -x "$PWD/#{file}")

      next
    end

    next if %w[Rakefile README.md nvim].include? file

    if File.exist?(File.join(ENV["HOME"], ".#{file.sub(".erb", "")}"))
      if File.identical? file, File.join(ENV["HOME"], ".#{file.sub(".erb", "")}")
        puts "identical ~/.#{file.sub(".erb", "")}"
      elsif replace_all
        replace_file(file)
      else
        print "overwrite ~/.#{file.sub(".erb", "")}? [ynaq] "
        case $stdin.gets.chomp
        when "a"
          replace_all = true
          replace_file(file)
        when "y"
          replace_file(file)
        when "q"
          exit
        else
          puts "skipping ~/.#{file.sub(".erb", "")}"
        end
      end
    else
      link_file(file)
    end
  end

  config_path = "#{ENV["HOME"]}/.config/"
  FileUtils.mkdir_p(config_path)

  if File.symlink?("#{config_path}/nvim") || Dir.exist?("#{config_path}/nvim")
    puts "skipping ~/.config/nvim/"
  else
    puts "linking ~/.config/nvim"
    system %(ln -s "$PWD/nvim" "$HOME/.config/nvim")
  end
end

def replace_file(file)
  system %(rm -rf "$HOME/.#{file.sub(".erb", "")}")
  link_file(file)
end

def link_file(file)
  if /.erb$/.match?(file)
    puts "generating ~/.#{file.sub(".erb", "")}"
    File.write(File.join(ENV["HOME"], ".#{file.sub(".erb", "")}"), ERB.new(File.read(file)).result(binding))
  else
    puts "linking ~/.#{file}"
    system %(ln -s "$PWD/#{file}" "$HOME/.#{file}")
  end
end
