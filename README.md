<div align="center">

<img src="img/Diap_logo%20compacto.png" alt="Logo DIAP" width="250">

# DIAP-Memo

**Consultas SQL e informes de Power BI para analizar la plataforma virtual de la Escuela**

![MariaDB](https://img.shields.io/badge/MariaDB-003545?style=for-the-badge&logo=mariadb&logoColor=white)
![Moodle](https://img.shields.io/badge/Moodle-F98012?style=for-the-badge&logo=moodle&logoColor=white)
![Power BI](https://img.shields.io/badge/Power%20BI-F2C811?style=for-the-badge&logo=powerbi&logoColor=black)
![SQL](https://img.shields.io/badge/SQL-31%20consultas-4479A1?style=for-the-badge)

[Estructura](#-estructura) · [Consultas SQL](#-consultas-sql) · [Sintaxis del plugin](#-sintaxis-del-plugin) · [Power BI](#-power-bi)

</div>

---

## 📁 Estructura

```text
DIAP-Memo/
├── 📂 SQL/
│   ├── 📂 Cursos/        Estado y actividad de los cursos
│   ├── 📂 Estudiantes/   Vista del estudiante
│   ├── 📂 Profesores/    Vista docente
│   └── 📂 MasUsados/     Consultas generales más utilizadas
├── 📂 PowerBI/
│   └── 📂 Presentacion/  Medidas DAX con el HTML de cada página del informe
└── 📂 img/               Logo de la DIAP
```

---

## 🗄️ Consultas SQL

Escritas en SQL de **MariaDB** para el plugin [**Ad-hoc database queries**](https://moodle.org/plugins/report_customsql) de Moodle (`report_customsql`).

### 🚀 Cómo usarlas

1. En Moodle: **Administración del sitio → Informes → Ad-hoc database queries → Añadir consulta**.
2. Pegar el contenido del archivo `.sql`.
3. Guardar y ejecutar. El resultado se puede descargar en CSV para alimentar Power BI.

> [!TIP]
> Para ejecutarlas directamente en la base de datos, reemplazar `prefix_` por el prefijo real de las tablas y los tokens `%%...%%`.

### 📚 Catálogo

<details open>
<summary><b>📘 Cursos</b> — <code>SQL/Cursos/</code></summary>

| Consulta | Qué muestra |
|----------|-------------|
| [`AdopcionYusoModulos`](SQL/Cursos/AdopcionYusoModulos.sql) | Cuántas veces se usa cada tipo de actividad o recurso en cursos visibles |
| [`CursosContinuos`](SQL/Cursos/CursosContinuos.sql) | Cursos de educación continua |
| [`CursosFuturos`](SQL/Cursos/CursosFuturos.sql) | Cursos que aún no han empezado |
| [`CursosInactivos`](SQL/Cursos/CursosInactivos.sql) | Cursos sin actividad |
| [`CursosMasActivos`](SQL/Cursos/CursosMasActivos.sql) | Cursos con más actividad |
| [`CursosOcultos`](SQL/Cursos/CursosOcultos.sql) | Cursos ocultos a los estudiantes |
| [`CursosYDocentesActivos`](SQL/Cursos/CursosYDocentesActivos.sql) | Cursos activos y sus docentes |
| [`PoblacionPorCategoria`](SQL/Cursos/PoblacionPorCategoria.sql) | Usuarios por categoría de cursos |
| [`TotalDeCursos`](SQL/Cursos/TotalDeCursos.sql) | Listado total de cursos |
| [`TotalEstudiantes`](SQL/Cursos/TotalEstudiantes.sql) | Total de usuarios activos por rol |
| [`UsuariosActivos`](SQL/Cursos/UsuariosActivos.sql) | Usuarios únicos que han iniciado sesión |

</details>

<details open>
<summary><b>🎓 Estudiantes</b> — <code>SQL/Estudiantes/</code></summary>

| Consulta | Qué muestra |
|----------|-------------|
| [`DetalleInteracciones`](SQL/Estudiantes/DetalleInteracciones.sql) | Interacciones por curso y componente |
| [`HistorialAccesos`](SQL/Estudiantes/HistorialAccesos.sql) | Historial de accesos (acción e IP) |
| [`MisCalificaciones`](SQL/Estudiantes/MisCalificaciones.sql) | Calificaciones por ítem evaluado |
| [`MisCursosActivos`](SQL/Estudiantes/MisCursosActivos.sql) | Cursos activos del estudiante |
| [`RecursosMasVistos`](SQL/Estudiantes/RecursosMasVistos.sql) | Recursos más consultados |
| [`RitmoSemanal`](SQL/Estudiantes/RitmoSemanal.sql) | Interacciones por curso entre dos fechas elegidas |
| [`TiempoDeEstudio`](SQL/Estudiantes/TiempoDeEstudio.sql) | Tiempo de estudio por curso |

</details>

<details open>
<summary><b>👩‍🏫 Profesores</b> — <code>SQL/Profesores/</code></summary>

| Consulta | Qué muestra |
|----------|-------------|
| [`AlertaDesercicion`](SQL/Profesores/AlertaDesercicion.sql) | Estudiantes en riesgo de deserción |
| [`AnalisisEvaluaciones`](SQL/Profesores/AnalisisEvaluaciones.sql) | Resultados de los cuestionarios |
| [`CursosIncompletos`](SQL/Profesores/CursosIncompletos.sql) | Cursos del docente sin syllabus o programa |
| [`InventarioMateriales`](SQL/Profesores/InventarioMateriales.sql) | Materiales publicados por curso |
| [`NivelPresenciaDocentes`](SQL/Profesores/NivelPresenciaDocentes.sql) | Interacciones del docente en sus cursos |
| [`ParticipacionForos`](SQL/Profesores/ParticipacionForos.sql) | Participación en los foros |
| [`SabanaCalificaciones`](SQL/Profesores/SabanaCalificaciones.sql) | Sábana de calificaciones |

</details>

<details open>
<summary><b>⭐ Más usados</b> — <code>SQL/MasUsados/</code></summary>

| Consulta | Qué muestra |
|----------|-------------|
| [`QueryEpica`](SQL/MasUsados/QueryEpica.sql) | Docentes con sus cursos dictados y tomados, estudiantes y actividad de cada curso |
| [`students`](SQL/MasUsados/students.sql) | Estudiantes con sus cursos y categorías |
| [`TotalEstudiantes`](SQL/MasUsados/TotalEstudiantes.sql) | Total de estudiantes activos |
| [`TotalProfPlataformas`](SQL/MasUsados/TotalProfPlataformas.sql) | Docentes en la plataforma y su total |
| [`TresCategorias`](SQL/MasUsados/TresCategorias.sql) | Notas y estado académico en el Diplomado en competencias digitales |
| [`UsuariosConMatriculaciones`](SQL/MasUsados/UsuariosConMatriculaciones.sql) | Usuarios con su rol, curso y tipo de matriculación |

</details>

---

## 🧩 Sintaxis del plugin

### Tokens

| Token | Se reemplaza por |
|-------|------------------|
| `prefix_` | El prefijo real de las tablas de Moodle (p. ej. `prefix_user`) |
| `%%WWWROOT%%` | `https://virtual.escuelaing.edu.co` (en los resultados) |
| `%%USERID%%` | El id del usuario que ve el informe, antes de ejecutar la consulta |
| `%%STARTTIME%%` / `%%ENDTIME%%` | En informes programados: timestamp Unix del inicio y fin de la semana/mes del informe |
| `%%C%%` / `%%S%%` / `%%Q%%` | Los caracteres `:` / `;` / `?` en los datos de salida (p. ej. en URLs) |

### Columnas especiales

| Si la columna… | El informe… |
|----------------|-------------|
| Contiene un valor que parece URL | Lo convierte automáticamente en enlace |
| Viene en par `nombre_columna` + `nombre_columna_link_url` | Muestra una sola columna con enlace: la primera es el texto y la segunda la URL |
| Termina en `date` y contiene enteros | Los trata como timestamps Unix y los muestra como fechas legibles |

### Parámetros

Se pueden usar marcadores con nombre, p. ej. `:nombre_parametro`. Al ejecutar el informe, el usuario ingresa sus valores.

- Si el nombre empieza o termina en `date` → selector de fecha y hora.
- Si no → campo de texto.

### ⚠️ Caracteres prohibidos

> [!WARNING]
> No se pueden usar los caracteres `:`, `;` ni `?` dentro de cadenas en la consulta.

| Carácter | En datos de salida | En datos de entrada (MariaDB/MySQL) | En datos de entrada (Postgres) |
|:--------:|:------------------:|:-----------------------------------:|:------------------------------:|
| `:` | `%%C%%` | `CHAR(58)` | `CHR(58)` |
| `;` | `%%S%%` | `CHAR(59)` | `CHR(59)` |
| `?` | `%%Q%%` | `CHAR(63)` | `CHR(63)` |

En datos de entrada (p. ej. en una expresión regular o al buscar esos caracteres) hay que obtenerlos con la función de la base de datos y concatenarlos.

---

## 📊 Power BI

Cada archivo de `PowerBI/Presentacion/` es una **medida DAX que devuelve HTML/CSS**, renderizada con un visual de contenido HTML. El número del archivo indica el orden de la página en el informe.

| # | Sección | Páginas |
|:-:|---------|---------|
| 1 | 🏠 Inicio | Landing page |
| 2–5 | 💻 Plataformas | Plataformas virtuales, Campus virtual, Virtual, Educación continua |
| 6–15 | 📈 Dashboards | Menú, dashboards virtuales, de profesores, de estudiantes y métricas de adopción |
| 16–20 | 🏛️ La DIAP | Quiénes somos, qué es la DIAP, dimensiones, servicios, indicadores |
| 21–23 | 🧭 Servicios virtuales | Menú, estudiantes, profesores |
| 24–31 | 🔧 Gestión | Gestión del cambio, ecosistema, en qué trabajamos, retos, equipos, soporte, ecosistema tecnológico |
| 32 | 🙌 Cierre | Gracias |

### 🚀 Cómo usarlas

1. En Power BI Desktop: **Nueva medida** y pegar el contenido del `.txt`.
2. Mostrar la medida con un visual de HTML (p. ej. *HTML Content*).

---

<div align="center">
<sub>Hecho por la <b>DIAP</b> · Escuela Colombiana de Ingeniería Julio Garavito</sub>
</div>
