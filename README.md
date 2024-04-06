# WS Work - Carros

## Descrição

Este aplicativo Flutter foi desenvolvido como parte do processo seletivo para a posição de desenvolvedor na WS Work. Ele exibe uma lista de carros obtida de um JSON através de uma requisição HTTP, permite que os usuários expressem interesse por um carro, salva esses leads em um banco de dados SQLite interno e envia periodicamente esses leads para um endpoint específico.

## Funcionalidades

- **Listagem de Carros**: Carrega uma lista de carros a partir de um JSON fornecido, oferecendo uma visualização dinâmica das opções disponíveis.
- **Registro de Interesse (EU QUERO)**: Usuários podem selecionar carros e registrar seu interesse, o qual é armazenado internamente.
- **Armazenamento de Leads**: Os leads gerados são armazenados em um banco de dados SQLite local.
- **Envio Automatizado de Leads**: Uma rotina automatizada envia os leads para um endpoint específico de forma periódica. (Nota: a funcionalidade de envio está atualmente mockada para fins de demonstração.)

## Tecnologias Utilizadas

- **Flutter**: Usado para o desenvolvimento da aplicação multiplataforma.
- **Dio**: Para gerenciamento de requisições HTTP de maneira simples e eficaz.
- **Sqflite**: Para armazenamento local de dados no SQLite.
- **Workmanager**: Utilizado para agendar tarefas em background, como o envio periódico de leads.
- **Lottie**: Adiciona animações complexas no app a partir de arquivos JSON, enriquecendo a experiência do usuário.
- **ScreenUtils**: Assegura que a UI do app se adapte corretamente a diferentes tamanhos e resoluções de tela.

## Decisões Técnicas

As escolhas tecnológicas, como o uso de Lottie para animações e ScreenUtils para responsividade, foram feitas visando melhorar a experiência do usuário e garantir uma interface bonita e funcional em diversos dispositivos. A mockagem do envio de leads foi uma decisão baseada nas diretrizes fornecidas durante o processo seletivo, permitindo focar na lógica e estrutura do aplicativo enquanto considera a integração com sistemas externos de forma escalável.

## Instalação e Uso

```bash
# Clone este repositório
git clone <url-do-repositorio>

# Entre no diretório do projeto
cd nome-do-app

# Instale as dependências
flutter pub get

# Execute o aplicativo
flutter run
```

## Agradecimentos

Gostaria de agradecer pela oportunidade do processo seletivo, na qual o aplicativo apesar de ser simples, explora muitas técnicas e implementações. Espero que gostem! :)
