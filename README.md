# 🌤️ Weather Data ELT

## 📖 Table of Contents
1. [Introduction](#introduction)
2. [Business Problem](#-business-problem)
3. [Quick Start with Docker](#-quick-start-with-docker)


## 📃 Introduction
**GreenAndCoop** is a green energy electricity supplier. Accurate weather forecasting is a strategic asset that helps the company to:

1. **Balance the Grid**: The company must ensure that production and consumption are perfectly balanced in real time to avoid heavy financial penalties.
2. **Optimize Production**: Renewable energy sources, such as solar and wind, are intermittent. By forecasting demand and weather conditions, the company can better plan its resource allocation and maximize production efficiency.
3. **Control Costs**: Accurate forecasting reduces the need for expensive last-minute electricity purchases on the wholesale market, leading to significant cost savings.

## 💼 Business Problem
To improve forecasting accuracy, the company's **Data Scientists** need to integrate new data sources into their prediction models. Specifically, they require high-resolution data from **semi-professional weather stations**.

As a **Data Engineer**, my role is to design, implement, and industrialize an **ELT pipeline** to Extract, Load, and Transform these new data streams.

### Data Sources
The pipeline ingests data from:
* [Infoclimat](https://www.infoclimat.fr/)
* [Weather Underground](https://www.wunderground.com/)

**Key Constraint:** These sources are updated frequently (every 10, 15, and 30 minutes), requiring a robust and automated ingestion process.

## 🛠 Quick Start with Docker

### Prerequisites
* [Docker](https://docs.docker.com/get-docker/) 
* [Docker Compose](https://docs.docker.com/compose/install/)

### 1. Clone the repository
```bash
git clone git@github.com:NassimNaoui/weather-data-etl.git
cd weather-data-etl
```

### 2. Setup Environment Variables
```bash
cp .env.example .env
```


### 3. Launch 
```bash
docker-compose up -d
```

### 🔧 Useful Commands
| Description | Command |
| :--- | :--- |
| View logs | `docker-compose logs -f` |
| Stop services | `docker-compose stop` |
| Remove containers and network | `docker-compose down` |
| Rebuild after code changes | `docker-compose up -d --build` |

### ⚙️ DBT Useful commands witch Docker
| Description | Command |
| :--- | :--- |
| Debug connections and project | `docker-compose exec dbt dbt debug --project-dir dbt_transformation` |
| Run all models | `docker-compose exec dbt dbt run --project-dir dbt_transformation` |
| Test data quality (schema & tests) | `docker-compose exec dbt dbt test --project-dir dbt_transformation` |
| Install project dependencies | `docker-compose exec dbt dbt deps --project-dir dbt_transformation` |
| Generate documentation | `docker-compose exec dbt dbt docs generate --project-dir dbt_transformation` |
| Launch documentation server | `docker-compose exec dbt dbt docs serve --port 8080 --host 0.0.0.0 --project-dir dbt_transformation` |

