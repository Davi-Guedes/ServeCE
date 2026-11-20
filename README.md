# ServeCE
ServeCE é um marketplace web/móvel (HTML/CSS/JS e Node.js) para conectar profissionais autónomos a clientes em Sobral-CE, através de perfis e sistema de avaliações. Projeto desenvolvido para a disciplina de Engenharia de Software da UFC-Sobral.

## Estrutura inicial do projeto

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
│   │   ├── requests/
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

## Tecnologia backend

- Node.js 20 ou superior
- Express
- MySQL 8
- mysql2
- Zod para validação
- JWT em cookies HTTP-only
- bcrypt para senhas
- Jest e Supertest para testes

O backend seguirá o padrão de monólito modular:

```text
HTTP -> routes -> controller -> service -> repository -> MySQL
```

Cada integrante poderá trabalhar principalmente em seu módulo, sem alterar os arquivos dos demais. Arquivos compartilhados devem ser modificados em tarefas separadas e revisadas pela equipe.
