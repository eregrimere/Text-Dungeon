local Player = {
    Nome = nil,
    Raca = nil,
    Classe = nil,
    Atributos = {
        Forca = 0,
        Destreza = 0,
        Resistencia = 0
    },
    Equipamentos = {}
}

-- Protótipo de criação de personagem


-- Checa se uma string é valida
local function StringValida(String, QuantidadeLetras)
    if QuantidadeLetras == nil then
        QuantidadeLetras = 1 -- Se não for passado, assume que é 1
    end
    if String == nil or #String < QuantidadeLetras or String:match("[%p%d]") then return false end
    return true -- retorna true se a string existe, não é vazia e não contém caracteres especiais
end