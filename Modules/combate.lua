local combate = {}


local JSON = require("json")
local TableUtils = require("Modules/TableUtils")

local InimigosArquivo = io.open("Data/Inimigos.json", "r")
local Inimigos = JSON.decode(InimigosArquivo:read("*all"))
-- ^^ abri tudo btl

function combate.iniciar(Player)
    math.randomseed(os.time())
    local PlacerHolder = math.random(1,10)
    local InimigosSeparados = {}
    local Pesos = {
        PesoTotal = 0,
        Nomes = {""},
        Valores = {1}
    }
    for Nome, Valores in pairs(Inimigos) do
        if Player.Andar >= Valores.AndarMin and Player.Andar <= Valores.AndarMax then
            InimigosSeparados[Nome] = Valores
            Pesos.PesoTotal = Pesos.PesoTotal + Valores.Peso
            table.insert(Pesos.Nomes, Nome)
            table.insert(Pesos.Valores, Pesos.PesoTotal)
        end
    end
    -- print(TableUtils.ListarTableDictionaries(InimigosSeparados), Pesos.PesoTotal)
    local Numero = math.random(1, Pesos.PesoTotal)
    local Escolhido = nil
    for i = 1, #Pesos.Valores, 1 do
        if Numero >= Pesos.Valores[i] and Numero <= Pesos.Valores[i+1] then
            Escolhido = Pesos.Nomes[i+1]
        end
    end
    -- print(Escolhido,Numero,Pesos.PesoTotal)
end

return combate
