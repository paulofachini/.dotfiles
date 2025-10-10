# Use a imagem base do Ubuntu
FROM ubuntu:latest

# Evita prompts interativos durante a instalação de pacotes
ENV DEBIAN_FRONTEND=noninteractive
ENV DOCKER_CONTAINER=true

# Instala dependências mínimas para o script rodar
RUN apt-get update && apt-get install -y sudo git curl bash locales

# Cria um usuário de teste para simular um ambiente real
RUN useradd -m -s /bin/bash tester && echo "tester:tester" | chpasswd && adduser tester sudo
RUN echo 'tester ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Copia seus dotfiles para o diretório home do usuário de teste
COPY . /home/tester/.dotfiles

# Define o dono dos arquivos
RUN chown -R tester:tester /home/tester/.dotfiles

# Muda para o usuário de teste
USER tester
WORKDIR /home/tester

# Comando padrão: abre shell interativo após instalação
CMD ["/bin/bash", "-c", "chmod +x .dotfiles/scripts/install.sh .dotfiles/scripts/test.sh && .dotfiles/scripts/install.sh && .dotfiles/scripts/test.sh && /bin/zsh"]
