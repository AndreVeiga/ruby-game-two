require_relative "ui"
require_relative "rank"

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
  texto = File.read "dicionario.txt"
  palavras = texto.split "\n"
  
  index = rand(palavras.size)

  palavra_secreta = palavras[index].upcase
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
    chute_do_usuario = pede_um_chute
    chute = chute_do_usuario.upcase

    if chutes.include? chute
      avisa_chute_efetuado chute
    else
      return chute
    end
  end
end

def ja_ganhou? chutes, palavra_secreta
  mascara = palavra_mascarada chutes, palavra_secreta
  mascara == palavra_secreta
end

def jogar nome
  palavra_secreta = escolhe_palavra_secreta
  erros = 0
  chutes = []
  pontos_por_palavra_acertada = 100
  pontos_por_letra_acertada = 10
  pontos_por_letra_errada = 30
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
        pontos += pontos_por_letra_acertada
        avisa_letra_encontrada total_encontrado
      end
    else
      if chute == palavra_secreta
        pontos+= pontos_por_palavra_acertada
        ganhou pontos, palavra_secreta
        return pontos
      end

      tente_novamente
      pontos-= pontos_por_letra_errada
      erros+= 1
    end

    if ja_ganhou? chutes, palavra_secreta
      ganhou pontos, palavra_secreta
      return pontos
    end

  end
end

def jogo_da_forca
  nome = da_boas_vindas
  pontos_totais = 0

  dados = le_rank
  mostra_campeao dados

  loop do
    pontos_totais += jogar nome
    
    avisa_pontos_totais pontos_totais

    salvar_rank nome, pontos_totais if pontos_totais > dados[1].to_i

    break if quer_parar?
  end
end