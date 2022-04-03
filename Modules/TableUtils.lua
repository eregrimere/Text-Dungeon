local TableUtils = {}

-- Lista os valores dentro de uma table
function TableUtils.ListarTable(Table)
    local TextoFinal = ""
    for Nome, Valor in pairs(Table) do TextoFinal = TextoFinal .. Nome .. "    " end
    return TextoFinal
end

-- Lista um dictionary recebido
function TableUtils.ListarTableDictionaries(Table, Espacos)
    local TextoFinal = ""
    if Espacos == nil then Espacos = 0 end
    for Nome, Valor in pairs(Table) do
        if type(Valor) == "table" then
            TextoFinal = TextoFinal .. string.rep("    ", Espacos) .. Nome .. ":\n" .. TableUtils.ListarTableDictionaries(Valor, Espacos + 1)
        else
            TextoFinal = TextoFinal .. string.rep("    ", Espacos) .. Nome .. ": " .. Valor .. "\n"
        end
    end
    return TextoFinal
end

-- Retorna o valor total de pontos de atributos de um personagem
function TableUtils.SomarAtributos(Personagem)
    local SomaTotal = 0
    for _, Valor in pairs(Personagem.Atributos) do SomaTotal = SomaTotal + Valor end
    return SomaTotal
end

return TableUtils