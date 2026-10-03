# Notas de Revisión — Correcciones Apimetro
**Fecha de aplicación:** 2026-10-03  
**Rama Apimetro:** `feat/propuesta-anillar`  
**Instancia verificada:** Docker DEV (:5433), Escenario MB (:5434), Escenario METRO (:5435)  
**Estado:** Correcciones aplicadas y verificadas en los 3 entornos

---

## Resumen ejecutivo para VFTModel

Se aplicaron 4 correcciones de calidad de datos en Apimetro identificadas en `CHECK0_DIAGNOSTICO_DATOS.md`. Las correcciones afectan directamente los cálculos de impedancia, tiempo de viaje (T) y factor de detour (DI). **VFTModel debe re-correrse desde baseline** para obtener indicadores con datos correctos.

---

## ACHECK-01 — SUB: segmentación de línea completa → 12 ramals

### Problema original
El Tren Suburbano (`linea_id=102`, `sistema='SUB'`) tenía 2 ramals (1 por sentido), cada uno representando toda la línea como un segmento único de ~25.6 km. El graph builder de VFTModel generaba ~3 aristas en lugar de las 12 esperadas (6 segmentos × 2 sentidos).

### Corrección aplicada
Se segmentó la línea en 6 tramos entre estaciones consecutivas × 2 sentidos = **12 ramals**.  
Fuente de geometría: GTFS local (`ETL/Data/shapes.txt`, `stops.txt`).  
Archivo de migración: `db/migrations/v5.0_sub_segmentos.sql`.

### Estado actual en DB (verificado 2026-10-03)

```
 id    |      nombre_ramal       | sentido | vertices |  km  | velocidad_kmh
-------+-------------------------+---------+----------+------+---------------
 11018 | Cuautitlán-Tultitlán    |       1 |        4 | 3.53 | 65.0
 11019 | Tultitlán-Lechería      |       1 |        4 | 4.08 | 65.0
 11020 | Lechería-San Rafael     |       1 |       10 | 4.25 | 65.0
 11021 | San Rafael-Tlalnepantla |       1 |        6 | 3.57 | 65.0
 11022 | Tlalnepantla-Fortuna    |       1 |        7 | 5.10 | 65.0
 11023 | Fortuna-Buenavista      |       1 |        7 | 5.15 | 65.0
 11024 | Buenavista-Fortuna      |       0 |        7 | 5.15 | 65.0
 11025 | Fortuna-Tlalnepantla    |       0 |        7 | 5.10 | 65.0
 11026 | Tlalnepantla-San Rafael |       0 |        6 | 3.57 | 65.0
 11027 | San Rafael-Lechería     |       0 |       10 | 4.25 | 65.0
 11028 | Lechería-Tultitlán      |       0 |        4 | 4.08 | 65.0
 11029 | Tultitlán-Cuautitlán    |       0 |        4 | 3.53 | 65.0
(12 rows)
```

**Distancia de las 7 estaciones SUB al ramal más cercano (sentido IDA):**

```
 nombre       | dist_m_min
--------------+-----------
 Buenavista   |        0.0
 Cuautitlán   |        0.0
 Fortuna      |        0.0
 Lechería     |        0.0
 San Rafael   |        0.0
 Tlalnepantla |        0.0
 Tultitlán    |        0.0
```

Todas las estaciones a **0.0 m** del trazo — el snapping de VFTModel (umbral 85 m) funcionará correctamente. Antes de la corrección, Lechería estaba a 107.62 m (sobre el umbral).

### Impacto esperado en VFTModel
- El graph builder debe generar **12 aristas SUB** (antes: ~3)
- Los indicadores T y DI para rutas que usan el Suburbano quedarán correctamente calculados
- Verificar en VFTModel: `len([e for e in graph.edges if e['sistema']=='SUB'])` debe dar 12

---

## ACHECK-02 — INTERURBANO: velocidad 160 → 70 km/h

### Problema original
`velocidad_promedio_kmh = 160.0` era la velocidad de diseño máxima del tren, no la velocidad comercial operativa. VFTModel usaba 160 km/h directamente (el dato no era `null`), subestimando el tiempo de viaje en un factor de ~2.3×.

### Corrección aplicada
`UPDATE historico_operacion SET velocidad_promedio_kmh = 70.0 WHERE ramal_id IN (658, 659)`

### Estado actual en DB (verificado 2026-10-03)

```
 nombre              | sistema     | ramal_id | nombre_ramal | sentido | velocidad_kmh
---------------------+-------------+----------+--------------+---------+---------------
 Tren El Insurgente  | INTERURBANO |      658 | Zinacantepec |       1 |          70.0
 Tren El Insurgente  | INTERURBANO |      659 | Santa Fe     |       0 |          70.0
(2 rows)
```

### Impacto esperado en VFTModel
- El fallback de 70 km/h en `impedance.py` ya no es necesario (el dato de Apimetro ahora es 70.0)
- Los tiempos de viaje en rutas con INTERURBANO aumentarán ~2.3×
- El indicador T (tiempo promedio de red) puede variar si hay O-D que usan el Interurbano
- Revisar `V-01` en `CHECK0_DIAGNOSTICO_DATOS.md` — ahora el fallback y el dato de Apimetro coinciden

---

## ACHECK-03 — TROLE: Línea 10 elevada clasificada como confinado + 25 km/h

### Problema original
Todas las 24 aristas TROLE tenían `derecho_de_via = 'compartido'` (CF = 1.380). El Trolebús Línea 10 (elevado, oriente → Chalco) opera sobre infraestructura aérea segregada y debería clasificarse como `confinado` (CF = 1.152). El patrón original `ILIKE '%Elevado%'` en el script de carga nunca coincidió con datos reales (ninguna línea tiene "Elevado" en su nombre).

### Corrección aplicada
```sql
UPDATE lineas SET derecho_de_via = 'confinado' WHERE id = 63;
UPDATE historico_operacion SET velocidad_promedio_kmh = 25.0 WHERE ramal_id IN (651, 652);
```

### Estado actual en DB (verificado 2026-10-03)

```
 linea_id | nombre            | sistema | derecho_de_via | ramal_id | sentido | velocidad_kmh
----------+-------------------+---------+----------------+----------+---------+---------------
       63 | Trolebús Línea 10 | TROLE   | confinado      |      652 |       0 |          25.0
       63 | Trolebús Línea 10 | TROLE   | confinado      |      651 |       1 |          25.0
(2 rows)
```

### Referencia VFTModel
- `linea_id=63` en Apimetro → aristas con `sistema='TROLE'` y `derecho_de_via='confinado'`
- VFTModel debe calcular CF = 1.152 para estas aristas (en lugar de CF = 1.380)
- Revisar `V-02` en `CHECK0_DIAGNOSTICO_DATOS.md` — el campo esperado ahora existe

---

## ACHECK-04 — MEXICABLE: velocidad null en sentido de regreso → 20.0 km/h

### Problema original
Las aristas de regreso (`ramal_num=0`) de Mexicable L1 y L2 tenían `velocidad_promedio_kmh = NULL`. VFTModel usaba fallback de 20.0 km/h, que coincidía con el dato de ida, por lo que el impacto en indicadores era nulo. Sin embargo, la inconsistencia representaba un riesgo si el fallback cambiaba.

### Corrección aplicada
```sql
INSERT INTO historico_operacion (ramal_id, velocidad_promedio_kmh, fuente, fecha_registro)
VALUES (11001, 20.0, '...obras.expansion.mx...', NOW()),
       (11015, 20.0, '...obras.expansion.mx...', NOW());
```

### Estado actual en DB (verificado 2026-10-03)

```
 linea_id | nombre                      | ramal_id | sentido | velocidad_kmh
----------+-----------------------------+----------+---------+---------------
     1201 | Mexicable Línea 1           |    10501 |       1 |         20.00
     1207 | Mexicable Línea 2           |    10515 |       1 |         20.00
     1701 | Mexicable Línea 1 (Regreso) |    11001 |       0 |          20.0
     1707 | Mexicable Línea 2 (Regreso) |    11015 |       0 |          20.0
(4 rows)
```

---

## Conteos de tablas post-corrección (entorno DEV)

```
 tabla               | count
---------------------+-------
 lineas              |   317
 ramals              |   703
 estacions           | 22878
 historico_operacion |   702
```

**Nota:** Los escenarios MB y METRO tienen 321 líneas (317 base + 4 del Anillo Periférico interior propuesto). Los ramals de los escenarios incluyen además los ramals de la propuesta anillar.

---

## Archivos modificados en este ciclo de revisión

| Archivo | Tipo | Descripción |
|---------|------|-------------|
| `cmd/pkg/models/SQL/Update_Capacidad_vehicular.sql` | Modificado | Correcciones ACHECK-02, ACHECK-03, ACHECK-04 |
| `db/migrations/v5.0_sub_segmentos.sql` | Nuevo | Migración ACHECK-01: 12 ramals SUB |
| `scripts/generate_sub_migration.py` | Nuevo | Script Python que genera v5.0 desde GTFS |

---

## Checklist de re-corrida VFTModel

Antes de actualizar la tesis con nuevos valores:

- [ ] Verificar que el graph builder genera exactamente 12 aristas para `sistema='SUB'`
- [ ] Confirmar que `velocidad_promedio_kmh` para INTERURBANO es 70.0 (no 160.0) en el grafo construido
- [ ] Confirmar que las 2 aristas de TROLE L10 tienen `derecho_de_via='confinado'` en el GeoJSON recibido
- [ ] Re-correr `make run` + warmup con instancia Apimetro DEV actualizada
- [ ] Capturar nuevos valores de T (tiempo promedio), DI (detour factor), B(v) (centralidad)
- [ ] Actualizar `ANALISIS_PRELIMINAR.md` con valores corregidos
- [ ] Actualizar tablas de tesis (especialmente Tabla 5.3 y Cuadro 5.9 — ver `CHECK0_DIAGNOSTICO_DATOS.md` Capa 1)

---

## Notas técnicas para el agente de IA de VFTModel

1. **Orden de estaciones SUB en el grafo**: Buenavista (sur, CDMX) → Fortuna → Tlalnepantla → San Rafael → Lechería → Tultitlán → Cuautitlán (norte, EdoMex). El sentido 1 (IDA) va de norte a sur (Cuautitlán→Buenavista), el sentido 0 (REGRESO) va de sur a norte.

2. **Endpoint GeoJSON para verificar**: `GET /movilidad/mapas/geojsonLinea?sistema=SUB` debe devolver 12 features en lugar de 2. Cada feature tiene `properties.nombre_ramal` con el tramo (e.g. "Fortuna-Buenavista").

3. **Endpoint GeoJSON para TROLE L10**: `GET /movilidad/mapas/geojsonLinea?sistema=TROLE` — las aristas de `linea_id=63` tendrán `properties.derecho_de_via="confinado"`. Las demás TROLE mantienen `"compartido"`.

4. **IDs relevantes para debugging**:
   - SUB ramals IDA: 11018–11023, REGRESO: 11024–11029
   - TROLE L10: linea_id=63, ramal_id=651 (IDA), ramal_id=652 (REGRESO)
   - INTERURBANO: linea_id=3, ramal_id=658 (IDA), ramal_id=659 (REGRESO)
   - MEXICABLE regreso: ramal_id=11001 (L1), ramal_id=11015 (L2)

5. **Instancias disponibles**:
   - DEV baseline: `http://localhost:8080`
   - Escenario MB (Metrobús anillar): `http://localhost:8083`
   - Escenario METRO (Metro anillar): `http://localhost:8084`
