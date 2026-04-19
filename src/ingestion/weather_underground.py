from src.ingestion.file_connector import FileConnector
from sqlalchemy import create_engine


class WeatherUndergroundWorker:

    def __init__(self):

        self.connector = FileConnector()
        self.urls = [
            "https://s3.eu-west-1.amazonaws.com/course.oc-static.com/projects/922_Data+Engineer/922_P8/Weather+Underground+-+Ichtegem%2C+BE.xlsx",
            "https://s3.eu-west-1.amazonaws.com/course.oc-static.com/projects/922_Data+Engineer/922_P8/Weather+Underground+-+La+Madeleine%2C+FR.xlsx",
        ]

        self.FORMAT = "excel"
        self.PROVIDER = {"storage": "HTTPS"}
        self.READER_OPTIONS = {"header": 0, "skiprows": 1}
        self.SCHEMA = "airbyte_raw"

    def run_pipeline(self, destination_config):

        sql_host = (
            "localhost"
            if destination_config.host == "host.docker.internal"
            else destination_config.host
        )

        # Création d'un moteur SQL classique pour Pandas avec sql_host
        db_url = f"postgresql://{destination_config.user}:{destination_config.password}@{sql_host}:{destination_config.port}/{destination_config.db_name}"
        engine = create_engine(db_url)

        for url in self.urls:
            file_id = "weather_underground_" + url.split("/")[-1][-7:-5]

            source = self.connector.get_connexion(
                file_id.lower(),
                self.FORMAT,
                url,
                self.PROVIDER,
                self.READER_OPTIONS,
            )

            print(f"📥 Début de l'extraction de la source {file_id}")
            source.select_all_streams()
            read_result = source.read()

            # Extraction et Transformation
            df = read_result.cache.get_pandas_dataframe(file_id)
            df = df.dropna()

            print(f"📤 Écriture du DataFrame nettoyé vers Postgres...")
            df.to_sql(
                name=file_id.lower(),
                con=engine,
                schema=self.SCHEMA,
                if_exists="replace",
                index=False,
            )

            print(f"✅ Ingestion réalisée avec succès!")
