print ("Booting..")
gpio.mode(0, gpio.INPUT, gpio.PULLUP)
gpio.mode(1, gpio.INPUT, gpio.PULLUP)
if gpio.read(0) == 10 then
    print("..aborted")  
else    
    if file.exists('parameters.lc') then  
        dofile("parameters.lc")        
    else
        dofile("parameters.lua")        
    end

    tmr.create():alarm(2000, tmr.ALARM_SINGLE, function()
        print ("..launch..")     
        if file.exists('wifi-init.lc') then  
            dofile("wifi-init.lc")        
        else
            dofile("wifi-init.lua")        
        end
    end)
end    
