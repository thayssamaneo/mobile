# SENAI CheckIn - Registro de ponto e diário de campo com foto e GPS

**Autor:** Thayssa Maneo
**Padrão Internacional:** ISO/IEC/IEEE 29148:2018
**Versão:** 1.0.0
**Data:** 17/09/2026

## 1. Introdução

### 1.1 Objetivo:

O projeto SENAI CheckIn tem como objetivo criar um aplicativo móvel para que cada visita de fiscalização e atendimento externo do SENAI seja validado com dados reais de localização e documentação visual. 

### 1.2 Funções do sistema:

Ao registrar a presença ou visita em campo o aplicativo deve permitir que o usuário:

1. Obtenha a localização geográfica exata por meio do GPS do dispositivo.
2. Capture uma foto do local, do colaborador ou da atividade com a câmera do dispositivo.
3. Registre os dados essenciais (data/hora, foto, latitude, longitude e observação) em um banco local SQLite.
4. Receba confirmação visual e sonora de que o registro foi salvo corretamente.

### 1.3 Páginas do aplicativo

**1. Cadastro de Registro:** Tela para o cadastro das visitas com data/hora, foto, latitude, longitude e observação.

**2. Lista de Registro:** Tela para visualização dos registros feitos.

**3. Detalhes do item:** Tela para visualização dos detalhes do registro feito.

### 1.4 Bibliotecas utilizadas:

1. GPS (GeoLocator)
2. Câmera (image_picker)
3. SQLite (sqflite)

## 2. Requisitos do sistema

### 2.1 Requisitos funcionais

Os requisitos funcionais são aqueles que descrevem as funções que o sistema deve realizar.

| ID | Requisito | Descrição |
| --- | --- | --- |
| RF-01 | Registrar visita | O sistema deve permitir que o usuário registre uma visita. |
| RF-02 | Registrar atividade | O sistema deve permitir que o usuário registre uma atividade. |
| RF-03 | Capturar foto | O sistema deve permitir que o usuário capture uma foto. |
| RF-04 | Obter localização | O sistema deve permitir que o usuário obtenha a localização geográfica exata. |
| RF-05 | Registrar observação | O sistema deve permitir que o usuário registre uma observação. |
| RF-06 | Salvar registro | O sistema deve permitir que o usuário salve um registro. |
| RF-07 | Enviar registro | O sistema deve permitir que o usuário envie um registro. |
| RF-08 | Receber confirmação | O sistema deve permitir que o usuário receba confirmação de que o registro foi salvo corretamente. |

### 2.2 Requisitos não funcionais

Os requisitos não funcionais são aqueles que descrevem as características que o sistema deve ter.

| ID | Requisito | Descrição |
| --- | --- | --- |
| RNF-01 | Desempenho | O sistema deve ser capaz de registrar presença em até 5 segundos. |
| RNF-02 | Confiabilidade | O sistema deve ser capaz de registrar presença mesmo sem conexão com a internet. |
| RNF-03 | Usabilidade | O sistema deve ser capaz de registrar presença com até 3 cliques. |
| RNF-04 | Segurança | O sistema deve ser capaz de registrar presença com segurança. |
| RNF-05 | Portabilidade | O sistema deve ser capaz de registrar presença em diferentes dispositivos. |
| RNF-06 | Manutenibilidade | O sistema deve ser capaz de registrar presença com manutenibilidade. |

## 3. Diagramas

### 3.1 Diagrama de Classes UML

### 3.2 Diagrama de Casos de Uso