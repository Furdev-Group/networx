def prettify_download_size(size, with_descriptor = true)
	case size
	when [1000, 1000]
		x = "small"
		x + " (fast, innacurate)" if with_descriptor
		x
	when [3000, 3000]
		x = "medium"
		x + " (medium, fairly accurate)" if with_descriptor
		x
	when [4000, 4000]
		x = "large"
		x + " (slow, most accurate)" if with_descriptor
		x
	end
end

def logo
	puts "\e[2J\e[f"
	puts "[networx]".black.on_white
end