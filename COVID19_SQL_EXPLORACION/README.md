# Exploración de Datos COVID-19 con SQL (Versión CSV)

**Herramientas**: MySQL

**Habilidades aplicadas**: Limpieza de datos, consultas agregadas, joins, funciones de ventana, CTEs, tablas temporales, creación de vistas.

---

### Objetivo

Explorar y analizar datos globales relacionados con la pandemia de COVID-19 a partir de archivos CSV cargados en base de datos. El objetivo es comprender la evolución de casos, muertes y vacunación por país, región y a nivel global, así como preparar los datos para futuras visualizaciones.

---

### Metodología

- **Exploración inicial** del dataset: revisión general y selección de variables clave.
- **Cálculos específicos**:
  - Tasa de mortalidad por país (muertes/casos)
  - Porcentaje de población infectada
  - Evolución global diaria de nuevos casos y muertes
- **Análisis por región**:
  - Ranking de países con mayor tasa de infección y mortalidad
  - Análisis acumulado por continentes
- **Vacunación**:
  - Avance de la vacunación por país y fecha
  - Acumulado de personas vacunadas por país usando funciones de ventana
- **Modelado intermedio**:
  - Uso de CTEs y tablas temporales para cálculos complejos reutilizables
  - Creación de vistas para facilitar exportación a dashboards

---

### Dataset

- **Origen**: Datos abiertos convertidos desde archivos CSV (`coviddeaths_csv`, `covidvacinations_csv`)
- **Cobertura**: Mundial
- **Variables clave**: total_cases, new_cases, total_deaths, population, new_vaccinations, date, location, continent

---

### Resultados

- Se identificaron los países más afectados en proporción a su población.
- Se calculó la tasa de mortalidad diaria y acumulada a nivel mundial.
- Se preparó un seguimiento detallado de la vacunación acumulada por país.
- Se generaron estructuras reutilizables mediante CTEs, vistas y tablas temporales para visualización externa.

---


