FROM python:3.11-slim

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

RUN apt-get update && apt-get install -y \
    curl \
    libpq-dev \
    gcc \
    git \
    docker.io \
    && rm -rf /var/lib/apt/lists/*

ENV POETRY_HOME="/opt/poetry"
RUN curl -sSL https://install.python-poetry.org | python3 -
ENV PATH="$POETRY_HOME/bin:$PATH"

WORKDIR /usr/app

# 1. Copie d'abord TOUS les fichiers de config
COPY pyproject.toml poetry.lock* README.md* ./

# 2. L'astuce : On dit à Poetry de ne pas installer le projet lui-même (--no-root)
# Cela évite qu'il cherche un dossier source qui n'est pas encore copié.
RUN poetry config virtualenvs.create false \
    && poetry install --no-interaction --no-ansi --only main --no-root

# 3. Maintenant on copie le reste du code
COPY . .

ENTRYPOINT ["tail", "-f", "/dev/null"]