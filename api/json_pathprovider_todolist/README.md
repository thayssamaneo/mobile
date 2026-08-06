# Json_pathprovider_todolist

Criação de um aplicativo que permite o cadastro de usuários e tarefas por usuário.

O diferencial da tarefa é que em vez de salvar apenas uma lista de tarefas, usaremos um JSON que será um objeto(Ma/Dicionário), onde a chave é o nome do usuário e o valor é a lista de tarefas

## A estrutura do JSON

```json
{
    "João":[
        {"titulo": "Estudar Flutter", "concluida": false},
        {"titulo": "Fazer compras", "concluida": true},
    ],
    "Maria":[
        {"titulo": "Ler livro", "concluida": false},
        {"titulo": "Comprar pão", "concluida": true},
    ]
}
```