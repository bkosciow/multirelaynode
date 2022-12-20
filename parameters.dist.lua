_WIFI_APS = {
    {["ssid"]="", ["pwd"]=""},
    {["ssid"]="", ["pwd"]=""}
}

PROTOCOL = "iot:1"
PROTOCOL_ALLOW_UNENCRYPTED  = false

ENCODER_AESSHA1_STATICIV = 'abcdef2345678901'
ENCODER_AESSHA1_IVKEY = '2345678901abcdef'
ENCODER_AESSHA1_DATAKEY ='0123456789abcdef'
ENCODER_AESSHA1_PASSPHRASE = 'mypassphrase'

PORT = 5053
CHANNELS = {2,3}
if file.exists('parameters-device.lc') then  
    dofile("parameters-device.lc")        
else
    dofile("parameters-device.lua")        
end
