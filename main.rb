require "net/ping"
require "colorize"
require "tty-prompt"
require "io/console"
require "speedtest"
require "tty-spinner"

require_relative "config"
require_relative "util"

trap "SIGINT" do
	exit
end

$prompt = TTY::Prompt.new interrupt: :exit
$config = Config.new

def menu
	logo

	selection = $prompt.select logo, %w(check\ connection speed\ test settings exit)

	case selection
	when "check connection"
		connection_status
	when "speed test"
		speedtest
	when "settings"
		settings
	when "exit"
		exit
	end
end

def connection_status
	thread = Thread.new do
		loop do
			logo

			time = Time.now
			puts "[#{time}]".black.on_white + " " + "USING HOST: #{$config.host} INTERVAL: #{$config.interval}s".black.on_white
			status = Net::Ping::External.new($config.host).ping
			puts "[#{time}]".black.on_white + " " + (status ? "CONNECTION: UP".on_green : "CONNECTION: DOWN".on_red).black

			puts "\nx to return".light_black

			sleep $config.interval
		end
	end
	loop do
		if STDIN.getch === "x"
			thread.kill
			menu
			break
		end
	end
end

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

def speedtest
	logo

	spinner = TTY::Spinner.new ":spinner running speed test", format: :dots
	spinner.auto_spin

	start_time = Time.now.to_i

	results = Speedtest::Test.new(
		download_runs: 4,
		upload_runs: 4,
		ping_runs: 4,
		download_sizes: $config.download_size,
		upload_sizes: [10000, 400000]
	).run

	spinner.stop
	logo

	down = results.pretty_download_rate
	up = results.pretty_upload_rate

	puts "download: #{down} [#{down.chomp(" Mbps").to_i / 8} MB\/s]"
	puts "upload: #{up} [#{up.chomp(" Mbps").to_i / 8} MB\/s]"
	puts "latency: #{results.latency.round}ms"
	puts "server: #{results.server}"
	puts "took: #{Time.now.to_i - start_time}s"
	puts "download size: #{$config.download_size.join ", "} (#{prettify_download_size $config.download_size, false})"

	$prompt.keypress "\nany key to return".light_black
	menu
end

menu