# CHECK-0 — Diagnóstico de Datos: Tesis · VFTModel · Apimetro
**Fecha:** 2026-10-01  
**Rama VFTModel:** `feat/propuesta-anillar-indicador`  
**Instancia Apimetro consultada:** `http://localhost:8080` (baseline)  
**Estado:** Diagnóstico completado — pendiente de corrección en Apimetro

---

## Contexto

Este documento es el resultado del análisis CHECK-0: diagnóstico de la fuente de datos de Apimetro como capa previa a cualquier corrección en VFTModel o en la tesis. Se divide en tres capas para que cada equipo entienda su responsabilidad y la relación de dependencia entre capas.

> **Regla de dependencia:** si un dato de Apimetro está incorrecto, el cálculo de VFTModel es incorrecto, y los valores reportados en la tesis son incorrectos. Las correcciones deben aplicarse en orden: **Apimetro → VFTModel (re-corrida) → Tesis**.

---

## Capa 1 — Tesis (redacción)

Estos errores existen en el texto de la tesis independientemente de los datos. No requieren re-corrida de VFTModel para corregirse, pero sí deben resolverse antes de la entrega.

---

### T-01 — Cablebús: clasificación "confinado" con CF=1.0 es contradictorio

**Ubicación en tesis:** Cap. 3 §3.3.6.1 y Cap. 5 Cuadro 5.9

**Hallazgo:** El texto del Cap. 3 clasifica al Cablebús como sistema de "derecho de vía confinado" y luego le asigna CF=1.0. Esto es internamente contradictorio: en la metodología, "confinado" implica α=0.2 y CF=1.152, no CF=1.0.

El Cuadro 5.9 del Cap. 5 agrava la inconsistencia al reportar CF=1.152 para Cablebús, que tampoco coincide con lo declarado en Cap. 3.

**Dato real del sistema (verificado):** Apimetro clasifica CBB como `derecho_de_via = "exclusivo"`. VFTModel calcula CF=1.0 correctamente. El Cablebús es un teleférico aéreo sin contacto con vialidades terrestres — equivalente al Metro en términos de segregación física.

**Corrección en tesis:** Unificar a "derecho de vía **exclusivo**" con CF=1.0 en ambos capítulos. Los datos y el cálculo ya son correctos; solo el texto está mal.

---

### T-02 — Metrobús: Tabla 5.3 muestra 14.1 km/h, el cálculo real es 16.3 km/h

**Ubicación en tesis:** Cap. 5 Tabla 5.3 (velocidad implícita post-fricción)

**Hallazgo:** La Tabla 5.3 reporta 14.1 km/h como velocidad post-fricción del Metrobús. Con `derecho_de_via = "exclusivo"` (CF=1.0), la velocidad post-fricción es exactamente igual a la velocidad libre: 16.3 km/h. El valor 14.1 km/h corresponde a aplicar CF=1.152 (confinado) sobre 16.3 km/h — lo que implica que la tabla fue generada con una versión anterior de los datos donde MB era "confinado".

```
# Relación que explica el 14.1:
16.3 / 1.152 = 14.15 km/h  ← velocidad con CF "confinado" (incorrecto)
16.3 / 1.000 = 16.30 km/h  ← velocidad con CF "exclusivo" (correcto, dato actual)
```

**Corrección en tesis:** Regenerar la Tabla 5.3 con los parámetros actuales de Apimetro (ver Capa 3). El valor correcto para Metrobús es 16.3 km/h.

---

### T-03 — Velocidad del corredor anillar Caso 3: 22 km/h vs. 16.3 km/h

**Ubicación en tesis:** Cap. 3 §3.1.1.8

**Hallazgo:** El Cap. 3 declara 22 km/h para el Metrobús en el Caso 3 (corredor anillar hipotético). VFTModel usa 16.3 km/h para el Metrobús de la red actual. Son dos valores para dos contextos distintos: 16.3 km/h es la velocidad operativa del MB en CDMX (dato Apimetro), y 22 km/h es el parámetro de diseño del corredor anillar hipotético en los Escenarios MB.

No es un error si se declara explícitamente. El texto debe aclarar que ambos valores son correctos para sus respectivos contextos.

**Corrección en tesis:** Agregar nota que distingue: "16.3 km/h corresponde a la velocidad operativa promedio del Metrobús en la red actual (fuente: Apimetro); 22 km/h es el parámetro de diseño adoptado para el corredor anillar hipotético del Caso 3."

---

## Capa 2 — VFTModel (cálculos)

Estos son comportamientos del motor de cálculo que dependen directamente de los datos que recibe de Apimetro. Algunos son correctos por diseño; otros se resolverán automáticamente cuando Apimetro corrija sus datos.

---

### V-01 — INTERURBANO: fallback de 70 km/h nunca se aplica

**Archivo:** `src/core/models/impedance.py:109-111`

**Comportamiento actual:**

```python
FALLBACK_VELOCIDAD = {
    "INTERURBANO": 70.0,   # Corregido: velocidad comercial (~70 km/h); diseño era 160 km/h
    ...
}

# En apply_impedance():
v_kmh = data.get("velocidad_promedio_kmh")   # Apimetro envía 160.0 → no es None
if v_kmh is None or v_kmh <= 0:
    v_kmh = self.FALLBACK_VELOCIDAD.get(sistema, 15.0)   # ← nunca llega aquí
```

El comentario en el código ya documenta la corrección intencional (70 km/h), pero el fallback solo opera cuando el dato de Apimetro es `null`. Apimetro envía **160.0 km/h** (velocidad de diseño), por lo que VFTModel usa 160 km/h en todos los cálculos actuales.

**Impacto en indicadores:**

| Indicador | Efecto |
|-----------|--------|
| T (tiempo promedio) | Rutas con Interurbano están subestimadas ~2.3x |
| DI (detour factor) | d_red subestimada en trayectos que usan el Interurbano |
| B(v) | Centralidad de nodos del Interurbano puede estar inflada |

**Resolución:** Depende de ACHECK-02 (corrección en Apimetro). Una vez que Apimetro envíe 70.0 km/h, VFTModel lo usará automáticamente sin cambios en el código.

---

### V-02 — TROLE elevado: campo esperado no existe en Apimetro

**Archivo:** `src/core/models/impedance.py:43`

```python
"TROLE": 18.0,  # Ajustado: Base para convencional. El elevado (25) requiere dato en GeoJSON
```

El código anticipaba que Apimetro diferenciaría los ramales elevados con `derecho_de_via = "confinado"`. Apimetro envía `"compartido"` para **todas** las aristas TROLE (CF=1.380 en lugar de CF=1.152 para el elevado).

**Resolución:** Depende de ACHECK-03. Una vez que Apimetro distinga el elevado, VFTModel calculará el CF correcto sin cambios adicionales.

---

### V-03 — SUB: graph builder genera ~3 aristas para 7 estaciones

**Contexto:** El graph builder hace snapping de coordenadas de estaciones sobre la geometría de cada línea para generar segmentos. Para el Tren Suburbano, Apimetro provee la línea como **un único segmento** de ~25.6 km. Si los vértices intermedios de esa geometría no coinciden con las coordenadas de las 7 estaciones dentro del radio de tolerancia (85 m), el snapping falla para las paradas intermedias.

**Resultado observado:** La tesis reporta 3 aristas para el SUB. Con 7 estaciones se esperarían ≥12 aristas (6 segmentos × 2 sentidos).

**Resolución:** Depende de ACHECK-01. El graph builder funciona correctamente para sistemas con geometrías segmentadas (e.g., TL: 2 líneas → 52 aristas). El problema está en cómo Apimetro modela la geometría del SUB.

---

## Capa 3 — Apimetro (datos)

> **Para el agente de Apimetro:** Los siguientes son los únicos cambios requeridos en la fuente de datos. La severidad refleja el impacto en los resultados de la tesis doctoral. Los indicadores afectados son el producto final del análisis y están siendo validados para publicación académica.

---

### ACHECK-01 — SUB: línea modelada como segmento único 🔴 CRÍTICO

**Sistema:** Tren Suburbano (`sistema = "SUB"`, `linea_id = 102`)

**Problema:** La línea tiene 7 estaciones registradas correctamente en `geojsonEstacion`, pero `geojsonLinea` provee solo **2 features** (una por sentido), cada una representando toda la línea como un único segmento de ~25.6 km.

```
Estado actual en Apimetro:
  geojsonEstacion → SUB: 7 estaciones ✓
    Buenavista, Tlalnepantla, Fortuna, San Rafael, Lechería, Tultitlán, Cuautitlán

  geojsonLinea → SUB: 2 features (linea_id=102, sentido 0 y 1)
    sentido=1: 25,672 m (toda la línea como 1 segmento)
    sentido=0: 25,672 m (toda la línea como 1 segmento)

Estado requerido:
  geojsonLinea → SUB: 12 features mínimo
    6 segmentos × 2 sentidos
    Buenavista→Tlalnepantla, Tlalnepantla→Fortuna, ...→Cuautitlán
```

**Impacto en tesis:** Todos los indicadores que dependen del grafo de red (T, DI, B(v)) tienen valores incorrectos para rutas que usan el Suburbano. Este sistema conecta la CDMX con municipios del norte del Estado de México — su subrepresentación afecta directamente los resultados de accesibilidad territorial.

**Corrección requerida:** Dividir la línea en segmentos entre estaciones consecutivas. Cada segmento debe tener sus propias coordenadas de origen/destino coincidentes con las coordenadas de las estaciones en `geojsonEstacion`.

---

### ACHECK-02 — INTERURBANO: velocidad de diseño, no comercial 🔴 CRÍTICO

**Sistema:** Tren El Insurgente (`sistema = "INTERURBANO"`, `linea_id = 3`)

**Problema:** `velocidad_promedio_kmh = 160.0` es la velocidad de diseño máxima del tren, no su velocidad comercial operativa. VFTModel usa el dato de Apimetro cuando no es `null`, por lo que los tiempos de viaje del Interurbano están subestimados en un factor de ~2.3x.

```
Estado actual:
  velocidad_promedio_kmh = 160.0  ← velocidad de diseño (nunca alcanzada en operación)

Estado requerido:
  velocidad_promedio_kmh = 70.0   ← velocidad comercial operativa promedio
                                     (referencia: FERROMEX/Tren El Insurgente ~65-75 km/h)
```

**Impacto en tesis:** El tiempo de viaje promedio de la red (T=108.92 min) puede estar subestimado en los O-D que usan el Interurbano. El factor de desviación (DI) también se ve afectado. El valor de T es uno de los tres indicadores principales de Fase 3.

**Corrección requerida:** Actualizar `velocidad_promedio_kmh` a 70.0 para `linea_id = 3` en ambas aristas (sentido 0 y sentido 1).

---

### ACHECK-03 — TROLE: no distingue elevado vs. convencional 🟠 MODERADO

**Sistema:** Trolebús (`sistema = "TROLE"`)

**Problema:** Todas las 23 aristas tienen `derecho_de_via = "compartido"`. El Trolebús elevado opera sobre infraestructura aérea segregada y debería clasificarse como `"confinado"`. VFTModel esperaba recibir esta distinción desde Apimetro (el código lo documenta explícitamente).

```
Estado actual:
  Todos los ramales TROLE → derecho_de_via = "compartido"
  CF resultante = 1 + 0.5 × 0.759 = 1.380

Estado requerido:
  Trolebús convencional → derecho_de_via = "compartido"   (CF = 1.380)
  Trolebús elevado      → derecho_de_via = "confinado"    (CF = 1.152)
```

**Ramales elevados a identificar:** La distinción debe hacerse a nivel de `linea_id` o mediante un campo adicional `subtipo = "elevado"`. VFTModel puede leer cualquiera de las dos opciones.

**Impacto en tesis:** Las aristas del Trolebús elevado tienen tiempos de viaje sobreestimados (~20% más lentos de lo real). Afecta T y B(v) para los nodos servidos exclusivamente por ese ramal.

---

### ACHECK-04 — MEXICABLE: velocidad null en sentido de regreso 🟢 BAJO

**Sistema:** Mexicable (`sistema = "MEXICABLE"`)

**Problema:** Las aristas de regreso (`sentido = 0`) tienen `velocidad_promedio_kmh = null` para ambas líneas.

```
linea_id=1701 (L1 Regreso) → velocidad_promedio_kmh = null
linea_id=1707 (L2 Regreso) → velocidad_promedio_kmh = null
```

**Impacto actual:** Ninguno — VFTModel aplica el fallback de 20.0 km/h, que coincide con las aristas de ida. Sin embargo, es un dato incompleto que puede causar divergencias si el fallback cambia.

**Corrección requerida:** Completar `velocidad_promedio_kmh = 20.0` para ambas aristas de regreso.

---

## Resumen de correcciones requeridas en Apimetro

| ID | Sistema | linea_id | Campo | Valor actual | Valor correcto | Severidad |
|----|---------|----------|-------|--------------|----------------|-----------|
| ACHECK-01 | SUB | 102 | Modelado de línea | 1 segmento único | 6 segmentos entre estaciones | 🔴 |
| ACHECK-02 | INTERURBANO | 3 | `velocidad_promedio_kmh` | 160.0 | 70.0 | 🔴 |
| ACHECK-03 | TROLE | múltiples | `derecho_de_via` (elevado) | `"compartido"` | `"confinado"` para ramales elevados | 🟠 |
| ACHECK-04 | MEXICABLE | 1701, 1707 | `velocidad_promedio_kmh` | null | 20.0 | 🟢 |

---

## Lo que ya está correcto en Apimetro

Para evitar correcciones innecesarias, estos valores fueron verificados y están bien:

| Sistema | Campo | Valor | Por qué es correcto |
|---------|-------|-------|---------------------|
| CBB | `derecho_de_via` | `"exclusivo"` | Teleférico aéreo, segregación total → CF=1.0 ✓ |
| MB | `derecho_de_via` | `"exclusivo"` | Carril confinado BRT-style → CF=1.0 ✓ |
| MB | `velocidad_promedio_kmh` | 16.3 | Velocidad operativa confirmada ✓ |
| METRO | `derecho_de_via` | `"exclusivo"` | Infraestructura segregada → CF=1.0 ✓ |
| MEXIBÚS | `derecho_de_via` | `"confinado"` | Opera en EdoMex, menor segregación que MB → CF=1.152 (decisión metodológica) |
| RTP | `derecho_de_via` | `"compartido"` | Superficie en vialidades mixtas ✓ |

---

## Flujo de corrección recomendado

```
1. Apimetro corrige ACHECK-01 y ACHECK-02  ← bloquean re-corrida
2. Re-corrida baseline en VFTModel (make run + warmup)
3. Verificar nuevos valores de T, DI para rutas con SUB/INTERURBANO
4. Actualizar ANALISIS_PRELIMINAR.md con valores corregidos
5. Apimetro corrige ACHECK-03 y ACHECK-04  ← pueden ir en paralelo con los anteriores
6. Segunda re-corrida (si los valores de T/B cambian significativamente)
7. Actualizar tablas de la tesis con valores finales
```
