from src.ingestion.file_connector import FileConnector


class InfoClimatWorker:

    def __init__(self):
        self.connector = FileConnector()
        self.DATASET_NAME = "info_climat"
        self.FORMAT = "json"
        self.URL = "https://s3.eu-west-1.amazonaws.com/course.oc-static.com/projects/922_Data+Engineer/922_P8/Data_Source1_011024-071024.json"
        self.PROVIDER = {"storage": "HTTPS"}

    def run_pipeline(self, destination):
        # 1. Connexion à la source
        source = self.connector.get_connexion(
            self.DATASET_NAME, self.FORMAT, self.URL, self.PROVIDER
        )

        print(f"📥 Extraction de la source {self.DATASET_NAME} vers le cache local...")
        source.select_all_streams()

        print(f"📤 Transfert du cache vers Postgres...")

        destination.write(source.read(), write_strategy="replace")

        print(f"✅ Ingestion réalisée avec succès !")
