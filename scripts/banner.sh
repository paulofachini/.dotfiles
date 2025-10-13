#!/usr/bin/env bash
# ============================================================================================
# 
#      _     _    __ _ _        
#   __| |___| |_ / _(_) |___ ___
#  / _` / _ \  _|  _| | / -_|_-<
#  \__,_\___/\__|_| |_|_\___/__/
#  
#       __     __  ____ __      
#   ___/ /__  / /_/ _(_) /__ ___
#  / _  / _ \/ __/ _/ / / -_|_-<
#  \_,_/\___/\__/_//_/_/\__/___/
# 
#       _       _    __ _ _           
#      | |     | |  / _(_) |          
#    __| | ___ | |_| |_ _| | ___  ___ 
#   / _` |/ _ \| __|  _| | |/ _ \/ __|
#  | (_| | (_) | |_| | | | |  __/\__ \
#   \__,_|\___/ \__|_| |_|_|\___||___/
#
#         __      __  _____ __         
#    ____/ /___  / /_/ __(_) /__  _____
#   / __  / __ \/ __/ /_/ / / _ \/ ___/
#  / /_/ / /_/ / /_/ __/ / /  __(__  ) 
#  \__,_/\____/\__/_/ /_/_/\___/____/  
#
#
#        ░██               ░██        ░████ ░██░██                       
#        ░██               ░██       ░██       ░██                       
#  ░████████  ░███████  ░████████ ░████████ ░██░██  ░███████   ░███████  
# ░██    ░██ ░██    ░██    ░██       ░██    ░██░██ ░██    ░██ ░██        
# ░██    ░██ ░██    ░██    ░██       ░██    ░██░██ ░█████████  ░███████  
# ░██   ░███ ░██    ░██    ░██       ░██    ░██░██ ░██               ░██ 
#  ░█████░██  ░███████      ░████    ░██    ░██░██  ░███████   ░███████  
#
# =================================================================================================================

RED='\033[38;5;196m'
ORANGE='\033[38;5;202m'
YELLOW='\033[38;5;226m'
GREEN='\033[38;5;46m'
BLUE='\033[38;5;51m'
VIOLET='\033[38;5;93m'
MAGENTA='\033[38;5;201m'
CYAN='\033[38;5;51m'
RESET='\033[0m'
BOLD='\033[1m'

print_text() {
  DOTFILE="${RED}d${ORANGE}o${YELLOW}t${GREEN}f${BLUE}i${VIOLET}l${RED}e${RESET}"
  printf "${GREEN}...is now configured!${RESET}\n\n"
  printf "Before you code, take a look at your ${YELLOW}.zshrc${RESET} to tune aliases, plugins and environment.\n\n"
  printf "• Repo: ${CYAN}https://github.com/paulofachini/${DOTFILE}${RESET}\n"
  printf "• Blog: ${CYAN}https://paulofachini.dev.br${RESET}\n"
  printf "• Follow: ${CYAN}https://github.com/paulofachini${RESET}\n\n"
  printf "✨ ${GREEN}Enjoy your terminal!${RESET}\n\n"
}

print_dotfiles() {
  printf "\n"
  printf "${RED}      _     ${ORANGE}     ${YELLOW} _    ${GREEN}  __  ${BLUE} _   _ ${VIOLET}       ${MAGENTA}      \n"
  printf "${RED}     | |    ${ORANGE}     ${YELLOW}| |   ${GREEN} / _| ${BLUE}(_) | |${VIOLET}       ${MAGENTA}      \n"
  printf "${RED}   __| |   _${ORANGE}__   ${YELLOW}| |_  ${GREEN}| |_  ${BLUE} _| | |${VIOLET}  ___  ${MAGENTA} ___  \n"
  printf "${RED}  / _  |  / ${ORANGE}_ \  ${YELLOW}| __| ${GREEN}|  _| ${BLUE}| | | |${VIOLET} / _ \ ${MAGENTA}/ __| \n"
  printf "${RED} | (_| | | (${ORANGE}_) | ${YELLOW}| |_  ${GREEN}| |   ${BLUE}| | | |${VIOLET}|  __/ ${MAGENTA}\__ \ \n"
  printf "${RED}  \____|  \_${ORANGE}__/  ${YELLOW}\___| ${GREEN}|_|   ${BLUE}|_| |_|${VIOLET} \___| ${MAGENTA}|___/ \n"
  printf "\n"
}

print_dotfiles
print_text
