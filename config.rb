class Config
	attr_accessor :host
	attr_accessor :interval
	attr_accessor :download_size

	def _defaults
		@host = "google.com"
		@interval = 5
		@download_size = [3000, 3000]
	end

	def initialize
		self._defaults

		if File.exist? "networx.conf"
			read_config = File.readlines "networx.conf"
			@host = read_config[0].chomp
			@interval = read_config[1].chomp.to_i
			@download_size = read_config[2].chomp.split(" ").map { |size| size.to_i }
		else
			self.save
		end
	end

	def save
		File.open("networx.conf", "w") do |f|
			f.puts @host
			f.puts @interval
			f.puts "#{@download_size[0]} #{@download_size[1]}"
		end
	end

	def reset
		self._defaults
		self.save
	end
end