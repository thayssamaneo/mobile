# Resumo da aula de hoje 27/01/2026

Hoje nós preparamos o ambiente inicial que será utilizado nas próximas aulas.

Criamos um perfil de usuário nos computadores e demos a ele permissão de administrador.

Conectamos nosso computador com o git e com o github para que nossos arquivos fiquem salvos na nuvem em várias versões sem substituir a anterior.

Comandos utilizados no git para conexão:

    - git config --global user.email "emailaqui"
    - git config --global user.name "nomeaqui"
    - git config --list

Também criamos perfis no vscode e utilizamos o terminal do vscode para criar pastas no computador e usá-las nas aulas futuramente.

Comandos para criar as pastas:

    - cd .\pasta --> abre um diretório
    - mkdir nomepastanova --> cria novas pastas
    - dir --> ver pastas na pasta atual
    - type nul > README.md --> Cria arquivo readme

## Introdução ao desenvolvimento Mobile

### Tipo de desenvolvimento

- Nativo
    - Android:
        - SDK --> Android SDK
        - IDE --> Android Studio
        - Linguagens --> Kotliin e Java
        - Ambientes --> Mac, Windows e Linux

    - Ios:
        - SDK --> Cocoa touch
        - IDE --> Xcode
        - Linguagens --> Swift / Objectype-C
        - Ambientes --> Mac

- Multiplataforma
    - React Native:
        - SDK --> Node.js
        - IDE --> VSCode e outras 
        - Linguagens --> JavaScript e TypeScript
        - Ambientes --> Mac, Windows, Linux
    
    - Flutter:
        - SDK --> Flutter SDK
        - IDE --> VSCode, Android Studio
        - Linguagens --> Dart
        - Ambientes --> Mac, Windows, Linux

## Preparação do ambiente de desenvolvimento

### Instalação do FlutterSDK

- Download do arquivo zip na página flutter.dev
- Inclusão do flutter na pasta c:\src
- Inclusão do flutter\bin nas variáveis de ambiente
- Teste o flutter --version

### Instalação do AndroidSDK

- Download do Android SDK - Command Line Tools
- Adicionar o Command-line ao c:\src\AndroidSDK
- Adicionar o SDKManager as variáveis de ambiente
- Download dos pacotes:
    - Emulador
    - Platforms
    - Platforms-tools
    - Build-tools
- Adicionar ADB e o Emulador nas variáveis de ambiente
- Criação da imagem do emulador - via sdkmanager
- Build do emulador - via sdkmanager

### Criação de projetos e códigos da linha de comando

- Criação de projetos
    - `flutter create <nome_do_app>`
        - Flags:
            - --empty: cria um aplicativo "vazio"(hello world!)
            - --platforms: permite a seleção de uma plataforma de desenvolvimento
                - ex: `--platforms=android` (a criação do projeto será somente para a plataforma android)
    - Exemplo de criação de uma aplicação android vazio
        - `flutter create nome_app --empty --platforms=android`
        - OBS: nome do aplicativo: todas as letras minúsculas, separação de palavras com "_";
    - `Flutter doctor`
        - Permite correção de pequenos problemas no flutter e identificação dos parâmetros funcionais em relação as plataformas de desenvolvimento
        - Sempre rodar o `flutter doctor` no começo do desenvolvimento
    - `flutter clean`
        - Limpa o cache do build (apaga o apk anterior)
    - `flutter run -v`
        - Build do app (apk) 

- Gerenciamento de dependências do PubSpec()
    - **Instalação**
        - `fluter pub add nome_dependencia`
    - **Baixar e instalar dependências projetadas**
        - `flutter pub get`
    - **Outros comandos do flutter pub(dependências)**
        - `fluter pub outdated` --> verifica se as dependências estão atualizadas
        - `flutter pub upgrade` --> atualiza as dependências do flutter pub

### Estrutura de um aplicativo

#### A hierarquia de árvore

Gráfico com demonstração da hierarquia

```mermaid
grafh BT 

    MA['MaterialApp']
    STL['StateLess Widget']
    STF['StateFull Widget']
    SC['Scaffold']
    ABar['AppBar']
    BD['Body']
    BNBar['BottonNavigationBar']
    DW['Drawer']
    FAB['FloatActionButton']
    SB['SnackBar']

    MA --> STL & STF
    STF & STL --> SC
    SC --> ABar & BD & BNBar & DW & FAB & SB
```