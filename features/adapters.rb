require 'socket'
require 'tty-table'
require_relative '../util'
require_relative '../config'

def adapters
    logo

    $adapter_array = []

    addr_infos = Socket.getifaddrs
    addr_infos.each do |addr_info|
        if addr_info.addr
            $adapter_array.append("#{addr_info.name} | #{addr_info.addr.ip_address}") if addr_info.addr.ipv4?
            if addr_info.addr.ipv4? == false then
                $adapter_array.append("#{addr_info.name} | #{addr_info.addr.ip_address}")
            end
        end
    end

    print $adapter_array
    adapter_key = $adapter_array.length

    selection = $prompt.select logo, $adapter_array    

    $adapter_array.each do |adapter|
        if selection == adapter
            addr_infos.each do |addr_info|
                if addr_info.addr
                    if addr_info.name == adapter.split(" | ")[0] then
                        if addr_info.addr.ip_address == adapter.split(" | ")[1] then
                            $adp_name = addr_info.name
                            $adp_type = addr_info.addr.ipv4? ? "IPv4" : "IPv6"
                            $adp_addr = addr_info.addr.ip_address
                        end
                    end
                end
            end

            
            adapter_info_table = TTY::Table.new(["Adapter Name","Adapter Type", "IP Address"], [[$adp_name, $adp_type, $adp_addr]])
            renderer = TTY::Table::Renderer::Unicode.new(adapter_info_table, padding: [0, 0, 1, 0])
            puts renderer.render
            puts "press x to return to main menu".light_black
 
            loop do
                if STDIN.getch === "x" then
                    menu
                    break
                end
            end


        end
    end
end