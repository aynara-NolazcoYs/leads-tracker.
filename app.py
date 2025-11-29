from flask import Flask, render_template, request, redirect, url_for, flash
import mysql.connector
from mysql.connector import Error
from config import DB_HOST, DB_USER, DB_PASSWORD, DB_NAME

app = Flask(__name__)
app.secret_key = "supersecretkey"  # Necesario para mostrar mensajes flash

# Funcion de conexion
def get_db_connection():
    try:
        conn = mysql.connector.connect(
            host=DB_HOST,
            user=DB_USER,
            password=DB_PASSWORD,
            database=DB_NAME
        )
        return conn
    except Error as e:
        print("Error de conexión:", e)
        return None

@app.route("/", methods=["GET", "POST"])
def index():
    if request.method == "POST":
        nombre = request.form.get("nombre")
        correo = request.form.get("correo")
        telefono = request.form.get("telefono")
        interes = request.form.get("interes")

        # Validar campos obligatorios
        if not nombre or not correo:
            flash("Nombre y correo son obligatorios")
            return redirect(url_for("index"))

        # Guardar en DB
        conn = get_db_connection()
        if conn:
            try:
                cursor = conn.cursor()
                sql = """
                INSERT INTO leads (nombre_completo, correo, telefono, interes_servicio)
                VALUES (%s, %s, %s, %s)
                """
                cursor.execute(sql, (nombre, correo, telefono, interes))
                conn.commit()
                cursor.close()
                conn.close()
                return redirect(url_for("success"))
            except Error as e:
                if "Duplicate entry" in str(e):
                    flash("El correo ya está registrado")
                    return redirect(url_for("index"))
                print("Error al insertar en la base de datos:", e)
                return "Error al guardar los datos", 500
        else:
            return "No se pudo conectar a la base de datos", 500

    return render_template("index.html")

@app.route("/success")
def success():
    return render_template("success.html")

if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0", port=5000)

