from src.ingestion.file_connector import FileConnector
from sqlalchemy import create_engine
import pandas as pd


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

    def read_excel_files(self, url):

        xls = pd.ExcelFile(url)
        dfs = []
        for sheet_name in xls.sheet_names:
            df = pd.read_excel(xls, sheet_name=sheet_name)
            df = df.dropna()
            year = "20" + sheet_name[-2:]
            month = sheet_name[2:4]
            day = sheet_name[0:2]
            df["date"] = year + month + day
            dfs.append(df)

        return pd.concat(dfs)

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

            print(f"📥 Début de l'extraction de la source {file_id}")
            df = self.read_excel_files(url)

            print(f"📤 Écriture du DataFrame nettoyé vers Postgres...")
            df.to_sql(
                name=file_id.lower(),
                con=engine,
                schema=self.SCHEMA,
                if_exists="append",
                index=False,
            )

            print(f"✅ Ingestion réalisée avec succès!")
