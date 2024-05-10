from flask import Flask, request, jsonify, render_template
import sqlite3

app = Flask(__name__)

# Инициализация базы данных SQLite3
def init_db():
    conn = sqlite3.connect('database.db')
    cursor = conn.cursor()
    cursor.execute('''
        CREATE TABLE IF NOT EXISTS users (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            age INTEGER NOT NULL
        )
    ''')
    conn.commit()
    conn.close()

# Инициализация базы данных при запуске приложения
init_db()

# Главная страница
@app.route('/')
def index():
    return render_template('index.html')

# Обработка POST-запроса для добавления данных в базу данных
@app.route('/submit-info', methods=['POST'])
def submit_info():
    # Получение данных из запроса
    data = request.json
    name = data.get("name")
    age = data.get("age")

    # Подключение к базе данных SQLite3 и вставка данных
    conn = sqlite3.connect('database.db')
    cursor = conn.cursor()
    cursor.execute('INSERT INTO users (name, age) VALUES (?, ?)', (name, age))
    conn.commit()
    conn.close()

    # Возвращение успешного JSON-ответа
    return jsonify({"message": "Данные успешно отправлены"}), 200

if __name__ == '__main__':
    app.run(debug=True)
