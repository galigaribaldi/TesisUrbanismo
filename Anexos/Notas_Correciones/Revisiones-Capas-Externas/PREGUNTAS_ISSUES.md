# Preguntas de datos — Revisión-2 Dr. Jairo (#28 🔴, #29 🟠)

**Fecha:** 2026-10-11
**Propósito:** resolver las inconsistencias de datos del Cap. 5 (y parte del Cap. 3) antes de corregir la redacción. Cada pregunta indica qué dice hoy la tesis, qué afecta y cómo se resolverá una vez que estén los datos.
**Regla:** las cifras citadas son las que aparecen hoy en los `.tex`; todo lo demás se pregunta, no se infiere. Las rutas son relativas a la raíz del repositorio de la tesis.

**Orden recomendado:** P0 → P1 → P2 → P3 → P4 → P5 → P7 → P8 → P9 → P6 → P10
(P0 define la base de todo; P6 es bibliográfico; P10 se arma con las demás respuestas.)

---

## P0. Corrida canónica (de esta respuesta dependen todas las demás)

**Por qué importa:** el Cap. 5 mezcla cuatro corridas y dos conteos de nodos que no coinciden.
- 2026-04-18: §5.2 grafo, §5.3.1 impedancia, §5.3.2 cobertura, §5.3.3 FC y Fig. Top-10 de Apímetro.
- 2026-04-27: §5.3.4 DI.
- 2026-09-02: §5.5.1 T, §5.5.2 B(v), §5.5.3 ΔE y parte de §5.6.
- 2026-09-24: mapas de §5.6.2.
- §5.2 (`5-Analisis-Red-Actual/5-2-Grafo-Topologico.tex:40-44`) dice 11,115 nodos y 45,679 aristas (25,197 de servicio + 20,482 de transbordo).
- §5.5.1 (`5-Analisis-Red-Actual/5-5-Fase3/5-5-1-TiempoViaje.tex:9-10`) dice 10,561 nodos.

**Preguntas:**
1. ¿Cuál es la corrida vigente? Necesito fecha, ID o hash de VFTModel y si ya incluye el Fix #22.
2. Para esa corrida: ¿cuántos nodos, aristas totales, aristas de servicio, aristas de transbordo y entidades de origen?
3. ¿Los 10,561 nodos de §5.5.1 son la componente gigante y los 11,115 de §5.2 el grafo completo, o vienen de corridas distintas?
4. ¿Se regenera todo el Cap. 5 con esa corrida, o hay secciones que se quedan con una corrida anterior?

**Cómo se resuelve:**
- (A) Todo el capítulo pasa a una sola corrida: se actualizan cifras y pies «Corrida: …», y se regeneran las figuras.
- (B) Se conservan varias corridas: se agrega una nota en §5.2 que diga qué corrida usa cada sección y por qué difieren los conteos.

---

## P1. Cifras del grafo y porcentajes que dependen de ellas — §5.2 (#29 C2, C3, C6)

**Qué dice hoy el texto:**
- Cuadro de aristas por sistema (`5-Analisis-Red-Actual/5-2-Grafo-Topologico.tex:78-86`): Metro 528, total 25,197.
- Distribución modal: 7 % estructurada / 93 % compartida.
- §5.5.2 (`5-Analisis-Red-Actual/5-5-Fase3/5-5-2-Centralidad.tex:74`): 528/25,197 = 2.1 %.

**Preguntas:**
1. ¿Cuántas aristas de servicio tiene cada uno de los 11 sistemas en la corrida vigente?
2. ¿Siguen subrepresentados Tren Suburbano y Cablebús (nota ‡)? ¿Cuántas aristas y cuántas estaciones tiene cada uno?
3. ¿Qué sistemas cuentan como derecho de vía exclusivo o confinado para el porcentaje? Hoy son Metro, Metrobús, Tren Ligero, Cablebús, Suburbano, Mexibús y Mexicable.
4. ¿Hubo cambios en nodos fantasma, redundancias o entidades descartadas que afecten la nota † (fecha de ingesta)?

**Cómo se resuelve:** se actualiza el cuadro, se recalculan el 7/93 % y el 2.1 % con la nueva base y se declara esa base. Si la subrepresentación ya se corrigió, se elimina la nota ‡.

---

## P2. Cobertura C con 76 municipios — §5.3.2 (#28 M4)

**Qué dice hoy el texto (`5-Analisis-Red-Actual/5-3-Fase1/5-3-2-Cobertura.tex:22-24`):** 16 alcaldías + 125 municipios = 141 demarcaciones. La tabla de extremos (líneas 210-230) incluye Tonanitla, Capulhuac, Calimaya, Donato Guerra y Ayapango, todos con C = 0 %.

**Preguntas:**
1. ¿Qué capa usas para la ZMVM oficial (SEDATU-CONAPO-INEGI) y de qué año? ¿Son 16 + 59 + 1?
2. ¿Cuánto vale C con los 76 municipios: global, CDMX y municipios conurbados?
3. ¿Qué 5 demarcaciones quedan con menor cobertura en CDMX y cuáles en municipios? Necesito área total, área cubierta y C (%).
4. ¿El 4.4 % del Espectro MJG (`5-Analisis-Red-Actual/5-6-Espectro-MJG/5-6-2-Espectro.tex:96`) se calculó con 141 o con 76 demarcaciones? ¿Cuánto vale con 76?
5. ¿Hay que regenerar el mapa de cobertura y las gráficas de Tableau de §5.3.2 con el nuevo dominio? ¿Cuáles?
6. ¿Algún municipio de los 76 sigue con C = 0 %?

**Cómo se resuelve:** se cambia el dominio en el texto (76 + 16 = 92 demarcaciones) con su fuente oficial, se rehace la tabla de extremos y se actualiza C en §5.6 y en el Espectro. Si el valor normalizado cambia, también puede cambiar la banda.

---

## P3. Fuerza Capilar FC / FC_H — §5.3.3 y §5.6 (#28 M6, #31 R2b)

**Decisión ya tomada (2026-10-11):** el Cap. 3 conserva la fórmula ponderada de Lee (2008) como definición general. Lo implementado es el caso w_ij = 1, que equivale al grado del nodo, y la ponderación pasa a trabajo futuro. El símbolo único en todo el documento será FC / FC_H.

**Qué dice hoy el texto:**
- Figuras de §5.3.3: corrida 2026-04-18.
- Espectro MJG: mediana 7.0 (Q1 = 6, Q3 = 10), valor normalizado 0.250, banda Débil.

**Preguntas:**
1. ¿Cambian con la corrida vigente la mediana, Q1 y Q3 de FC individual?
2. ¿Cuál es el top de nodos y de Macro-Hubs por FC_H, con sus valores?
3. ¿Qué porcentaje de las aristas de transbordo une paradas del mismo sistema, desglosado por sistema? Una nota de una sesión anterior menciona 49.3 % (RTP/CC); necesito saber si esa cifra corresponde a la corrida vigente.
4. ¿FC_H sigue usando un radio de 100 m?
5. ¿Hay que regenerar las 3 figuras de §5.3.3 (gráfica, mapa y dashboard)?

**Cómo se resuelve:** se actualizan las cifras y se justifica el porcentaje de transbordos dentro del mismo sistema como decisión del modelo. Esto resuelve M6 y R2b a la vez.

---

## P4. Factor de Desviación DI — §5.3.4 (#28 M7)

**Qué dice hoy el texto (corrida 2026-04-27, `5-Analisis-Red-Actual/5-3-Fase1/5-3-4-FactorDesviacion.tex`):**
- 100 pares, semilla 42; media 1.545, mínimo 0.97, máximo 4.34.
- Mejor caso: Plutarco Elías Calles → Fuente de Loreto (0.97).
- Peor caso: Carlos A. Vidal → 20 de Noviembre (4.34).
- Hay un cuadro de 12 casos de estudio y 5 figuras.

**Preguntas:**
1. Con el Fix #22, ¿cuáles son media, mediana, desviación, mínimo, máximo y percentiles? ¿Con qué muestra y qué semilla?
2. ¿Qué pares son ahora el mejor y el peor caso?
3. ¿Se recalculó el cuadro de 12 casos de estudio? ¿Cuánto vale cada DI?
4. ¿La mediana de 1.43 del Espectro, normalizada a 0.713, viene de la corrida antigua o de la nueva?
5. ¿Cómo describimos el Fix #22: qué estaba mal en `dist_acumulada` y qué se cambió? Lo pide la nota metodológica de M7.
6. ¿Existe ya el cuadro de DI por alcaldía con n (VFTModel #31) o queda fuera?
7. ¿Hay que regenerar las 5 figuras de §5.3.4?

**Cómo se resuelve:** se actualizan las cifras y se agrega una nota que explique que la versión anterior subestimaba el DI y cómo se corrigió. Se revisa además si cambia la banda de DI en §5.6, y el valor 4.34 citado en `5-6-2-Espectro.tex:204`.

---

## P5. Velocidades por sistema, Cuadro 5.3 — §5.3.1 (#29 C4)

**Qué dice hoy el texto (`5-Analisis-Red-Actual/5-3-Fase1/5-3-1-Impedancia.tex:39-49`):**
- Metrobús y Mexibús: 16.3 → 14.1 km/h.
- RTP: 14.0 → 8.0 km/h, marcado «Revisar».
- Corredores Concesionados y Pumabús: 11.0 → 8.0 km/h.
- Trolebús: 18.0 → 13.0 km/h, marcado «Límite».

El revisor señala que con CF = 1.000 Metrobús debería dar 16.3 km/h, y que el modelo ya usa 20 km/h para RTP y 16 km/h para CC.

**Preguntas:**
1. En la corrida vigente, ¿qué velocidad base, CF y velocidad efectiva tiene cada uno de los 11 sistemas?
2. ¿Qué tipo de derecho de vía (exclusivo, mixto…) y qué α tiene cada sistema?
3. ¿Los rangos esperados se mantienen? ¿De qué fuente salen?
4. ¿Cómo se calcula la velocidad efectiva: V/CF, promedio de segmentos o mediana? Necesito el método exacto para describirlo.
5. ¿Hay que regenerar `Figures/Cap5/fig01_impedancia.png`?

**Cómo se resuelve:** se reemplaza el cuadro y se explica el cálculo. Si algún sistema queda fuera de su rango, se declara y se justifica, o se ajusta el rango con su fuente.

---

## P6. Supuestos α y β — §5.4.1 (#28 M10)

**Qué dice hoy el texto (`5-Analisis-Red-Actual/5-4-Fase2/5-4-1-CoeficienteFriccion.tex:18`):** β_ZMVM = 0.759, con cita `tomtom2024`, y «cuatro valores de α».

**Preguntas:**
1. ¿De qué edición del TomTom Traffic Index sale β (año de los datos y año de publicación)?
2. ¿Qué métrica exacta es: *congestion level*, tiempo extra por cada 10 km u otra? ¿Cómo se convierte en 0.759?
3. ¿Cuáles son los cuatro valores de α y a qué tipo de vía corresponde cada uno?
4. ¿De dónde salen los α? Se declaran como supuestos del autor; ¿hay algún criterio de apoyo?
5. ¿Hay ya resultados de sensibilidad de T y B(v) ante α y β (VFTModel #30), o eso va a trabajo futuro?

**Cómo se resuelve:** se reescribe la cita de TomTom con año y métrica, se presentan los α como supuestos con su criterio y se agrega la sensibilidad, ya sea con resultados o como trabajo futuro.

---

## P7. Tiempo de viaje T frente a la ENOE — §5.5.1 (#28 M11; #30 G2)

**Qué dice hoy el texto:** T = 108.92 min (corrida 2026-09-02, 10,561 nodos, 251.8 s) frente a «aproximadamente 85 min» de la ENOE.

**Preguntas:**
1. ¿Cambia T con la corrida vigente? Necesito valor, número de nodos y tiempo de cómputo.
2. ¿Qué dato de la ENOE es el de 85 min: trimestre y año, tabulado o cuadro exacto, y si es solo ida o ida y vuelta?
3. ¿El dato de la ENOE se refiere solo a la ZMVM o a otra cobertura geográfica?
4. Para G2: ¿la Fig. 5.15 se va a regenerar con la etiqueta «Promedio observado ENOE»?

**Cómo se resuelve:** se pone la cita completa de la ENOE y se declara que el T ponderado por la EOD queda fuera (decisión P-5). Si T cambia, cambian también §5.5.3 (E₀ = 1/T) y el Espectro.

---

## P8. Intermediación B(v): figura frente a cuadro — §5.5.2 (#29 C8)

**Qué dice hoy el texto:**
- Cuadro `tab:bv-top10` (corrida 2026-09-02): Tacubaya 0.2179.
- Según el revisor, la figura `Grafica_VFTModel_2026_Centralidad_Intermediacion_Nodos` marca Tacubaya 0.3216, Zapata 0.2565 frente a 0.1283 en el cuadro, y Chabacano 0.2602, que no aparece en el cuadro.

**Preguntas:**
1. ¿De qué corrida sale la figura?
2. ¿La figura agrega por hub (suma de B(v) de los nodos de un complejo), suma sistemas, o es por nodo individual?
3. ¿Cuál es el top 10 por nodo en la corrida vigente (nombre, sistema, alcaldía, B(v))?
4. Si la figura agrega: ¿con qué radio y qué regla? ¿Cuál es el top 10 agregado?
5. ¿Cambia el Gini de B(v) (0.789, normalizado 0.211)?
6. ¿Hay que regenerar las figuras de §5.5.2 (por sistema, mapa y dashboard)?

**Cómo se resuelve:**
- (A) Se regenera la figura por nodo para que coincida con el cuadro.
- (B) Se conserva la figura agregada, se declara la regla de agregación en el pie y el texto, y se añade el top agregado.

---

## P9. Vulnerabilidad ΔE y E₀ — §5.5.3 (#28 M13 y M11 del Cap. 3)

**Qué dice hoy el texto (`5-Analisis-Red-Actual/5-5-Fase3/5-5-3-Vulnerabilidad.tex`, corrida exploratoria 2026-09-02):**
- E₀ = 1/108.92, E_f = 1/T_f.
- Tacubaya: B(v) 0.2179, T_f 111.80, ΔE 2.58 %.
- Se remueve un nodo a la vez.

**Preguntas:**
1. ¿Se va a calcular la eficiencia global de Latora-Marchiori (promedio de 1/d_ij) o se conserva 1/T? Si se calcula: ¿cuánto vale E₀ y cuánto vale E_f por nodo removido?
2. ¿Hay corrida con remoción del macro-hub completo (radio 100 m)? ¿Con qué resultados por hub?
3. ¿Hay conteo de pares desconectados tras cada remoción?
4. ¿Cambian T_f y ΔE de los nodos del cuadro con la corrida vigente?
5. ¿Las partes (1) y (2) de M13 entran antes del 15 de octubre, o se declaran como trabajo futuro (VFTModel #5)?

**Cómo se resuelve:**
- (A) Con los datos nuevos se actualiza el cuadro, se cambia la definición de E₀ en el Cap. 3 y en el Cap. 5 y se agregan los pares desconectados.
- (B) Sin datos nuevos se conserva 1/T, declarada como aproximación, y (1) y (2) pasan a trabajo futuro.

En ambos casos, la parte (3) de M13 (B(v) no predice ΔE) se redacta con las cifras finales.

---

## P10. Espectro MJG — §5.6.2 (#29, agregado final)

**Qué dice hoy el texto (`5-Analisis-Red-Actual/5-6-Espectro-MJG/5-6-2-Espectro.tex:94-108`):**

| Dimensión | Valor | Normalizado | Banda |
|---|---|---|---|
| C | 4.4 % | 0.055 | Crítico |
| FC (hoy C_i) | — | 0.250 | Débil |
| DI | — | 0.713 | Aceptable |
| T | — | 0.748 | Aceptable |
| B(v) | — | 0.211 | Crítico |

- Mapas: corrida 2026-09-24.
- Línea 138: «125 municipios».

**Preguntas:**
1. Con los valores de P2, P3, P4, P7 y P8, ¿cuánto vale cada dimensión, bruta y normalizada, y en qué banda queda?
2. ¿Las referencias de normalización (umbrales, ENOE, cotas) se mantienen o cambian?
3. ¿Hay que regenerar las figuras del Espectro (barras, mapas por dimensión y dashboards)?

**Cómo se resuelve:** se actualizan la tabla y la narrativa de §5.6. Si alguna dimensión cambia de banda, se reescribe la lectura del perfil.

---

## Figuras por regenerar (confirmar cuáles)

- Las que cambian de corrida o de dominio: §5.3.1, §5.3.2, §5.3.3, §5.3.4, §5.5.2 y §5.6.
- Los pendientes del #30: G1 (sin INTERURBANO), G2 (ENOE) y G3 (leyenda «isócronas» del mapa de cobertura).

**Pregunta:** ¿el agente de cartografía puede entregar, para cada figura, el nombre de archivo, la corrida que usó y los valores visibles, para revisar que el pie y el texto coincidan?
