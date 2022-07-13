require 'os'
require 'git'
require 'fileutils'

if OS.windows?
	if File.directory? "C:/networx" 
		puts "Networx is already installed. would you like to reinstall it? (y/n)"
		confim = gets.chomp
		if confim === "y"
			FileUtils.remove_dir "C:/networx"
		else
			puts "Install Failed: User did not confirm reinstall, exiting..."
			exit
		end
	end
    
	begin
		Dir.chdir("C:/networx")	
	rescue
	end

	puts "Cloning Repository..."
	Git.clone "https://github.com/Furdev-Group/networx.git", "C:\\networx"
	puts "Cloning Finished"
    
	File.delete "C:/networx/LICENSE"
	File.delete "C:/networx/README.md"
	File.delete "C:/networx/.gitignore"
	FileUtils.remove_dir("C:/networx/.git")
    FileUtils.remove_dir("C:/networx/installer")
	FileUtils.remove_dir("C:/networx/readme-assets")

	puts "Install Completed: Please add C:/networx to your PATH variable, here is a guide: https://windowsloop.com/how-to-add-to-windows-path/"
	puts "Install Info [1]: If you expirence issues running Networx: try using 'bundle' to install the dependencies while in the install folder"
	puts "Install Info [2]: If this fails to fix the issue, please create an issue on github at: https://github.com/Furdev-Group/networx/issues"
	exec "bundle >nul"
	exit
    	
end

if OS.linux?
	puts "Install Failed: Unsupported OS"
	exit
end

if OS.mac?
	puts "Install Failed: Unsupported OS"
	exit
end

puts "Install Failed: Unsupported OS"