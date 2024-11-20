class Constants {
  static String accessToken = 'access_token';
  static String dbName = 'local';
  static String categoriesQuery =
      'CREATE TABLE categories (id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT NOT NULL,created_at TEXT,updated_at TEXT,is_synced INTEGER DEFAULT 0);';
}
