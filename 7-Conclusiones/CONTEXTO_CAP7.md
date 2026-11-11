# CONTEXTO_CAP7 — Capítulo 7: Conclusiones (Issue #23)

Documento de trabajo interno, no se compila. Reúne la estructura aprobada, el
hilo conductor y los hallazgos que entrarán al capítulo.

> **Estado (2026-11-04):** ✅ capítulo completo: entrada (3 párrafos), 7.1, 7.2
> y 7.3; repaso de transiciones hecho (sin cambios), `\termino{feeds}` en 7.1/7.3
> y 7.3 P1 sin repetir 53.52/3.92 %. ~2,600 palabras (D7-3: sin recorte).
> Listo para cerrar #23. Pendiente externo: #34 puede cambiar «76 demarcaciones»
> y «diez… 21 nodos» de 7.3 P1. Ver §10 (bitácora) y §11 (retomar aquí).
>
> **Actualización (2026-11-11):** #23 cerrado; el capítulo está en el borrador Alfa
> (release `v-alfa`, commit 01258d6). #34 quedó fuera de alcance, así que «76
> demarcaciones» se conserva. Las marcas ⏳ de abajo (p. ej., «falta la entrada» en
> §1 y §3) son de la bitácora: la entrada ya está redactada.

- **Fecha de apertura:** 2026-11-03
- **Archivo padre:** `7-Conclusiones/1-Conclusiones.tex` ✅ (encabezado,
  `\chapter`, `\label{ch:conclusiones}`, la entrada como comentario pendiente
  y los tres `\input` activos)
- **Cifras:** corrida vigente «Corrida: 2026-10-04» (VFTModel `4ef4265`). No
  usar las de septiembre: T = 108.92, Tacubaya −28.5 %, Gini 0.7891.

---

## 0. Decisiones del autor (2026-11-03)

| # | Decisión |
|---|---|
| D7-1 | **Se combinan las dos estructuras**: la del asesor (#23: resumen · contribuciones · trabajo futuro) y los tres ejes del autor (tecnológico · urbano · académico/investigación). |
| D7-2 | **Hilo conductor: «lo que se mide define lo que se construye».** |
| D7-3 | La extensión de 1–2 pp que dio el asesor es una **recomendación**, no un límite. Se busca que quede breve, pero sin dejar fuera hallazgos. |
| D7-4 | **#34** (dominio solo CDMX) queda **fuera por ahora**; se atiende en la versión final del documento. Mientras tanto, las conclusiones usan el dominio vigente (76 demarcaciones de la ZMVM). |
| D7-5 | (2026-11-03) Se cambia el orden de §9: primero el padre y 7.1, luego 7.2 y 7.3; la entrada al final. |
| D7-6 | (2026-11-03) En 7.1 no se mencionan TransCAD ni NAVTEQ (no verificados): en 1985 «se hizo con otras tecnologías, las de su momento». |
| D7-7 | (2026-11-03) En 7.2 quedan fuera Moscú/Melbourne, los \$408 M de 1958 y el 92.7 % de superficie; «dos ejes, red menos frágil» solo como pendiente. |
| D7-8 | (2026-11-03) Las cifras de la pregunta de investigación ($T$ −4.1/−10.1 %, oriente y sur) van en 7.2; **la entrada solo da el veredicto** y remite a `sec:conclusiones-urbano`. |
| D7-9 | (2026-11-04) Título de 7.3: «Eje Académico y Trabajo Futuro». La Clasificación Garibelt se presenta como **instrumento a desarrollar** para clasificar redes heterogéneas, y se agrega como trabajo futuro **medir otras redes del país y de otros países** para comparar (hoy: una red real frente a casos hipotéticos). |
| D7-10 | (2026-11-04) Sin mención al IGISC 2026 y sin nombrar ciudades concretas en la comparación (sería especulativo). |

Flujo de redacción (sin cambios respecto al Cap. 6): una parte a la vez, con
1 opción (o 2–3 si hace falta) por párrafo y su score IA (nada ≥ 0.20). Se
espera aprobación antes de escribir. Los `.tex` se escriben con Edit/Python,
nunca con `cat >>`. El autor compila y hace los commits, sin Co-Authored-By.
Por #33 se usan intervalos o el número, no «Crítico/Débil/Aceptable/Idóneo».

---

## 1. Estructura de archivos (✅ creada)

```
7-Conclusiones/
├── 1-Conclusiones.tex          ✅ 24 líneas · ⏳ falta la entrada (resumen + contraste)
├── 7-1-Eje-Tecnologico.tex     ✅ 68 líneas · «Eje Tecnológico: un Instrumento para Medir la Estructura»
├── 7-2-Eje-Urbano.tex          ✅ 93 líneas · «Eje Urbano»
└── 7-3-Eje-Academico.tex       ✅ 82 líneas · «Eje Académico y Trabajo Futuro»
```

Este plan reemplaza el anterior de `CONTEXTO_CAP6.md` §0 (7-1-Resumen,
7-2-Contribuciones, 7-3-Trabajo-Futuro).

Correspondencia con la estructura del asesor:

| Parte del asesor (#23) | Dónde queda |
|---|---|
| 1. Resumen del trabajo y resultados principales | Entrada del capítulo, en `1-Conclusiones.tex` (contraste con la pregunta, la hipótesis y los objetivos) |
| 2. Contribuciones (aporte original) | El bloque «Aporte» de cada eje (7.1, 7.2, 7.3) |
| 3. Trabajo futuro (nivel doctoral) | Se reúne en 7.3; 7.1 y 7.2 solo dejan sus pendientes como puente hacia 7.3 |

Esquema interno de cada eje (el mismo en los tres):
**qué se hizo o encontró → qué aporta → qué queda pendiente** (y la
transición al eje siguiente).

---

## 2. Hilo conductor: «lo que se mide define lo que se construye»

**Base en la tesis:** §6.5.2, `subsubsec:anillo-pm-2010`. El Programa Maestro
del Metro (DDF/COVITUR, 2.ª revisión de 1985, `ddf1985programa`) eliminó el
Periférico Poniente (simulación 3) y el Periférico Oriente (simulación 4)
porque no alcanzaban la captación que pedía una «red equilibrada». Sus nueve
parámetros (`tab:anillo-pm-parametros`) salen de la demanda de 1983; ninguno
mide la dependencia de la red respecto de unos cuantos nodos ni la unión
lateral de la periferia, y el más cercano, la redundancia, pesa 9.33 %. La
frase clave del texto es: «la evaluación no tenía forma de medir lo que el
anillo aportaba a la estructura de la red». Aquella evaluación midió la
demanda y no la estructura; esta tesis mide la estructura y deja fuera la
demanda.

**Cómo atraviesa los tres ejes:**

1. **Tecnológico, el instrumento:** sin herramientas que midan la estructura,
   la estructura no entra en la decisión. La cadena abierta `Apímetro` →
   `VFTModel` → `Transport-gis-zmvm-mjg` permite medirla con datos públicos y
   sin *software* propietario.
2. **Urbano, lo medido:** con esa medición aparecen cosas que la captación no
   veía: la red depende del centro (Tacubaya), cubre poco fuera de él, y un
   anillo a velocidad de Metro acorta los viajes de la periferia y saca del
   centro parte de la intermediación, aunque no reparta la carga ni amplíe la
   cobertura.
3. **Académico, lo que falta medir:** demanda, población, costo, condiciones
   físicas y contingencias. La agenda es juntar los dos enfoques, estructura
   y demanda, en un mismo modelo.

**Línea secundaria (refuerzo social, opcional):** Gurstein (§2.5,
`subsec:datos-comunidad-equidad`) sostiene que los datos abiertos solo
empoderan a quien puede procesarlos. Los «ciudadanos de tercera clase» de
Rendón (§5.6, `subsubsec:espectro-cierre`) viven en la periferia que la red
atiende peor. Lleva la desigualdad de acceso a la red a una desigualdad de
acceso al diagnóstico, y une el eje tecnológico con el urbano.
⚠️ La idea de que la periferia también es la peor documentada en los datos
(GTFS del Edomex, #35 L6) **no está escrita así en la tesis**; si se usa, hay
que formularla con cuidado.

**Cierre posible del capítulo:** volver a 1985. Los dos enfoques no compiten.
La pregunta que llevó a descartar el anillo, cuánta gente lo usaría, sigue
abierta, y responderla junto con la estructura es el trabajo que sigue.

---

## 3. Entrada del capítulo: resumen y contraste — ⏳ PENDIENTE (otra sesión)

### 3.1 Resumen del trabajo (1 párrafo)

- **Problema:** red radial-concéntrica, fragmentación de la periferia
  (Padilla, Ortiz «patchwork of offset grids», Molinero), un Periférico hecho
  para el automóvil y sin transporte masivo (Cap. 1 y 2).
- **Herramienta:** tres capas abiertas (Cap. 4), ocho indicadores y la
  Clasificación Garibelt (Cap. 3).
- **Aplicación:** diagnóstico de la red actual con el Espectro MJG como línea
  base (Cap. 5) y tres casos (1 = red actual; 2 = Anillo MB; 3 = Anillo Metro)
  sobre el Anillo Periférico Interior (API-I), con 94 estaciones (Cap. 6).

### 3.2 Contraste con la hipótesis (`sec:hipotesis`)

La hipótesis tiene tres afirmaciones; **no se modifica**, solo se contrasta
(decisión del 2026-10-24).

| Afirmación | Resultado | Fuente |
|---|---|---|
| (a) La red radial-concéntrica genera vulnerabilidades cuantificables: $B(v)$ alta en el núcleo | ✔ Tacubaya 0.2232, Mixcoac 0.1923, Hidalgo 0.1515; Gini 0.8007 | `subsec:fase3-centralidad` |
| (a) $DI$ alto en los contornos periféricos | ⚠️ Mediana de 1.52 (100 pares: media 1.70, máximo 4.42). **Verificar** con los casos de `subsubsec:di-casos` si el $DI$ alto se concentra en la periferia antes de afirmarlo | `subsec:factor-desviacion` |
| (a) $T$ > 122 min en el Cuarto Contorno | ⚠️ El modelo da $T$ = 113.91 min de promedio para toda la red; no se puede comparar directamente con la cifra de SEMOVI (85–180 min es un supuesto del autor, D7 de la Rev-2) | `subsec:tiempo-viaje-promedio` |
| (b) La metodología permite cuantificarlas | ✔ Cadena completa y replicada en 3 escenarios | Cap. 4, §6.2 |
| (c) El anillo reduce $T$ | ✔ −4.1 % (Caso 2: 108.99 min) y −10.1 % (Caso 3: 101.92 min) | `subsec:anillo-tiempo-viaje` |
| (c) El anillo reduce $B(v)$ | ◐ Tacubaya −3.1 % / −29.7 %, pero el Gini **sube**: 0.8012 / 0.8134 | `subsec:anillo-centralidad` |
| (c) El anillo reduce $DI$ | ✖ No evaluable: $DI$ se calculó solo para la red actual (decisión C6-8) | §6.3 |
| **Veredicto** | **Confirmación parcial**: baja el tiempo y sale del centro parte de la intermediación (sobre todo en el Caso 3), pero no se reparte la concentración ni crece la cobertura | `tab:anillo-sintesis` |

### 3.3 Pregunta de investigación (`subsec:pregunta`)

- **«¿Cuánto mejoraría la conectividad periférica…?»** $T$ baja 4.1 % y
  10.1 %. El oriente metropolitano (Nezahualcóyotl, Chimalhuacán, Ecatepec)
  gana entre 30 y 60 min con los dos casos; el sur (Tlalpan, Xochimilco,
  Tláhuac, La Magdalena Contreras) gana 6–7 min con el Caso 2 y 15–27 min con
  el Caso 3. La cobertura casi no cambia (13.29 → 13.43 %).
- **«¿En qué grado el modelado… puede anticipar y cuantificar ese escenario?»**
  Anticipa y cuantifica la **estructura**: por dónde pasan los caminos más
  cortos y cuánto duran. No anticipa demanda, costo, condiciones físicas ni
  contingencias (`subsec:corredor-anillar-limitaciones`).
- **Pregunta secundaria 1 (dependencia de los hubs y robustez):** respondida
  en parte. La dependencia tiene nombre (Tacubaya y el corredor de Garibaldi a
  Barranca del Muerto). ΔE es solo exploratorio (corrida del 09-02) y la idea
  de que «dos ejes serían menos frágiles» es una hipótesis, porque no se
  simularon cierres (§6.5.2).
- **Pregunta secundaria 2 (conexión lateral y tiempos):** respondida en el
  modelo. Cuando el anillo da un enlace lateral, los tiempos bajan más donde
  la red ofrecía menos caminos (§6.5.1). Queda sin saber cuántas personas
  viven cerca, porque $T$ no pondera por población.

### 3.4 Objetivos específicos (`subsec:obj-especificos`)

| Obj. | Cumplimiento |
|---|---|
| 1. Sistematizar los GTFS y construir el grafo | ✔ 12 sistemas, 141 demarcaciones; 11,115 nodos y 45,517 aristas; componente gigante del 95.46 % |
| 2. Calcular $DI$, $T$, $C$ y $FC$ | ✔ |
| 3. Nodos críticos con $B(v)$ y $\Delta E$ | ◐ $B(v)$ completo; $\Delta E$ solo exploratorio, sin corrida vigente (#39) |
| 4. Zonas con mayor déficit ($C$, $FC$) | ✔ 42 de 60 municipios en 0 % de cobertura; red mayormente monocapilar |
| 5. Simular los Casos 2 y 3 | ✔ con $C$, $FC$, $T$ y $B(v)$; ✖ sin $DI$ |

---

## 4. Eje 1 — Tecnológico (`7-1-Eje-Tecnologico.tex`) — ✅ REDACTADO 2026-11-03

**Papel en el hilo:** el instrumento que hace medible la estructura.

### 4.1 Qué se hizo

- **Tres capas interdependientes** (`sec:filosofia-arquitectura`, figura
  `macro-arquitectura-stack`):
  - `Apímetro` (Go, SQL): ingesta y ETL. Normaliza fuentes dispersas (12
    sistemas, 141 demarcaciones) en un solo formato. Funciona como servicio de
    datos (SaaS: no procesa dos veces) y entrega GeoJSON y una ficha técnica
    JSON (`sec:apimetro-intro`).
  - `VFTModel` (Python, NetworkX, Pydantic): grafo topológico, Haversine,
    *snapping* lógico, ecuación VFT (impedancia con $CF$ y $T_b$) y 8
    indicadores; salidas JSON y GeoJSON por endpoints (`sec:vftmodel-intro`,
    `sec:vft-salidas`).
  - `Transport-gis-zmvm-mjg`: QGIS y *dashboards* de Tableau
    (`sec:transport-gis`).
- **Replicabilidad demostrada en el Cap. 6:** la misma cadena procesó tres
  escenarios sin cambiar el código. Para el anillo bastó una migración SQL en
  `Apímetro` (`v4.0_anillar_mb.sql`) y un contenedor Docker por escenario,
  aislados entre sí (`subsec:anillo-procesamiento`).

### 4.2 Qué aporta

- **Soberanía tecnológica:** alternativa a TransCAD y NAVTEQ, cuyas licencias
  y opacidad algorítmica son barreras para los organismos locales. Se apoya en
  OSM y en los principios de la FSF (`sec:filosofia-arquitectura`).
- **Bien público tecnológico:** BSL 1.1, con paso a Apache 2.0 en abril de
  2029; wiki, foro, `seed.sql` y Docker Compose para el urbanista sin
  formación en programación (`subsec:futuro-apimetro`).
- **Integración de datos:** la Tarjeta MI (2019) integró la **tarifa**, pero
  no los **datos**; cada sistema publica con su propio estándar.
  `Apímetro` cubre esa integración que faltaba (`subsubsec:espectro-cierre`).
- **Evaluación previa a la obra:** con los mismos cálculos se pueden comparar
  corredores y estimar el efecto de una ruta nueva antes de construirla
  (`sec:vft-salidas`).
- **Mediación entre datos y planificadores** (Gurstein, Barrington-Leigh):
  replicable en cualquier ciudad con GTFS y cartografía de base
  (`subsec:datos-herramienta-replicable`).
- **Apuesta del autor (§5.6):** Python, Go y SQL como soporte de conceptos
  matemáticos en el análisis urbano; ningún indicador aislado da un
  diagnóstico integral.

### 4.3 Qué queda pendiente (límites técnicos que se declaran y pasan a 7.3)

- $T_b$ fijo (FALLBACK/2), no por intervalo de cada sistema (#32).
- El *snapping* por sistema (KDTree de 50 m) mezcla paradas entre líneas MB
  existentes y el anillo en el Caso 2; por eso 13 nodos tienen $FC$ distinta
  entre los casos.
- Grafo simple: 5,552 aristas de servicio reemplazadas por transbordos (D9).
- Velocidades tomadas de `Apímetro`, sin contraste con velocidades observadas
  (`subsec:validacion-impedancia`).
- El campo de capacidad existe en el esquema, pero `VFTModel` no lo usa.
- $\Delta E$ sin corrida vigente (VFTModel #5).
- El Interurbano tiene 5 nodos y ninguno en la componente gigante.
- Posible registro defectuoso: el nodo MB «314 Memorial New's Divine».

**Transición al eje 2:** con el instrumento listo, ¿qué muestra la medición
sobre la red?

---

## 5. Eje 2 — Urbano (`7-2-Eje-Urbano.tex`) — ✅ REDACTADO 2026-11-03

**Papel en el hilo:** lo que la medición de la estructura revela y que la
captación por corredor no registraba.

### 5.1 Diagnóstico de la red actual (Cap. 5, línea base)

- **Patrón estructural: eficiencia interna, exclusión perimetral.** $T$ y $DI$
  salen razonables y $C$ y $B(v)$ salen bajos. La red no tiene un problema de
  operación sino de distribución (`subsubsec:espectro-cierre`).
- **Cobertura:** 13.29 % de la ZMVM (normalizado 0.1661); 53.52 % en la CDMX
  frente a 3.92 % en los municipios; 42 de 60 municipios en 0 %
  (`subsec:cobertura-espacial`).
- **Fuerza Capilar:** mediana de 7 (Q1 6, Q3 10), justo en el corte; red
  mayormente monocapilar. El 49.3 % de los transbordos une paradas del mismo
  sistema (`subsec:fuerza-capilar`).
- **Composición modal de los nodos:** RTP, CC, Trolebús y Pumabús suman el
  92.71 %; el Metro, el 2.11 %.
- **Tiempo de viaje:** $T$ = 113.91 min (0.6957). ⚠️ *Corrección:* 108.99 y
  101.92 son los $T$ de los Casos 2 y 3, no de la red actual.
- **Intermediación:** Tacubaya concentra la mayor; Gini de 0.8007. Los nodos
  de banda dominante más alta dibujan un corredor de Garibaldi a Barranca del
  Muerto.
- **Lectura social:** tres contornos de acceso; los «ciudadanos de primera,
  segunda y tercera clase» de Rendón (`rendon2009ciudadanos`), donde la clase
  la define el transporte más próximo; la **pobreza de tiempo**
  (`gaceta_cuidados_2026`): en el tercer contorno el traslado es lo que se
  come el margen de descanso y cuidado.
- **El espectro como paso previo a la decisión:** sobre la ZMVM no caben
  términos absolutos; la red es eficiente y deficiente según la parte del
  territorio y el grupo de usuarios.

### 5.2 El escenario del anillo (Cap. 6)

1. **Acercar no es conectar** (`subsec:anillo-conclusiones-contornos`). $C$
   pasa de 13.29 a 13.43 % en los dos casos y los 41 municipios sin parada
   caminable siguen igual. El anillo mejora la conexión de quienes ya están
   cerca de la red: el oriente gana entre 30 y 60 min con los dos casos y el
   sur solo con el Metro (15–27 min).
2. **De red radial a anillo-radial, sin desconcentrar**
   (`subsec:anillo-conclusiones-centralidad`). Caso 2: Tacubaya −3.1 % y el
   top 10 sigue en el centro. Caso 3: Tacubaya −29.7 % y 9 de los 10 primeros
   nodos están en el anillo (Iztapalapa, Álvaro Obregón, Xochimilco,
   La Magdalena Contreras). El Gini sube a 0.8134: **la concentración cambia
   de lugar, no se reparte**. Hay dos ejes (el central y el arco sur-oriente).
   Se interpreta con Moscú (descargar las radiales) y Melbourne (unir el
   *Middle-Ring*); ambos son ferroviarios, coherente con que solo el Caso 3
   reproduzca su efecto.
3. **CETRAM de nueva generación** (`subsec:anillo-conclusiones-cetram`). Seis
   estaciones: Periférico Oriente/Tláhuac, Constitución de 1917, Canal
   Nacional, Rómulo O'Farril, Barranca del Muerto y Luis Cabrera. Tienen
   $B(v)$ de 0.12 a 0.16 (cerca de Tacubaya) y $FC$ de 6 a 12. Por ellas
   pasarían muchos caminos, pero llegan pocas rutas. Recomendación:
   alimentadoras, espacio para transbordar entre RTP, CC y el anillo, y
   accesos de última milla. Es lo contrario de los CETRAM actuales (muchas
   rutas, poca intermediación) y, a diferencia de Pantitlán o Indios Verdes,
   se pensarían para el viaje lateral.
4. **Modo y derecho de vía: el Caso 3 es el más favorable**
   (`subsec:anillo-conclusiones-modo`). El Anillo MB (~14 km/h) le gana a la
   RTP del Periférico (8 km/h con $CF$ 1.380), pero no al Metro: toma el papel
   de la RTP. El Anillo Metro (36 km/h) compite con las radiales y cambia la
   jerarquía de la red.
5. **Lectura histórica.** El Periférico de Uruchurtu se hizo para el coche,
   con un sesgo presupuestal (\$408 millones en vialidades en 1958,
   `subsec:sesgo-vial`), cuando el Metro se rechazó por costoso
   (`subsec:rechazo-metro`). Esa misma vialidad es la que mejor alojaría un
   transporte masivo lateral con vía exclusiva.
6. **Programa Maestro de 1985** (`subsubsec:anillo-pm-1980`, `-2010`): ya
   tenía líneas sobre el Periférico (lugares 17 y 33 de 34 corredores) y las
   descartó por captación. El límite del D.F. dejó el intercambio modal en la
   frontera política; el API-I lo pondría sobre el anillo. **Aquí aparece de
   nuevo el hilo conductor.**
7. **El Periférico ya no es la periferia** (`subsec:corredor-anillar-limitaciones`,
   punto 3). Con el crecimiento disperso (desarrollo saltón, `fig:sprawl`), el
   API-I marca el borde del Primer y Segundo Contorno (`fig:semovi-contornos`).
   La periferia actual pide un Anillo Exterior (pasa a 7.3).

### 5.3 Qué aporta (contribución urbana)

- Un diagnóstico multidimensional de la red metropolitana completa, con CDMX
  y Edomex juntos, como línea base pública y reproducible.
- Pasar de «falta transporte en la periferia» a una descripción precisa:
  **qué** falta (cobertura y capilaridad, no velocidad) y **dónde** se
  concentra la dependencia.
- Evidencia de que el modo y el derecho de vía cambian el tipo de efecto, no
  solo su tamaño: la diferencia entre el Caso 2 y el Caso 3 es cualitativa.
- Recomendación concreta: estaciones del anillo planeadas como CETRAM.
- Dar una lectura técnica a la deuda histórica del Periférico (Cap. 2).

### 5.4 Qué queda pendiente (pasa a 7.3)

- Cuánta gente vive cerca y usaría cada estación; falta la dimensión social:
  población, ingreso, demanda.
- Costo de construir y operar cada opción.
- Condiciones físicas: pendiente, ancho, elevado o subterráneo.
- Contingencias: si los dos ejes de verdad hacen la red menos frágil.
- Los municipios sin cobertura (Anillo Exterior y última milla).

**Transición al eje 3:** lo que el modelo no mide define la agenda.

---

## 6. Eje 3 — Académico y Trabajo Futuro (`7-3-Eje-Academico.tex`) — ✅ REDACTADO 2026-11-04

**Papel en el hilo:** lo que falta medir, y cómo unir estructura y demanda.

### 6.1 Qué aporta (contribución metodológica original)

- **Clasificación Garibelt (método) y Espectro MJG (entregable)**
  (`subsec:clasificacion-garibelt`):
  - Evita el sesgo de compensabilidad (Hossain, Deng): un promedio esconde la
    dimensión que está mal (`subsubsec:garibelt-compensabilidad`).
  - Normaliza para calibrar, no para agregar (Kujala: perfil por ciudad, sin
    índice global; `subsubsec:garibelt-normalizacion`).
  - Banda dominante por nodo: intervalo del mínimo entre $FC$ y $B(v)$
    normalizadas (`subsubsec:garibelt-procedimiento`).
  - Línea base comparable entre escenarios (Cap. 5 → Cap. 6); 10 y 21 nodos
    cambian de banda en los Casos 2 y 3.
- **Lectura en dos registros, estructural y social** (§5.6): un puente entre
  el análisis de redes y el urbanismo crítico latinoamericano (Padilla,
  Rendón).
- **Complementariedad con la planeación por demanda:** la comparación con
  1985 muestra que medir la estructura deja ver efectos que la captación por
  corredor no podía registrar.
- **Difusión:** artículo enviado al IGISC 2026 (E-06/E-07; release
  `v1.0-igisc-2026`). ✖ No se menciona (D7-10).

### 6.2 Trabajo futuro (propuesta para nivel doctoral)

Se agrupa en tres líneas para que no quede como una lista suelta.

**A. Medir mejor lo que ya se mide (calibración y validación)**

1. Cobertura con isócronas peatonales sobre la red de OSM y población por
   manzana del Censo 2020, para pasar de superficie a población cubierta
   (#29 C7; `subsec:indicador-cobertura`, glosario VGI/OSM).
2. Calibrar $T_b$ con la Google Maps Directions API (`transit`, variando
   `departure_time`, en hora pico y valle) (#29 C8, #32).
3. Contrastar las velocidades de superficie con velocidades observadas por
   ruta (`subsec:validacion-impedancia`).
4. Validación externa de la Clasificación Garibelt: sensibilidad de los
   cortes, α y β (β con métrica TomTom, M10), intervalos (#33).
5. $FC$ contra el catálogo oficial de CETRAM (`subsec:fuerza-capilar`) y
   refinamiento de $FC$ (#7, 3-3-2).

**B. Medir lo que todavía no se mide (robustez y demanda)**

6. $\Delta E$ con la eficiencia global de Latora-Marchiori (promedio de
   $1/d_{ij}$), remoción de Macro-Hubs completos y corrida vigente
   (`subsec:robustez-geometrica`, `subsec:vulnerabilidad-estructural`).
   Ahí se comprobaría si la red anillo-radial es menos frágil.
7. Simular cierres y contingencias en $T$ y $B(v)$ (#35).
8. **Unir estructura y demanda:** afluencia, matrices O-D y captación junto
   con los indicadores topológicos. Es el enfoque de 1985 más el de esta
   tesis, y el núcleo de la propuesta doctoral.
9. Dimensión social de la propuesta: población, ingreso, demanda y costo
   (`subsec:corredor-anillar-limitaciones`, punto 2).

**C. Ampliar el territorio**

10. Anillo Periférico Exterior para la periferia actual de la ZMVM (punto 4
    de las limitaciones; requiere un estudio propio).
11. Completar el GTFS del Estado de México e integrar el Interurbano en la
    componente gigante (#35 L6).
12. Aplicar la cadena a otras ciudades con GTFS, que es la prueba externa de
    replicabilidad (`subsec:datos-herramienta-replicable`).

### 6.3 Cierre del capítulo

Volver al hilo: la tesis no sustituye la planeación por demanda, la
completa. Lo que se mide define lo que se construye, y la propuesta es medir
ambas cosas.

---

## 7. Lo que NO entra

| Elemento | Motivo |
|---|---|
| Hallazgo de transbordos a ≤ 85 m (solo 5 de 20 estaciones enlazan con sistemas estructurados) | Especulativo; decisión P-6 del autor |
| S5 «DI y T miden cosas distintas» | Perdió soporte al quitar $DI$ de los escenarios |
| Cifras de septiembre (T 108.92, Tacubaya −28.5 %, Gini 0.789/0.798) | Corridas obsoletas |
| Mapa de síntesis | Descartado para la versión Alfa |
| Afirmar que el modelo calcula capacidad o demanda | No lo hace |

## 8. Pendientes que pueden cambiar el texto (versión final)

- **#34** (dominio solo CDMX): ⚪ **fuera de alcance** (decisión del autor
  2026-11-04). Las cifras del Cap. 7 no cambian. La nota de restricción de datos
  y la mención como trabajo futuro pasan a #35.
- **#33:** redactar con intervalos o con el número, sin nombres de banda.
- **#39:** nombre del $DI$ (Cap. 3 «Índice de Ruta Directa» frente a Cap. 5
  «Factor de Desviación»); $\Delta E$ del objetivo 3.
- **#35:** limitaciones L5 (mismas estaciones en los dos casos), L6 (GTFS del
  Edomex) y contingencias.
- Verificar el «$DI$ alto en la periferia» en `subsubsec:di-casos` antes de
  escribir el contraste de la hipótesis.
- La cifra de 122 min (SEMOVI) solo se cita como dato del diagnóstico, no
  como contraste directo con $T$.
- (Opcional) Usar el nombre API-I de forma uniforme en todo el documento.

## 9. Orden de redacción (actualizado por D7-5)

1. ✅ Padre `1-Conclusiones.tex` y 7.1 Tecnológico (2026-11-03).
2. ✅ 7.2 Urbano (2026-11-03).
3. ✅ 7.3 Académico y Trabajo Futuro, con el cierre del hilo (2026-11-04).
4. ⏳ Entrada (resumen + contraste) en `1-Conclusiones.tex` → **otra sesión**.
5. ⏳ Repaso de transiciones entre la entrada y los ejes, y de extensión total.

---

## 10. Bitácora de redacción (lo que quedó en cada archivo)

Todos los párrafos se midieron con el texto envuelto a 80 columnas
(`/tmp/cap7/para_score.py`, recrear si no existe); ninguno ≥ 0.20.

**7.1 Tecnológico** (`sec:conclusiones-tecnologico`)

| P | Contenido | Score |
|---|---|---|
| 1 | 1985 descartó el Periférico por captación; «otras tecnologías, las de su momento»; el primer resultado es un instrumento | 0.121 |
| 2 | Tres capas: 12 sistemas, 141 demarcaciones; Tarjeta MI integró la tarifa, no los datos; grafo 11,115/45,517; QGIS y Tableau | 0.033 |
| 3 | Replicabilidad en el Cap. 6: mismo código, contenedores aislados; evaluar antes de construir | 0.122 |
| 4 | Aporte: GTFS en cualquier ciudad (Barrington-Leigh), BSL 1.1 → Apache 2.0 (2029), Gurstein, soberanía tecnológica | 0.122 |
| 5 | Límites: velocidades sin contraste, $\Delta E$ exploratorio, Interurbano fuera, mide estructura y no uso → 7.3 y 7.2 | 0.122 |

Fuera a propósito: $T_b$ fijo (#32), grafo simple (D9), nodo «Memorial», 13
nodos del *snapping*, «apuesta del autor» Python/Go/SQL, línea secundaria de
Gurstein sobre la periferia peor documentada.

**7.2 Urbano** (`sec:conclusiones-urbano`)

| P | Contenido | Score |
|---|---|---|
| 1 | Eficiencia interna / exclusión perimetral; $C$ 13.29 % (53.52 / 3.92; 42 de 60 en cero); mediana $FC$ 7; $T$ 113.91; Tacubaya 0.2232; Gini 0.8007 | 0.122 |
| 2 | Lectura social: tres contornos, Rendón, pobreza de tiempo; no cabe un juicio único | 0.122 |
| 3 | Acercar no es conectar: 13.29 → 13.43 %; 42 → 41 municipios (Texcoco); $T$ −4.1/−10.1 %; oriente 0.5–1 h; sur 6–7 vs 15–27 min | 0.033 |
| 4 | Radial → anillo-radial: Tacubaya −3.1/−29.7 %; Gini sube a 0.8134; modo 14 vs 36 km/h; Caso 3 más favorable | 0.033 |
| 5 | CETRAM de nueva generación ($B(v)$ 0.12–0.16; 6–12 conexiones); Periférico hecho para el coche; 1985 | 0.033 |
| 6 | Aporte urbano (3 puntos); pendientes; «el Periférico ya no es la periferia» → Anillo Exterior → 7.3 | 0.033 |

**7.3 Académico y Trabajo Futuro** (`sec:conclusiones-academico`)

| P | Contenido | Score |
|---|---|---|
| 1 | Aporte: Clasificación Garibelt para una red heterogénea (12 sistemas, 76 demarcaciones); compensabilidad (Hossain, Deng); Kujala; 10 y 21 nodos cambian de banda | 0.033 |
| 2 | L1 — consolidar Garibelt: cortes y cotas (DI 2.5 → 2.0), α y β, banda por nodo y $FC$ relativas; meta: ordenar varias redes | 0.033 |
| 3 | L2 — medir otras redes del país y de otros países (hoy una red real vs casos hipotéticos); Kujala 25 redes; referencia común para $FC$; probar replicabilidad | 0.122 |
| 4 | L3 — calibrar: isócronas OSM + Censo 2020, Google Maps para $T_b$, velocidades observadas, $FC$ ponderada (Lee) y CETRAM | 0.033 |
| 5 | L4 — doctorado: $\Delta E$ (Latora), demanda/población/ingreso/costo, Anillo Exterior, unir estructura + O-D | 0.122 |
| 6 | Cierre: 1985 preguntó por la demanda, la tesis por la estructura; «medir las dos cosas a la vez» | 0.143 |

Fuera a propósito: IGISC 2026, ciudades con nombre propio, lectura en dos
registros (ya implícita en 7.2 P2), GTFS del Edomex e Interurbano (#35, no
están en el cuerpo como trabajo futuro).

Verificación al cierre (2026-11-04): `checar-refs` 624 · 0 sin label;
`checar-bib` 86 · 0 sin entrada · 0 sin citar; `checar-etiquetas` 588 · 0
duplicados.

---

## 11. Retomar aquí: entrada del capítulo (otra sesión)

Va en `1-Conclusiones.tex`, entre `\label{ch:conclusiones}` y el primer
`\input` (hoy hay un comentario marcando el lugar). Material en §3.

- [x] **Antes de redactar:** verificar en `subsubsec:di-casos` si el $DI$ alto
  se concentra en la periferia (afirmación (a) de la hipótesis, §3.2).
  **Resultado (2026-11-04):** los $DI$ medios más altos son periféricos
  (Chimalhuacán 3.73, Tláhuac 3.26, Milpa Alta 3.13, Naucalpan 2.63,
  Nezahualcóyotl 1.98), pero con $n$ = 1–2 («solo indicativos»); los casos
  de Milpa Alta quedan en 1.42–1.61; destacan el Caso 9 (2.99) y el 7 (1.87),
  ambos sur-oriente. Redactar como **tendencia sobre pocas rutas**, no como
  resultado estadístico.
- [x] Resumen del trabajo en 1 párrafo (§3.1): problema → herramienta →
  aplicación. **✅ 2026-11-04, score 0.122.** Cita los seis capítulos con su
  `\label`; «Anillo MB / Anillo Metro», «solo cambian en la operación»
  (Caso 2 = Mexibús, 14.2 km/h; Caso 3 = 36 km/h); corredor con nombre
  completo, sin sigla API-I; «Medir eso pedía una herramienta propia» prepara
  el arranque de 7.1.
- [x] Contraste con la hipótesis (§3.2): confirmación parcial. Los 122 min de
  SEMOVI solo como dato del diagnóstico, no como contraste directo con $T$.
  $DI$ no evaluable en los escenarios (C6-8).
- [x] Pregunta de investigación (§3.3): **solo el veredicto** con remisión a
  §\ref{sec:conclusiones-urbano} (D7-8); las cifras ya están en 7.2.
  **✅ 2026-11-04 (P2, opción A, score 0.122):** hipótesis y pregunta en un
  solo párrafo, recorrido por las tres partes; 122 min de SEMOVI «no se
  pueden contrastar» ($T$ = 113.91 promedia la red); $DI$ periférico «aunque
  sobre pocas rutas»; cierre «anticipa la estructura… pero no su demanda».
- [x] Objetivos específicos (§3.4): ✔ / ◐ / ✖ por objetivo; $\Delta E$ del
  objetivo 3 solo exploratorio (#39).
- [x] **No repetir el pasaje de 1985** (lo abre 7.1 y lo cierra 7.3).
- [x] Terminar con una transición hacia 7.1 (el instrumento).
  **✅ 2026-11-04 (P3, opción A, score 0.122):** «tres completos y dos en
  parte»; déficit «sobre todo en la periferia mexiquense»; cierra presentando
  los tres ejes. Se descartó anunciar aquí «lo que se mide define lo que se
  construye» (opción B); la frase queda solo en el cierre de 7.3.
  Hallazgos para otro ítem: objetivo 5 dice «velocidad comercial de
  Metrobús» y el Caso 2 se modeló sobre Mexibús; 7.1 P4 escribe «feeds» sin
  \termino{} (la entrada sí lo usa).
- [ ] Mismo flujo: propuesta por párrafo con score < 0.20 y aprobación
  antes de escribir; #33 (intervalos, no nombres de banda).
- [ ] Después: repaso de transiciones entrada → 7.1 → 7.2 → 7.3 y de la
  extensión total (hoy ~267 líneas sin la entrada).
