require 'socket'
require 'tty-table'
require_relative '../util'
require_relative '../config'

def adapters
    logo

    $adapter_array = []

    addrs = Socket.getifaddrs

    selection = $prompt.select logo do |menu|
        addrs.map do |addr|
            menu.choice "#{addr.name} | #{addr.addr.nil? ? "N/A" : addr.addr.ip_address}", addr
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

    name = adapter.name
    type = "N/A" if adapter.addr.nil?
    type = adapter.addr.ipv4? ? "IPv4" : "IPv6" if not adapter.addr.nil?
    address = "N/A" if adapter.addr.nil?
    address = adapter.addr.ip_address if not adapter.addr.nil?

    adapter_info_table = TTY::Table.new(["Adapter Name", "Adapter Type", "IP Address"], [[name, type, address]])
    renderer = TTY::Table::Renderer::Unicode.new(adapter_info_table, padding: [0, 1, 1, 1])
    puts renderer.render

    $prompt.keypress "\nany key to return".light_black
	adapters
end