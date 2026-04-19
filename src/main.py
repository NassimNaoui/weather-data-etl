from src.ingestion.info_climat import InfoClimatWorker
from src.ingestion.weather_underground import WeatherUndergroundWorker
from src.ingestion.postgres_connector import PostgresConnector
from dotenv import load_dotenv
from pathlib import Path
import os


# Chemin vers le script (src/main.py)
script_path = Path(__file__).resolve()

# Dossier parent du script (src/)
SRC_DIR = script_path.parent

# Dossier parent de src (La racine du projet)
ROOT_DIR = SRC_DIR.parent

# On cherche le .env à la racine
DOTENV_PATH = ROOT_DIR / ".env"

load_dotenv(dotenv_path=DOTENV_PATH)


def main():
    host = os.getenv("POSTGRES_HOST")
    port = os.getenv("POSTGRES_PORT")
    db_name = os.getenv("POSTGRES_DB_NAME")
    user = os.getenv("POSTGRES_USER")
    password = os.getenv("POSTGRES_PASSWORD")

    info_climat_source = InfoClimatWorker()
    weather_underground_source = WeatherUndergroundWorker()

    postgres_connector = PostgresConnector(host, port, db_name, user, password)
    destination = postgres_connector.get_connexion()
    destination.check()

    # Ingestion Info climat
    info_climat_source.run_pipeline(destination)

    # Ingestion Weather Underground
    weather_underground_source.run_pipeline(postgres_connector)


main()
