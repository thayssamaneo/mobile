# Documentação de Arquitetura e Modelagem de Persistência Local (Armazenamento Local)

Este documento descreve as decisões de modelagem de dados e o fluxo de persistência local utilizando o pacote `sqlfite` integrado ao ecossistema Flutter.

---

## 1. Mapeamento Objetivo-Relacional (ORM)

O `sqlfite` se comunica nativamente com dados estruturados na forma de pares de Linha/Coluna (`Map<String, dynamic>`). Abaixo, o diagrama ilustra o ciclo de vida e a transformação sofrida pelo dado desde a memória da aplicação (Objeto) até o disco de armazenamento (Tabela SQLite):

```mermaid

graph TD
    subgraph Memória Dart
        A[Instância da Classe Nota]
    end

    subgraph Serialização
        B["nota.toMap()"]
        C["Nota.fromMap(map)"]
    end

    subgraph Persistência SQLite
        D["Tabela: nota<br>Columns: id, titulo, conteudo"]
    end

    A -->|1. Transforma em Map| B
    B -->|2. Executa INSERT/UPDATE| D
    D -->|3. Executa QUERY retorna Map| C
    C -->|4. Instância Novo Objeto| A

```

**Modelagem de Entidade e Relacionamento (MER)**

O banco de dados SQLite armazena a estrutura da tabela utilizando restrições (constraints) e tipos primitivos de dados relacionais

```mermaid

erDiagram
    NOTA{
        INTEGER id PK "AUTOINCREMENT"
        TEXT titulo "NOT NULL"
        TEXT conteudo "NOT NULL"
    }

```