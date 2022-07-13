require 'os'
require 'git'
require 'fileutils'

if OS.windows?
    if File.directory? "C:/networx" 
        puts "Networx is already installed. would you like to reinstall it? (y/n)"
        confim = gets.chomp
        if confim === "y"
            FileUtils.remove_dir "C:\\networx"
        else
            puts "Install Failed: User did not confirm reinstall, exiting..."
            exit
        end
    end

    File.directory?("./networx") ? exists_error = true : nil

    exists_error ? puts("Install Error: Repostory already exists in directory, would you like to delete it? (y/n)") : nil
    exists_error ? confirm = gets.chomp : nil

    if exists_error && confirm == "y"
        FileUtils.rm_rf "./networx" 
    end

    puts "Cloning Repository..."
    Git.clone "https://github.com/Furdev-Group/networx.git", "networx"
    puts "Cloning Finished"

    puts "Moving files..."

    temp = Dir[Dir.getwd + "/networx/*"]
    temp.each do |filename|
        File.rename filename, "C:/networx/#{filename.split("/").last}"
    end

    exec "set PATH=%PATH%;C:\\networx"
end

if OS.linux?
    puts "Install Failed: Unsupported OS"
end

if OS.mac?
    puts "Install Failed: Unsupported OS"
end