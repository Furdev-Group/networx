require_relative "../config"
require_relative "../util"

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