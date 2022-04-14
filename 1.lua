local combate = require("Modules/combate")
local JSON = require("json")

local PlayerArquivo = io.open("Data/Player.json", "r")
local Player = JSON.decode(PlayerArquivo:read("*all"))


print (combate.iniciar(Player))
