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
	File.delete "/usr/bin/networx/networx.sh"
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
	puts "Linux support is currently experimental, are you sure you want to continue? (y/n)"
	confim_exp = gets.chomp

	if confim_exp != "y"
		puts "Install Failed: User did not confirm install, exiting..."
		exit
	end

	if File.directory? "/usr/bin/networx" 
		puts "Networx is already installed. would you like to reinstall it? (y/n)"
		confim = gets.chomp
		if confim === "y"
			FileUtils.remove_dir "/usr/bin/networx"
		else
			puts "Install Failed: User did not confirm reinstall, exiting..."
			exit
		end
	end

	begin
		Dir.chdir("/usr/bin/networx")	
	rescue
	end

	puts "Cloning Repository..."
	Git.clone "https://github.com/Furdev-Group/networx.git", "/usr/bin/networx"
	puts "Cloning Finished"

	File.delete "/usr/bin/networx/LICENSE"
	File.delete "/usr/bin/networx/README.md"
	File.delete "/usr/bin/networx/.gitignore"
	File.delete "/usr/bin/networx/networx.bat"
	FileUtils.remove_dir("/usr/bin/networx/.git")
    FileUtils.remove_dir("/usr/bin/networx/installer")
	FileUtils.remove_dir("/usr/bin/networx/readme-assets")

	puts "Install Completed: See messages below for more info"
	puts "Install Info [1]: If you expirence issues running Networx: try using 'bundle' to install the dependencies while in the install folder (/usr/bin/networx)"
	puts "Install Info [2]: If this fails to fix the issue, please create an issue on github at: https://github.com/Furdev-Group/networx/issues"
	
	path = File.new("/etc/profile.d/networx.sh", "w+")
	path.write("export PATH=$PATH:/usr/bin/networx")
	path.flush
	path.close
	
	exec "bundle >nul"

	exit
end

if OS.mac?
	puts "Install Failed: MacOS support is coming soon!"
	exit
end

puts "Install Failed: Unsupported OS"