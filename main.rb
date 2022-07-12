require "net/ping"
require "colorize"
require "tty-prompt"
require "io/console"
require "speedtest"
require "tty-spinner"

require_relative "config"
require_relative "util"
require_relative "features/connection_status"
require_relative "features/settings"
require_relative "features/speedtest"

trap "SIGINT" do
	exit
end

$prompt = TTY::Prompt.new interrupt: :exit

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

menu