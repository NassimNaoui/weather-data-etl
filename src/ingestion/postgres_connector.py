import airbyte as ab
import os


class PostgresConnector:

    def __init__(self, host, port, db_name, user, password):

        self.host = host
        self.port = port
        self.db_name = db_name
        self.user = user
        self.password = password

    def get_connexion(
        self,
    ):
        return ab.get_destination(
            "destination-postgres",
            config={
                "host": self.host,
                "port": int(self.port),
                "database": self.db_name,
                "username": self.user,
                "password": self.password,
                "schema": "airbyte_raw",
                "ssl_mode": {"mode": "disable"},
            },
        )
