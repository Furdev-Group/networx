require_relative "../config"
require_relative "../util"

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