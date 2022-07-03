require 'sqlite3'

db = SQLite3::Database.open 'tmp/shoe_store.db'
db.execute("CREATE TABLE IF NOT EXISTS stores (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT UNIQUE
);")

db.execute("CREATE TABLE IF NOT EXISTS shoe_models (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT UNIQUE
);")

db.execute("CREATE TABLE IF NOT EXISTS inventories (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  store_id INT,
  shoe_model_id INT,
  qnty INT,
  UNIQUE(store_id, shoe_model_id)
);")

db.execute("CREATE TABLE IF NOT EXISTS inventory_configs (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  store_id INT,
  shoe_model_id INT,
  min_safe_qnty INT,
  max_safe_qnty INT,
  UNIQUE(store_id, shoe_model_id,min_safe_qnty)
  UNIQUE(store_id, shoe_model_id,max_safe_qnty)
);")

