print ("core ready")

network_message = require "network_message"
server_listener = require "server_listener"
message_crypt_aessha1 = require "message_crypt_aessha1"

send_socket = net.createUDPSocket()

network_message.encryptor = message_crypt_aessha1
network_message.addDecryptor(message_crypt_aessha1)

relay_handler = require "relay_handler"
switch_handler = relay_handler(CHANNELS, ENABLED_STATES, 1)

server_listener.add("relay", switch_handler)

server_listener.start(PORT)

pin_power1 = 1
pin_power2 = 2

pin_light1 = 4
pin_light2 = 5

locked_relay_power1 = false
locked_relay_power2 = false

locked_relay_light1 = false
locked_relay_light2 = false


timer_power1 = tmr.create()
power_tick1 = 0
timer_power1:register(100, tmr.ALARM_SEMI, function()    
    state = gpio.read(pin_power1)
    if power_tick1==1000 then
        switch_handler.toggle(switch_handler, send_socket, 1)
        power_tick1 = 0
    else
        if state==0 then 
            power_tick1 = power_tick1 + 100 
            timer_power1:start()
        else 
            power_tick1 = 0
        end
    end
end)

timer_power2 = tmr.create()
power_tick2 = 0
timer_power2:register(100, tmr.ALARM_SEMI, function()    
    state = gpio.read(pin_power2)
    if power_tick2==1000 then
        switch_handler.toggle(switch_handler, send_socket, 2)
        power_tick2 = 0
    else
        if state==0 then 
            power_tick2 = power_tick2 + 100 
            timer_power2:start()
        else 
            power_tick2 = 0
        end
    end
end)

timer_light1 = tmr.create()
light_tick1 = 0
timer_light1:register(100, tmr.ALARM_SEMI, function()    
    state = gpio.read(pin_light1)
    if light_tick1==1000 then        
        switch_handler.toggle(switch_handler, send_socket, 3)
        light_tick1 = 0
    else
        if state==0 then 
            light_tick1 = light_tick1 + 100 
            timer_light1:start()
        else 
            light_tick1 = 0
        end
    end
end)

timer_light2 = tmr.create()
light_tick2 = 0
timer_light2:register(100, tmr.ALARM_SEMI, function()    
    state = gpio.read(pin_light2)
    if light_tick2==1000 then        
        switch_handler.toggle(switch_handler, send_socket, 4)
        light_tick2 = 0
    else
        if state==0 then 
            light_tick2 = light_tick2 + 100 
            timer_light2:start()
        else 
            light_tick2 = 0
        end
    end
end)

function toggle_relay_power1(level)    
    print('power1', level)
    timer_power1:start()
end

function toggle_relay_power2(level)    
    print('power2', level)
    timer_power2:start()
end

function toggle_relay_light1(level)    
    print('light1', level)
    timer_light1:start()
end

function toggle_relay_light2(level)    
    print('light2', level)
    timer_light2:start()
end

gpio.mode(pin_power1, gpio.INT, gpio.PULLUP)
gpio.trig(pin_power1, "down", toggle_relay_power1)

gpio.mode(pin_power2, gpio.INT, gpio.PULLUP)
gpio.trig(pin_power2, "down", toggle_relay_power2)

gpio.mode(pin_light1, gpio.INT, gpio.PULLUP)
gpio.trig(pin_light1, "down", toggle_relay_light1)

gpio.mode(pin_light2, gpio.INT, gpio.PULLUP)
gpio.trig(pin_light2, "down", toggle_relay_light2)
