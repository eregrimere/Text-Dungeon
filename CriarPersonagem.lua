local Player = {
    Nome = nil,
    Raca = nil,
    Classe = nil,
    Atributos = {Forca = 0, Destreza = 0, Resistencia = 0},
    Equipamentos = {}
}

local Racas = {
    Humano = {Forca = 2, Destreza = 2, Resistencia = 2},
    Elfo = {Forca = 2, Destreza = 3, Resistencia = 1},
    Anao = {Forca = 2, Destreza = 1, Resistencia = 3},
    Ogro = {Forca = 3, Destreza = 1, Resistencia = 2}
}

local Classes = {
    Guerreiro = {Forca = 2, Destreza = 0, Resistencia = 0},
    Ladino = {Forca = 0, Destreza = 2, Resistencia = 0},
    Paladino = {Forca = 0, Destreza = 0, Resistencia = 2}
}

-- ? Protótipo de criação de personagem

-- Checa se uma string é uma palavra valida
local function StringValida(String, QuantidadeLetras)
    if QuantidadeLetras == nil then
        QuantidadeLetras = 1 -- Se não for passado, assume que é 1
    end
    if String == nil or #String < QuantidadeLetras or String:match("[%p%d]") then return false end
    return true -- retorna true se a string existe, não é vazia e não contém caracteres especiais
end

-- Lista os valores dentro de uma table
local function ListarTable(Table)
    local TextoFinal = ""
    for Nome, Valor in pairs(Table) do TextoFinal = TextoFinal .. Nome .. "    " end
    return TextoFinal
end

-- Juntar atributos de duas tables
local function JuntarAtributos(Table)
    for Nome, Valor in pairs(Table) do Player.Atributos[Nome] = Player.Atributos[Nome] + Valor end
end

-- Lista todos os atributos de um personagem
local function ListarAtributos(Personagem)
    local TextoFinal = "Atributos de " .. Personagem.Nome .. ":\n"
    for Nome, Valor in pairs(Personagem.Atributos) do
        TextoFinal = TextoFinal .. "  " .. Nome .. ": " .. Valor .. "\n"
    end
    return TextoFinal
end

-- Retorna o valor total de pontos de atributos de um personagem
local function SomarAtributos(Personagem)
    local SomaTotal = 0
    for _, Valor in pairs(Personagem.Atributos) do SomaTotal = SomaTotal + Valor end
    return SomaTotal
end

repeat -- Loop para checar se o nome é valido
    io.write("Nome: ")
    Player.Nome = io.read("l")
    local NomeValido = StringValida(Player.Nome, 3)
    if not NomeValido then
        print("Nome invalido, coloque um nome com mais de 3 letras e sem caracteres especiais.")
    end
until NomeValido

local function EscolherRacaClasse(Table, Table2, Tipo, Tipo2)
    print("\nEscolha uma das " .. Tipo2 .. " abaixo:\n" .. ListarTable(Table))
    repeat -- Loop para checar se é valido
        io.write(Tipo .. ": ")
        Table2 = io.read("l"):lower()
        local Valido = false
        for Nome, Atributos in pairs(Table) do
            if Nome:lower() == Table2 then
                Valido = true
                JuntarAtributos(Atributos)
            end
        end
        if not Valido then
            print("\n" .. Tipo .. " invalida, escolha uma das " .. Tipo2 .. " abaixo:\n" ..
                      ListarTable(Table))
        end
    until Valido
end

EscolherRacaClasse(Racas, Player.Raca, "Raca", "racas")
EscolherRacaClasse(Classes, Player.Classe, "Classe", "classes")

print("\nDistribua os atributos do seu personagem:\n" .. ListarAtributos(Player) ..
          "Pontos restantes: " .. (18 - SomarAtributos(Player)))

-- Função para distribuir os pontos de atributos
local function DistribuirPontos(Atributo)
    local PontosRestantes = 18 - SomarAtributos(Player)
    if PontosRestantes == 0 then return true end
    io.write("Coloque os pontos de " .. Atributo .. ": ")
    local NumeroRecebido = io.read("n")
    local Placeholder = io.read("l")
    if NumeroRecebido and NumeroRecebido <= PontosRestantes and NumeroRecebido > 0 then
        Player.Atributos[Atributo] = Player.Atributos[Atributo] + NumeroRecebido
        print("\n" .. ListarAtributos(Player) .. "Pontos restantes: " ..
                  (PontosRestantes - NumeroRecebido))
    else
        print("\nNumero invalido, coloque um numero entre 1 e " .. PontosRestantes)
        DistribuirPontos(Atributo)
    end
end

repeat
    DistribuirPontos("Forca")
    DistribuirPontos("Destreza")
    DistribuirPontos("Resistencia")
until SomarAtributos(Player) == 18
