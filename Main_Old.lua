local Personagem = {
    ["Nome"] = nil,
    ["Genero"] = nil,
    ["Raca"] = nil,
    ["Classe"] = nil,
    ["Equipamentos"] = {},
    ["Atributos"] = {
        ["Forca"] = 0,
        ["Destreza"] = 0,
        ["Inteligencia"] = 0,
        ["Resistencia"] = 0,
        ["Carisma"] = 0
    }
}

-- Criação de personagem

print("Crie seu personagem:")
io.write("Nome: ")
Personagem["Nome"] = io.read("l")
io.write("Genero: ")
Personagem["Genero"] = io.read("l")
io.write("Raca: ")
Personagem["Raca"] = io.read("l")
io.write("Classe: ")
Personagem["Classe"] = io.read("l")

-- Distribuição de pontos

print("Distribua um total de 10 pontos para os atributos")

function SomarTable(Table)
    local SomaTotal = 0
    for _, Valor in pairs(Table) do
        SomaTotal = SomaTotal + Valor
    end
    return SomaTotal
end

function ConcatenarDic(Table)
    local TextoFinal = ""
    for Nome, Valor in pairs(Table) do
        TextoFinal = TextoFinal .. "    " .. Nome .. ": " .. Valor .. "\n"
    end
    return TextoFinal
end

while SomarTable(Personagem["Atributos"]) ~= 10 do
    io.write("Forca: ")
    local ForcaColocar = io.read("n")
    local Placeholder = io.read("l")
    if SomarTable(Personagem["Atributos"]) + ForcaColocar > 10 then
        print("O numero total de atributo deve ser igual a 10.")
    else
        Personagem["Atributos"]["Forca"] = Personagem["Atributos"]["Forca"] + ForcaColocar
    end
    print("Atributos totais:\n" .. ConcatenarDic(Personagem["Atributos"]))
end
