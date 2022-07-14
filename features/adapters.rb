require "socket"
require "tty-table"
require "tty-platform"
require_relative "../util"
require_relative "../config"

$platform = TTY::Platform.new

def adapters
    logo

    addrs = Socket.getifaddrs if $platform.windows?
    addrs = Socket.ip_address_list if not $platform.windows?

    selection = $prompt.select logo do |menu|
        addrs.map do |addr|
            menu.choice("#{addr.name} | #{addr.addr.nil? ? "N/A" : addr.addr.ip_address}", addr) if $platform.windows?
            menu.choice("#{addr.ip_address}", addr) if not $platform.windows?
        end

        menu.choice "main menu"
    end

    case selection
    when "main menu"
        menu
    end

    adapter(selection)
end

def adapter(adapter)
    logo

    if $platform.windows?
        name = adapter.name
        type = "N/A" if adapter.addr.nil?
        type = adapter.addr.ipv4? ? "IPv4" : "IPv6" if not adapter.addr.nil?
        address = "N/A" if adapter.addr.nil?
        address = adapter.addr.ip_address if not adapter.addr.nil?
    else
        name = "N/A"
        type = "N/A" if adapter.nil?
        type = adapter.ipv4? ? "IPv4" : "IPv6" if not adapter.nil?
        address = "N/A" if adapter.nil?
        address = adapter.ip_address if not adapter.nil?
    end
    
    adapter_info_table = TTY::Table.new(["Adapter Name", "Adapter Type", "IP Address"], [[name, type, address]])
    renderer = TTY::Table::Renderer::Unicode.new(adapter_info_table, padding: [0, 1, 1, 1])
    puts renderer.render

    $prompt.keypress "\nany key to return".light_black
	adapters
end