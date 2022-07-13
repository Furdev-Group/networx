require_relative "../config"
require_relative "../util"

def connection_status
	thread = Thread.new do
		loop do
			logo

			time = Time.now
			puts "[#{time}]" + " " + "USING HOST: #{$config.host} INTERVAL: #{$config.interval}s"
			status = Net::Ping::External.new($config.host).ping
			puts "[#{time}]" + " " + (status ? "CONNECTION: UP".on_green : "CONNECTION: DOWN".on_red).black

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