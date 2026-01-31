# Manutenção e Lista de pacotes instalados no ArchLinux

- Cobrir os comandos essenciais para:

Identificar pacotes AUR (pacman -Qm, yay -Qm)
Verificar origem/repositório (pacman -Qi, pacman -Sl)
Listar todos os pacotes (yay -Q)
Gerenciar pacotes extras (pacman -Qe, pacman -Qdt)

```ini
pacman -Qm                	                  # Lista pacotes "foreign" (não oficiais, geralmente AUR)
pacman -Qm | awk '{print $1}'                 # Mostra apenas os nomes dos pacotes AUR
pacman -Qm | wc -l        	                  # Conta quantos pacotes AUR estão instalados
yay -Qm                   	                  # Lista pacotes AUR usando o helper yay
yay -Qm --aur             	                  # Lista pacotes instalados especificamente via AUR
pacman -Qi nome-do-pacote | grep Repository   # Mostra o repositório de origem de um pacote
pacman -Sl | grep installed   	              # Lista todos os pacotes com seus repositórios oficiais
yay -Sl | grep installed   	                  # Lista todos os pacotes com seus repositórios oficiais + AUR
yay -Q                    	                  # Lista todos os pacotes instalados (oficiais + AUR)
yay -Qi nome-do-pacote    	                  # Mostra detalhes do pacote, incluindo origem
pacman -Qe                	                  # Lista pacotes instalados explicitamente pelo usuário
pacman -Qdt               	                  # Lista pacotes órfãos (dependências não mais necessárias)
```
- Comandos de manutenção mais usados:
```ini
sudo pacman -Syu          # Atualiza todos os pacotes do sistema
sudo pacman -Rns pacote   # Remove um pacote junto com dependências não usadas
```
- Comandos de manutenção de cache
```ini
sudo pacman -Sc           # Remove pacotes antigos do cache, mantendo apenas a versão atual
sudo pacman -Scc          # Limpa todo o cache (precisa confirmar duas vezes)
sudo paccache -r          # Remove todas as versões antigas, mantendo as 3 mais recentes (via pacote pacman-contrib)
sudo paccache -rk1        # Mantém apenas 1 versão mais recente de cada pacote
sudo paccache -ruk0       # Remove todas as versões antigas e desinstaladas
```
- Comandos para diagnósticos
```ini
pacman -Qs termo           # Pesquisa pacotes instalados que correspondem ao termo
pacman -Ql nome-do-pacote  # Lista todos os arquivos instalados por um pacote
```
