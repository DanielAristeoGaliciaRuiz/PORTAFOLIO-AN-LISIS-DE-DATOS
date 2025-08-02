# Diagnóstico de Cáncer de Mama mediante Regresión Logística

**Herramientas**: Python (Pandas, NumPy, Statsmodels, Seaborn, Matplotlib, Scikit-learn)

**Habilidades aplicadas**: Limpieza y transformación de datos, regresión logística, análisis de coeficientes, evaluación de modelos de clasificación binaria, visualización de métricas, y comprensión clínica de variables predictoras.

---

### Objetivo

Desarrollar un modelo de clasificación binaria que permita predecir si una masa tumoral es benigna o maligna, utilizando variables morfológicas obtenidas a partir de imágenes médicas. El análisis se realiza mediante regresión logística, priorizando la capacidad de detección temprana.

---

### Metodología

- **Preparación de datos**: Eliminación de columnas no informativas, limpieza de valores faltantes y recodificación de la variable objetivo.
- **Análisis exploratorio**: Evaluación visual de la distribución de clases, correlaciones entre variables y gráficos de dispersión entre características clave.
- **Modelado**: Ajuste de regresión logística con `statsmodels`, análisis de significancia de los coeficientes y advertencias sobre quasi-separación.
- **Evaluación del desempeño**:
  - Conjunto de entrenamiento: Accuracy 98.6%, AUC-ROC 0.98
  - Conjunto de prueba: Accuracy 92.1%
  - Métricas adicionales: Precisión, recall, F1-score y matriz de confusión
- **Visualización**: Diagramas de probabilidad y mapas de calor de las matrices de confusión.

---

### Conjunto de datos

- **Fuente**: UCI Machine Learning Repository — Breast Cancer Wisconsin (Diagnostic) Data Set.
- **Observaciones**: 569 muestras
- **Variables**: 30 características numéricas de imágenes digitales, divididas en métricas de media, error estándar y valores extremos para distintas propiedades celulares (radio, textura, perímetro, área, simetría, concavidad, etc.)

---

### Resultados

- El modelo logra una alta sensibilidad (recall ≈ 97.6%) en el conjunto de entrenamiento, lo que indica una buena capacidad para detectar tumores malignos.
- Se identificaron variables con fuerte impacto en el diagnóstico como `concavity_mean`, `area_se` y `texture_se`.
- El desempeño general del modelo es sólido, aunque algunas advertencias sobre separación perfecta indican la posibilidad de refinar el conjunto de predictores.

---
