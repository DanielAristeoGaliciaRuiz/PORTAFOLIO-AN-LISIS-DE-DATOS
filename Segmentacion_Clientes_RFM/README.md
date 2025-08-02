# Segmentación de Clientes utilizando el Modelo RFM

**Herramientas**: Python (Pandas, NumPy, Seaborn, Matplotlib)

**Habilidades aplicadas**: Limpieza de datos, análisis de comportamiento del cliente, ingeniería de características (métricas RFM), asignación de puntuaciones por percentiles, estrategias de segmentación y visualización de resultados.

---

### Objetivo

El objetivo de este proyecto es aplicar el modelo RFM (Recencia, Frecuencia y Valor Monetario) para segmentar clientes con base en su comportamiento de compra. Esta segmentación permite identificar clientes de alto valor, grupos para campañas de reactivación y apoyar decisiones estratégicas en marketing.

---

### Metodología

- **Limpieza de datos**: Se eliminaron observaciones con IDs faltantes, transacciones duplicadas y registros con cantidades o precios negativos.
- **Ingeniería de características**: Se construyeron las métricas RFM a partir de los datos transaccionales.
- **Asignación de puntajes**: Se asignaron puntuaciones de 1 a 5 para cada métrica mediante cortes por quintiles.
- **Segmentación**: Se implementó una clasificación general en tres niveles (alto, medio, bajo) a partir del score RFM total, y una segmentación detallada basada en combinaciones únicas de los valores R, F y M.
- **Visualización**: Se generaron histogramas y diagramas de caja para analizar la distribución de clientes y comparar grupos.

---

### Conjunto de datos

- **Fuente**: Conjunto de datos “Online Retail” (Repositorio de Aprendizaje Automático de UCI)
- **Transacciones**: 406,829 registros
- **Variables utilizadas**: InvoiceNo, StockCode, Quantity, UnitPrice, CustomerID, Country, InvoiceDate

---

### Resultados

- Identificación de segmentos de clientes basados en comportamiento histórico.
- Clasificación en niveles de valor (Tier 1, 2 y 3) para facilitar decisiones estratégicas.
- Recomendaciones de acciones para retención, fidelización o reactivación de clientes.

---
