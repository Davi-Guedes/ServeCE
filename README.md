# ServeCE

ServeCE é um marketplace web para conectar profissionais autônomos a clientes em Sobral-CE por meio de perfis, serviços e avaliações.

Projeto desenvolvido para a disciplina de Engenharia de Software da UFC-Sobral.

## Tecnologias

- Frontend: HTML, CSS e JavaScript
- Backend: Node.js e Express
- Banco de dados: MySQL 8
- Testes: Jest e Supertest

## Pré-requisitos

- Node.js 20 ou superior
- npm
- MySQL 8 ou superior
- Git

## Como preparar o ambiente

```bash
git clone https://github.com/Davi-Guedes/ServeCE.git
cd ServeCE
git checkout feature/banco-de-dados
```

Configure o MySQL executando os scripts da pasta `database/` nesta ordem:

1. `database/01_schema.sql`
2. `database/02_seed.sql`

Consulte o [guia do banco](/C:/Users/Davi/Desktop/ServeCE/database/README.md) para o procedimento no MySQL Workbench.

## Estrutura do projeto

```text
ServeCE/
├── backend/
│   ├── src/
│   │   ├── app.js
│   │   ├── server.js
│   │   ├── config/
│   │   ├── common/
│   │   │   ├── middlewares/
│   │   │   ├── errors/
│   │   │   └── validators/
│   │   ├── auth/
│   │   ├── users/
│   │   ├── profiles/
│   │   ├── categories/
│   │   ├── services/
│   │   ├── contracts/
│   │   ├── reviews/
│   │   └── admin/
│   ├── tests/
│   ├── package.json
│   └── .env.example
├── frontend/
│   ├── assets/
│   ├── css/
│   ├── js/
│   └── pages/
└── database/
    ├── 01_schema.sql
    ├── 02_seed.sql
    └── README.md
```

Busca e filtros serão implementados no módulo `services`. Categorias e usuários são módulos auxiliares necessários pelas entidades do banco.

## Arquitetura backend

O backend seguirá um monólito modular:

```text
HTTP -> routes -> controller -> service -> repository -> MySQL
```

Cada integrante trabalhará principalmente em seu módulo. Arquivos compartilhados devem ser modificados em tarefas separadas e revisadas pela equipe.

## Convenção de commits

Use prefixos no padrão Conventional Commits:

- `feat:` nova funcionalidade
- `fix:` correção
- `docs:` documentação
- `chore:` configuração ou manutenção
- `test:` testes
- `refactor:` refatoração sem mudança de comportamento
- `style:` formatação

Exemplo:

```bash
git commit -m "feat: cadastrar usuário"
```

## Fluxo de trabalho

1. Atualize a branch principal.
2. Crie uma branch a partir da branch principal.
3. Faça commits pequenos e objetivos.
4. Abra um Pull Request.
5. Solicite revisão de pelo menos um integrante.
6. Não faça push direto para a branch principal.

## Segurança e arquivos locais

- Nunca envie senhas, tokens ou arquivos `.env`.
- Use apenas dados fictícios para desenvolvimento.
- Alterações no banco devem ser feitas nos scripts versionados, não diretamente no MySQL Workbench.
