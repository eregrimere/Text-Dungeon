local JSON = require("json")
local TableUtils = require("Modules/TableUtils")

local ClassesArquivo = io.open("Data/Classes.json", "r")
local Classes = JSON.decode(ClassesArquivo:read("*all"))

local RacasArquivo = io.open("Data/Racas.json", "r")
local Racas = JSON.decode(RacasArquivo:read("*all"))

local Player = {
    Nome = nil,
    Raca = nil,
    Classe = nil,
    Atributos = {Forca = 0, Destreza = 0, Resistencia = 0},
    Equipamentos = {}
}

-- ? Funções

-- Checa se uma string é uma palavra valida
local function StringValida(String, QuantidadeLetras)
    if QuantidadeLetras == nil then
        QuantidadeLetras = 1 -- Se não for passado, assume que é 1
    end
    if String == nil or #String < QuantidadeLetras or String:match("[%p%d]") then return false end
    return true -- retorna true se a string existe, não é vazia e não contém caracteres especiais
end

-- Juntar atributos de duas tables
local function JuntarAtributos(Table)
    for Nome, Valor in pairs(Table) do Player.Atributos[Nome] = Player.Atributos[Nome] + Valor end
end

local function EscolherRacaClasse(Table, Tipo, Tipo2)
    print("\nEscolha uma das " .. Tipo2 .. " abaixo:\n" .. TableUtils.ListarTable(Table))
    repeat -- Loop para checar se é valido
        io.write(Tipo .. ": ")
        Player[Tipo] = io.read("*l"):lower()
        local Valido = false
        for Nome, Atributos in pairs(Table) do
            if Nome:lower() == Player[Tipo] then
                Valido = true
                JuntarAtributos(Atributos)
            end
        end
        if not Valido then
            print("\n" .. Tipo .. " invalida, escolha uma das " .. Tipo2 .. " abaixo:\n" ..
                      TableUtils.ListarTable(Table))
        end
    until Valido
end

-- Função para distribuir os pontos de atributos
local function DistribuirPontos(Atributo)
    local PontosRestantes = 18 - TableUtils.SomarAtributos(Player)
    if PontosRestantes == 0 then return true end
    io.write("Coloque os pontos de " .. Atributo .. ": ")
    local NumeroRecebido = io.read("*n")
    local Placeholder = io.read("*l")
    if NumeroRecebido and NumeroRecebido <= PontosRestantes and NumeroRecebido >= 0 then
        Player.Atributos[Atributo] = Player.Atributos[Atributo] + NumeroRecebido
        print("\n" .. TableUtils.ListarTableDictionaries(Player.Atributos, 1) .. "Pontos restantes: " ..
                  (PontosRestantes - NumeroRecebido))
    else
        print("\nNumero invalido, coloque um numero entre 0 e " .. PontosRestantes)
        DistribuirPontos(Atributo)
    end
end

-- Função para perguntar se o jogador quer redistribuir os pontos novamente
local function RedistribuirPontos(Backup)
    print("\n\nAtributos finais:\n" .. TableUtils.ListarTableDictionaries(Player.Atributos, 1))
    print("Deseja redistribuir os pontos de atributos?")
    io.write("(S/N): ")
    local Resposta = io.read("*l")
    if Resposta:lower() == "s" then
        Player.Atributos = Backup
        return true
    else
        return false
    end
end

-- Função que ativa as outras funções de distribuição de pontos
local function DistribuicaoAtributos()
    print("\nDistribua os atributos do seu personagem:\n" .. TableUtils.ListarTableDictionaries(Player.Atributos, 1) ..
              "Pontos restantes: " .. (18 - TableUtils.SomarAtributos(Player)))
    local BackupPontos = {}
    for Nome, Valor in pairs(Player.Atributos) do BackupPontos[Nome] = Valor end

    repeat
        DistribuirPontos("Forca")
        DistribuirPontos("Destreza")
        DistribuirPontos("Resistencia")
    until TableUtils.SomarAtributos(Player) == 18

    if RedistribuirPontos(BackupPontos) == true then DistribuicaoAtributos() end
end

-- ? Execução

repeat -- Loop para checar se o nome é valido
    io.write("Nome: ")
    Player.Nome = io.read("*l"):lower()
    local NomeValido = StringValida(Player.Nome, 3)
    if not NomeValido then
        print("Nome invalido, coloque um nome com mais de 3 letras e sem caracteres especiais.")
    end
until NomeValido

EscolherRacaClasse(Racas, "Raca", "racas")
EscolherRacaClasse(Classes, "Classe", "classes")

DistribuicaoAtributos()

local PlayerArquivo = io.open("Data/Player.json", "w")
PlayerArquivo:write(JSON.encode(Player))

print("\n\n\n\n\nPERSONAGEM CRIADO:\n" .. TableUtils.ListarTableDictionaries(Player, 1))