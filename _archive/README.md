# BigQuery Analytics SQL

Repositório com exemplos práticos de SQL para analytics utilizando BigQuery e datasets públicos do Google Cloud.

O objetivo é compartilhar padrões práticos de SQL e analytics para profissionais de growth, produto e business analytics, cobrindo temas como modelagem de dados, qualidade de dados, experimentação, ecommerce/marketplace e democratização de dados.

## Stack

- Google BigQuery
- Google Colab
- Python (setup e execução das queries)
- GitHub

## Estrutura do repositório

```text
bigquery-analytics-sql/
├── notebooks/          # notebooks Colab (.ipynb)
├── README.md
└── .gitignore
```

## Como executar os notebooks

### Pré-requisitos

- possuir uma conta Google;
- possuir acesso ao [Google Colab](https://colab.research.google.com/);
- criar um [projeto no Google Cloud](https://console.cloud.google.com/);
- habilitar a [BigQuery API](https://console.cloud.google.com/apis/library/bigquery.googleapis.com);
- possuir permissões para executar queries no BigQuery.

### Configuração

Crie uma secret no Colab com o nome:

```text
GCP_PROJECT_ID
```

e defina como valor o ID do seu projeto no Google Cloud.

No Colab:

```text
Chaves (ícone de chave na barra lateral) → Secrets → adicione GCP_PROJECT_ID
```

A autenticação é feita via OAuth da conta Google utilizada no notebook.

Nunca commite credenciais no repositório (`*.json`, service accounts, tokens etc.).

### Execução

1. Abra o notebook desejado no Colab.
2. Configure a secret `GCP_PROJECT_ID`.
3. Execute as células em ordem.

Os notebooks podem ser abertos diretamente no Google Colab através dos links presentes em cada arquivo `.ipynb`.

## Datasets utilizados

Os exemplos utilizam datasets públicos do BigQuery, como:

- `bigquery-public-data`
- `thelook_ecommerce`
- `google_analytics_sample`

## Custos e limites

Datasets públicos do BigQuery podem ser consultados sem armazenar os dados no seu projeto, mas o processamento da query é cobrado (ou consome cota gratuita) no projeto que executa o job.

Consulte a documentação oficial de preços e free tier do BigQuery antes de executar queries muito grandes.