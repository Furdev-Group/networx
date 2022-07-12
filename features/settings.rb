require_relative "../config"
require_relative "../util"

def settings
	logo
	
	def review
		logo

		puts "host: #{$config.host}"
		puts "interval: #{$config.interval}"
		puts "download size: #{prettify_download_size $config.download_size}"
		$prompt.keypress "\nany key to return".light_black
	end

	def change
		logo

		puts "leave blank for no change".light_black

		host = $prompt.ask("host:", default: $config.host) do |q|
			q.required false
		end
		$config.host = host

		interval = $prompt.ask("interval:", default: $config.interval, convert: :int) do |q|
			q.required false
			q.validate /\A\d+\Z/
			q.messages[:valid?] = "interval must be a number"
		end
		$config.interval = interval

		download_size = $prompt.select "download size", ["small (fast, innacurate)", "medium (medium, fairly accurate)", "large (slow, most accurate)"]
		case download_size
		when "small (fast, innacurate)"
			$config.download_size = [1000, 1000]
		when "medium (medium, fairly accurate)"
			$config.download_size = [3000, 3000]
		when "large (slow, most accurate)"
			$config.download_size = [4000, 4000]
		end
	
		$config.save
	end

	selection = $prompt.select logo, %w(review change reset\ to\ defaults main\ menu)

	case selection
	when "review"
		review
	when "change"
		change
	when "main menu"
		menu
	when "reset to defaults"
		$config.reset
	end

	settings
end