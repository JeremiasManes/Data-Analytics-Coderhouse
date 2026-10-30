# sql-select-fundamentals

¿Por qué es mala práctica usar SELECT * en producción? Mencioná al menos dos razones concretas (rendimiento, mantenibilidad, seguridad).

Utilizar "SELECT *" en entornos de producción puede ser una mala práctica por razones relacionadas con el rendimiento y la mantenibilidad de las consultas.
En primer lugar, puede afectar el rendimiento cuando se recuperan columnas que no son necesarias para el análisis. En tablas con grandes volúmenes de datos, solicitar todos los atributos(columnas) puede incrementar la cantidad de información transferida y el consumo de recursos, especialmente cuando la consulta se ejecuta de manera frecuente.
En segundo lugar, puede dificultar el mantenimiento de los procesos de análisis. Al utilizar "SELECT *", la consulta depende de todas las columnas disponibles en la tabla, incluso de aquellas que no son necesarias. Si la estructura de la tabla cambia, por ejemplo, mediante la incorporación de nuevas columnas, el resultado puede modificarse sin que sea necesario alterar la consulta original.
Por estos motivos, es recomendable seleccionar explícitamente las columnas necesarias para cada análisis. Esto permite reducir la transferencia de información innecesaria y mantener resultados más predecibles y fáciles de gestionar.


¿Por qué son importantes los alias para un stakeholder no técnico? Explicá con un ejemplo concreto cómo un alias transforma total_amount en algo que cualquier persona del área de finanzas puede interpretar directamente.

Los alias son importantes porque mejoran la legibilidad y la interpretación de los resultados SQL para los stakeholders que no tienen conocimientos técnicos sobre la estructura de la base de datos.
Por ejemplo, una columna denominada "total_amount" puede resultar poco intuitiva para una persona del área de finanzas que no esté familiarizada con los nombres técnicos en inglés. Al utilizar un alias como "monto_total", el significado de la columna se vuelve más claro y directo para el usuario.
De esta manera, el resultado presenta la columna con un nombre adaptado al lenguaje del negocio, sin modificar los datos almacenados ni el nombre original del atributo en la tabla.
Además, los alias no se limitan a traducir nombres entre idiomas. También permiten reemplazar identificadores técnicos o poco descriptivos por denominaciones más claras y consistentes con el contexto del análisis.
En conclusión, los alias funcionan como un recurso de presentación que facilita la comunicación de los datos entre el equipo técnico y los usuarios de negocio, haciendo que los resultados sean más accesibles e interpretables para quienes deben utilizarlos para tomar decisiones.
