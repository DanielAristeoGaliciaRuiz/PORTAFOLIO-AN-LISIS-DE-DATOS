# Análisis de Datos COVID-19 con SQL

**Herramientas**: SQL Server

**Habilidades aplicadas**: Consultas SQL avanzadas, limpieza de datos, funciones agregadas, joins, CTEs, tablas temporales, funciones de ventana y creación de vistas.

---

### Objetivo

Explorar el impacto global de la pandemia de COVID-19 mediante datos abiertos, con énfasis en tasas de infección, mortalidad, vacunación y distribución geográfica. El propósito es generar información lista para visualización y análisis ejecutivo.

---

### Metodología

- Se unieron y limpiaron dos tablas principales: `CovidDeaths` y `CovidVaccinations`.
- Se analizaron indicadores clave como:
  - Tasa de letalidad por país y fecha
  - Porcentaje de población infectada
  - Avance global diario de casos y muertes
  - Ranking de países por muertes absolutas
  - Evolución de la vacunación a través del tiempo
- Se implementaron:
  - **CTEs** para cálculo limpio y reutilizable
  - **Tablas temporales** para pruebas aisladas
  - **Vistas** persistentes para dashboards externos

---

### Dataset

- **Fuente**: Our World in Data (https://ourworldindata.org/covid-deaths)
- **Cobertura**: Global
- **Variables clave**: total_cases, total_deaths, population, new_vaccinations, date, location, continent

---

### Resultados

- Se detectó una gran variabilidad entre regiones en tasas de infección y mortalidad.
- Se visualizó la progresión global diaria de casos y muertes.
- Se calcularon métricas acumuladas de vacunación por país en función de su población.
- El proyecto quedó listo para su integración con dashboards externos (ej. Power BI).

---

