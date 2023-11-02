# ASMLIB16
Biblioteca assembly arquitetura 8086 com jogo de breakout

!['Tela do jogo'](breakout.png)

# Atenção:

Para rodar o jogo de breakout, não é necessário sistema operacional, dado que, o jogo foi feito em assembly 8086 e dá instruções diretamente ao BIOS.
Para funcionar, o computador utilizado para testar, deve ser compatível com a família de processadores x86.

# Como testar?

As imagens de diskette e pendrive/hd foram disponibilizadas como release ou podem ser encontradas na raiz deste repositório com os nomes:

>> pendrive.img
  
>> floppy.img

# Instalar e rodar no pendrive ou hd

Você pode gravar a imagem "pendrive.img" em um pendrive ou hd. Neste caso, esteja ciente de que o dispositivo terá o MBR (setor de boot mestre) apagado e reescrito.
Após gravar a imagem num pendrive ou hd, basta dar o boot pelo dispositivo e o jogo é iniciado.

# Instalar e rodar no diskette

A versão diskette é semelhante a do pendrive, basta gravar a imagem "floppy.img" no diskete que, após isto, o diskette também tem o MBR reescrito e, então, 
basta dar o boot pelo diskete para o jogo ser iniciado.

# Rodar com QEMU

O QEMU é um emulador de computador que pode simular o fucionamento de um computador, permitindo que se dê o boot a partir de uma imagem do dispositivo.

Para rodar a imagem de pendrive, com o qemu instalado, basta rodar o seguinte comando:

```
qemu-system-x86_64 -m 4096 "caminho da imagem do pendrive"/pendrive.img
```

Exemplo, caso o arquivo de pendrive esteja na pasta "C:\", basta executar como segue:

```
qemu-system-x86_64 -m 4096 C:\pendrive.img
```
