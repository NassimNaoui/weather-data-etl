import airbyte as ab
import json


class FileConnector:

    def get_connexion(self, dataset_name, format, url, provider, reader_options=None):

        config = {
            "dataset_name": dataset_name,
            "format": format,
            "url": url,
            "provider": provider,
        }

        if reader_options:
            config["reader_options"] = json.dumps(reader_options)

        try:
            source = ab.get_source("source-file", config=config)
            print("🚀 Connexion validée.")
        except Exception as e:
            print("⚠️ Erreur de connexion : {e}")

        return source
