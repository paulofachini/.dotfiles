# Use a imagem base do Ubuntu
FROM ubuntu:latest

# Evita prompts interativos durante a instalação de pacotes
ENV DEBIAN_FRONTEND=noninteractive

# Instala dependências mínimas para o script rodar
RUN apt-get update && apt-get install -y sudo git curl bash locales

# Cria um usuário de teste para simular um ambiente real
RUN useradd -m -s /bin/bash tester && echo "tester:tester" | chpasswd && adduser tester sudo

# Copia seus dotfiles para o diretório home do usuário de teste
COPY . /home/tester/.dotfiles

# Define o dono dos arquivos
RUN chown -R tester:tester /home/tester/.dotfiles

# Muda para o usuário de teste
USER tester
WORKDIR /home/tester

# Comando para executar o script de instalação quando o container iniciar
CMD ["/bin/bash", "-c", "chmod +x .dotfiles/scripts/install.sh && .dotfiles/scripts/install.sh && /bin/zsh"]
