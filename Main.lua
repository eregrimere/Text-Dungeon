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
io.write("Nome: ");
Personagem["Nome"] = io.read("l")
io.write("Genero: ");
Personagem["Genero"] = io.read("l")
io.write("Raca: ");
Personagem["Raca"] = io.read("l")
io.write("Classe: ");
Personagem["Classe"] = io.read("l")