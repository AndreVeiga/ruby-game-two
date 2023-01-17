def da_boas_vindas
  puts "Olá, qual o seu nome"
  nome = gets.strip
end

def quer_parar?
  puts "Quer jogar novamente? (S/N)"
  resposta = gets.strip
  resposta.upcase != "S" 
end

def cabecalho_de_tentativas erros, chutes, mascara
  puts "\n\n\n"
  puts "Palavra: #{mascara}"
  puts "Erros: #{erros}"
  puts "Chutes: #{chutes}"
end

def pede_um_chute
  puts "Qual o seu chute?"
  chute = gets.strip
end

def ganhou pontos, palavra_secreta
  puts "PARABÉNS! Você ganhou!"
  puts "A palavra secreta era #{palavra_secreta}"
  puts "Você terminou com #{pontos} pontos."
end

def tente_novamente
  puts "Que pena! Tente novamente."
end

def avisa_chute_efetuado chute
  puts "Ops! Você já chutou #{chute}"
end

def avisa_letra_nao_encontrada
  puts "Você errou a letra!"
end

def avisa_letra_encontrada total_encontrado
  puts "Letra encontrada #{total_encontrado} vezes!"
end

def avisa_tamanho_palavra_secreta tamanho
  puts "Palavra secreta com #{tamanho} letras. Boa sorte!"

end

def mostra_forca chutes, palavra
  puts "\n\n\n"
  for caractere in palavra.chars
    if chutes.include? caractere
      print caractere
    else 
      print " _ "
    end
  end

  puts "\n\n"
end

def avisa_pontos_totais pontos_totais
  puts "Seu total de pontos foi #{pontos_totais}"

end

def mostra_campeao dados
  puts "O atual campeão é o #{dados[0]} com #{dados[1]} pontos."
end