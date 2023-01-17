require_relative "ui"

def palavra_mascarada chutes, palavra
  mascara = ""
  for caractere in palavra.chars
    if chutes.include? caractere
      mascara << caractere
    else 
      mascara << " _ "
    end
  end
  mascara
end

def escolhe_palavra_secreta
  palavra_secreta = "teste"
  avisa_tamanho_palavra_secreta palavra_secreta.size
  palavra_secreta
end

def eh_letra? data
  data.size == 1 
end

def conta palavra, letra
  total_encontrado = 0
  for caractere in palavra.chars
    total_encontrado += 1 if caractere == letra
  end

  total_encontrado
end

def pede_um_chute_valido chutes, erros, palavra_secreta, mascara
  cabecalho_de_tentativas erros, chutes, mascara

  loop do
    chute = pede_um_chute 
    if chutes.include? chute
      avisa_chute_efetuado chute
    else
      return chute
    end
  end
end

def jogar nome
  palavra_secreta = escolhe_palavra_secreta
  erros = 0
  chutes = []
  pontos = 0
  vidas = 5

  while erros < vidas
    mascara = palavra_mascarada chutes, palavra_secreta
    chute = pede_um_chute_valido chutes, erros, palavra_secreta, mascara

    chutes << chute

    if eh_letra? chute
      total_encontrado = conta palavra_secreta, chute # palavra_secreta.count chute
      if total_encontrado == 0
        avisa_letra_nao_encontrada
        tente_novamente
        erros += 1
      else
        avisa_letra_encontrada total_encontrado
      end
    else
      if chute == palavra_secreta
        pontos+= 100
        ganhou pontos
        break
      end

      tente_novamente
      pontos-= 30
      erros+= 1
    end
  end
end

def jogo_da_forca
  nome = da_boas_vindas

  loop do
  jogar nome
  break if quer_parar?
  end
end