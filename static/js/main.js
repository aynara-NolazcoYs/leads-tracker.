document.querySelector("form").addEventListener("submit", function(e) {
    const nombre = document.getElementById("nombre").value.trim();
    const correo = document.getElementById("correo").value.trim();

    if (!nombre || !correo) {
        alert("Nombre y correo son obligatorios.");
        e.preventDefault(); // Evita que se envíe el formulario
    }
});