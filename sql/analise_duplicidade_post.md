Já entregou uma análise e descobriu depois que os dados estavam duplicados?

Antes do dashboard, antes do insight, tem uma pergunta básica que precisamos fazer:

> o dado é confiável?

Responder isso é fundamental, e um check importante em qualquer dataset é a duplicidade de chave primária. 

Mas antes, vale explicar o conceito: a chave primária (PK - *primary key*) é o que identifica unicamente cada linha da sua tabela. 

- Em uma tabela de pedidos -> é o id_pedido. 
- Em uma tabela agregada de pedidos por usuário e mês -> é o par usuário + mês (chave composta).

Sem isso bem definido, você nem sabe o que checar.

Com a PK definida, dois relatórios são muito úteis:

1. Resumo estatístico — quantas PKs estão duplicadas e qual o percentual do total. No exemplo do print, temos 0,0131% dos registros duplicados. É quase nada, mas cabe investigar melhor!

![Resultado da análise de duplicidade](assets/estats_duplicidade.png)

2. Investigação — quais são as linhas duplicadas e o que difere entre elas. Se a PK é a mesma, todos os campos deveriam ser iguais — quando não são, o campo divergente te dá a pista de onde está o problema. No mesmo dataset, fica claro que o motivo das duplicações é o campo `route_number.

![Investigacao de duplicidade](assets/invest_duplicacoes.png)

No link dos comentários tem o script completo em BigQuery — é só trocar o nome da tabela e a chave primária. 👇