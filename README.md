# Text-Dungeon
Projeto compartilhado com alunos para uma aventura RPG baseada em texto feita em LUA

# Esse é um teste
Isso é apenas um exemplo de modificação para a branch principal

# Alunos
print("Voce ta no beco, possui 50 reais no bolso. Quer comprar maconha?")
larica = io.read(l)
if larica == "sim" then
    print("voce compra maconha"); print("voce se droga")
elseif larica == "nao" then
    print("voce nao compra maconha"); print("um noia te rouba"); print("quer reagir?")
    marola = io.read(l)
    if marola == "sim" then
        print("voce e baleado"); print("voce morreu")
    elseif marola == "nao" then
        print("voce perde a grana"); print("voce sai com vida")
    end
end
