# Etapa 1: Usar uma imagem oficial do Python como imagem base.
# python:3.11-slim é uma boa escolha por ser leve.
FROM python:3.11-slim

# Etapa 2: Definir o diretório de trabalho dentro do contêiner.
WORKDIR /app

# Etapa 3: Copiar o arquivo de dependências para o diretório de trabalho.
# Copiamos este arquivo primeiro para aproveitar o cache de camadas do Docker.
# A instalação das dependências só será executada novamente se este arquivo mudar.
COPY requirements.txt .

# Etapa 4: Instalar as dependências.
RUN pip install --no-cache-dir -r requirements.txt

# Etapa 5: Copiar o restante do código da aplicação.
COPY . .

# Etapa 6: Expor a porta em que o aplicativo será executado.
EXPOSE 8000

# Etapa 7: Definir o comando para executar a aplicação com o Uvicorn.
# "app:app" refere-se ao objeto 'app' no arquivo 'app.py'.
# --host 0.0.0.0 torna a aplicação acessível de fora do contêiner.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]