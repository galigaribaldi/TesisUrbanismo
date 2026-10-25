# 10-19 Reunión semanal: Revisión de tesis sobre Anillo Periférico de Alta Capacidad, centralidad y ajustes metodológicos en CDMX

# Reunión de revisión de tesis y propuesta del Anillo Periférico de Alta Capacidad
- Fecha y hora: 2026-10-19, 15:12:16 (hora local)
- Participantes:
  - Speaker 1 (tesista: Garibel/Galileo/Galindo; en algunos segmentos se menciona como “Garibel” y “Galindo”)
  - Speaker 2 (asesor)
  - Speaker 3 (participante de apoyo)
  - Speaker 4 (participante de apoyo)
- Resumen de la reunión:
  - La sesión integró la revisión técnica del Capítulo 6 (escenarios del anillo periférico), el análisis comparativo Metro vs. Metrobús con dashboards de centralidad, acuerdos de estilo narrativo, documentación de limitaciones (GTFS y metodología), correcciones topológicas y de transbordos, y una nueva clasificación multidimensional normalizada. Se acordaron múltiples ajustes editoriales (figuras, terminología, ubicación de glosario, reorganización de estado del arte antes del marco teórico), cambios metodológicos (definición de modos masivos, uso de percentiles en la “calificación de Garibel”, evitar calificativos normativos), y el plan de revisión editorial en dos corridas. Se avanzó en la conformación del cuerpo de sinodales y en pasos administrativos con la profesora Ángeles. Se definieron tareas y fechas para ajustes prioritarios (dashboard acotado a CDMX, documentación de limitaciones, traducciones y consistencia de año), y se estableció la estructura obligatoria del capítulo de conclusiones.
---
## Tema 1: Revisión del Capítulo 6 — Escenario de Anillo Periférico y análisis de centralidad
- Participantes involucrados: Speaker 1, Speaker 2, Speaker 3.
- Resumen extractivo y puntos clave:
  - Estructura del capítulo y casos:
    - Speaker 1: El capítulo aborda un “escenario hipotético de anillo periférico de alta capacidad” con tres capas de código y tres casos: Caso 1 (red base/actual), Caso 2 (anillo Metrobús), Caso 3 (anillo Metro).
    - Consideraciones: geometría, transbordos, viajes entre periferias y carga de nodos.
  - Cartografía y división:
    - Speaker 1: Mapas con líneas principales y el trazo propuesto; división en cuatro cuadrantes (norte, oriente, sur, poniente) con centro en el Zócalo; demarcaciones y número de estaciones por cuadrante.
  - Limitaciones:
    - Speaker 1: El modelo no contempla condiciones físicas del trazo (pendientes, ancho de vialidades, tipo de calle) ni dimensiones sociales (distribución poblacional, preferencias modal). La partición en cuadrantes es decisión metodológica propia. Se denomina “anillo periférico interior”; el anillo exterior queda fuera del alcance.
  - Dashboards de intermediación (Betweenness Centrality):
    - Speaker 1: Tacubaya se mantiene en rango 1; centralidad 0.2232 (red actual) baja a 0.1569 (escenario Metro) y reducción menor en Metrobús.
    - Speaker 2: Pregunta si el umbral 0.17–0.18 es teórico; Speaker 1 confirma origen en la escala teórica.
    - Observación de distribución:
      - Speaker 2: En Metrobús y red actual las estaciones más centrales se concentran en pocas delegaciones; en Metro se distribuyen más, incluyendo el sur.
      - Speaker 1: “[...] En el otro no tienes ninguna delegación del sur. Sí, eso fue un hallazgo importante porque está muy bueno”. “[...] como la capacidad de carga del metro es mayor y la velocidad es mayor, se distribuye [...] más equitativamente.”
    - Coincidencia: El escenario Metrobús no libera sustancialmente la centralidad del sistema actual.
  - Estilo narrativo:
    - Speaker 2: “[...] hazlas muy aterrizadas [...] a una narrativa. Muy al urbanismo. No digas tantos números, sino [...] solo lo que representa.”
  - Conclusiones previstas:
    - Speaker 1: Planea incluir que el escenario de Metro presenta mejoras más sustanciales.
- Decisiones relevantes:
  - Reforzar narrativa urbana del capítulo minimizando tecnicismos excesivos.
  - Destacar que el escenario Metro mejora la distribución de intermediación hacia periferia y delegaciones del sur.
- Problemas y desafíos:
  - Densidad visual de mapas detallados demanda alta atención.
  - Falta de datos de demanda/población para estimaciones de uso.
  - Cobertura similar entre Metro y Metrobús por la gran extensión del Estado de México frente a CDMX; necesidad de alternativas lejanas (p. ej., Arco Norte).
### Tabla de elementos de acción
| Título | Descripción de la tarea | Responsable | Plazo / Fecha de entrega | Notes |\
| --- | --- | --- | --- | --- |\
| Redacción de conclusiones del Capítulo 6 | Integrar comparativo de indicadores por nodo y formalizar que la opción Metro ofrece resultados más favorables | Speaker 1 | No especificado | Basarse en dashboards de centralidad y mapas |\
| Redacción con enfoque urbano | Aterrizar explicaciones a narrativa urbana, omitiendo tecnicismos numéricos excesivos | Speaker 1 | No especificado | Utilizar mapas y dashboards para ilustrar visualmente |
### Preguntas abiertas
- No se registraron preguntas abiertas al finalizar este fragmento.
---
## Tema 2: Definición metodológica de limitaciones (GTFS y estaciones compartidas Metro/Metrobús)
- Participantes: Speaker 1, Speaker 2.
- Resumen extractivo y puntos clave:
  - Uso de mismas estaciones:
    - Speaker 2: Pregunta si se usaron mismas estaciones para Metrobús y Metro.
    - Speaker 1: “[...] prácticamente copié las estaciones y las ubicaciones, nada más cambié las velocidades.”
    - Speaker 2: Señala que la separación de estaciones de Metrobús es menor y recomienda documentar la decisión para reproducibilidad, sin rehacer el trabajo.
  - Limitaciones de datos:
    - Acuerdo: Incorporar en sección de limitaciones el uso de mismas estaciones y las restricciones GTFS (Mexibús, Mexicable, Interurbano).
- Decisiones:
  - Documentar explícitamente la “Limitación 5” (misma ubicación/estaciones; solo velocidad varía) y “Limitación 6” (restricciones GTFS).
- Problemas y desafíos:
  - Metodología simplificada por estaciones compartidas puede sesgar comparativa; mitigación vía documentación.
### Tabla de elementos de acción
| Título | Descripción de la tarea | Responsable | Plazo / Fecha de entrega | Notes |
| --- | --- | --- | --- | --- |
| Documentar Limitación 5 | Registrar que Metro y Metrobús usan mismas estaciones; varía velocidad | Speaker 1 | No especificado | Asegurar reproducibilidad |
| Documentar Limitación 6 | Incluir restricciones GTFS (Mexibús, Mexicable, Interurbano) | Speaker 1 | No especificado | En sección de limitaciones |
### Preguntas abiertas
- Ninguna.
---
[image]
## Tema 3: Correcciones de topología de red y propuesta de clasificación multidimensional normalizada
- Participantes: Speaker 1, Speaker 2.
- Resumen extractivo y puntos clave:
  - Observaciones externas:
    - Speaker 1: Retroalimentación del Dr. Jairo y Dra. Ruth sobre terminología, redacción y consistencia.
  - Corrección de transbordos:
    - Speaker 1: Ajuste del radio de conexión de 50 m a 85 m reales, mejorando conexión de nodos del anillo y la factibilidad de transbordos.
  - Clasificación multidimensional:
    - Speaker 1: Propone una clasificación (no indicador único formal) basada en cuatro ejes normalizados: Accesibilidad; Centralidad crítica (intermediación); Conectividad/Alimentación capilar (interconexión modal); Fluidez / Índice de ruta directa (A→B).
    - Justificación: Evitar la exigencia de validación teórica de un indicador compuesto; facilitar comprensión para perfiles no matemáticos.
    - Consideraciones: Los tiempos de viaje salen consistentes en red actual pero no incluyen contingencias (cierres, marchas, suspensiones).
    - Speaker 2: “[...] cada indicador lo normalizaste a uno.”
- Decisiones:
  - Emplear clasificación multidimensional normalizada sin formalizar como indicador único ponderado.
- Problemas y desafíos:
  - Riesgo de complejidad y necesidad de explicar normalización y escalas.
  - Exclusión de contingencias operativas puede limitar realismo de tiempos de viaje.
### Tabla de elementos de acción
| Título | Descripción de la tarea | Responsable | Plazo / Fecha de entrega | Notes |
| --- | --- | --- | --- | --- |
| Detallar el espectro de clasificación | Fundamentar la clasificación multidimensional de 4 ejes sin catalogarlo como indicador único | Speaker 1 | No especificado | Basado en literatura adaptada al contexto metropolitano |
### Preguntas abiertas
- ¿Cuál es el proceso exacto y la escala final empleada para normalizar cada uno de los 4 indicadores a 1 (o escala equivalente)?
---
## Tema 4: Cobertura espacial, datos GTFS y acotación del dashboard de calificación a CDMX
- Participantes: Speaker 1, Speaker 2, Speaker 3, Speaker 4.
- Resumen extractivo y puntos clave:
  - Cobertura GTFS:
    - Speaker 2: “[...] tú solo trabajas los datos de GTFS [...] tu sistema no tiene los datos del Estado de México [...] Creo que solo tienes Mexibús.”
    - Speaker 1: Confirma la limitación: GTFS de solo Mexibús.
    - Implicación: Cobertura baja en zona metropolitana por datos incompletos (no hay GTFS completo del Edomex ni Mexicable).
  - Acotación a 16 alcaldías de CDMX:
    - Speaker 2: Propone recalcular el “dashboard de calificación de Garibel” solo para CDMX.
    - Speaker 1: “[...] No está tan difícil [...] son varios dashboards [...] como 8 y 4 mapas [...] Sí se podría hacer.” Acepta trabajar con “las 16 alcaldías” en vez de “96 demarcaciones”.
    - Decisión sugerida: Mantener el resto de productos en ámbito metropolitano con nota explícita de restricción de datos.
  - Capacidad del sistema:
    - Speaker 2: “[...] Tu sistema es capaz de obtener esos resultados [...] dame el GTFS y lo corro, pero si no lo tengo, no.”
  - Calendario y acciones:
    - Se establecen fechas tentativas para ajuste del dashboard y documentación de limitaciones GTFS.
- Decisiones:
  - Ajustar el dashboard de calificación al ámbito CDMX (16 alcaldías) y documentar limitaciones GTFS; mantener otros productos con ámbito metropolitano sujeto a restricción explícita.
- Problemas y desafíos:
  - Recalcular y generar visibles (varios dashboards y mapas) demandan esfuerzo.
  - Cobertura y centralidad variarán por disparidad de datos entre CDMX y zona metropolitana.
### Tabla de elementos de acción
| Título | Descripción de la Tarea | Responsable | Plazo / Fecha Límite | Notes |
| --- | --- | --- | --- | --- |
| Ajuste del ámbito del dashboard (CDMX: 16 alcaldías) | Recalcular el dashboard de calificación de Garibel usando solo CDMX; documentar la limitación GTFS y mantener otros productos metropolitanos con nota de restricción | Speaker 1 | 1–2 semanas | 2026-11-02 |
| Documentación de limitaciones de datos (GTFS) | Incluir sección explícita de limitaciones: ausencia de GTFS completo del Edomex y de Mexicable | Speaker 1 | 3–5 días | 2026-10-24 |
### Preguntas abiertas
- ¿Habrá acceso próximo a GTFS del Mexicable u otros sistemas del Edomex? [???]
- ¿Se actualizará la zona metropolitana con nuevos datos si se obtienen antes del cierre de tesis? [???]
---
## Tema 5: Definición y justificación de la “calificación de Garibel” y uso de percentiles
- Participantes: Speaker 1, Speaker 2.
- Resumen extractivo y puntos clave:
  - Justificación y alcance:
    - Speaker 2: “[...] tu calificación [...] tienes que justificarla o describirla [...] Para qué sirve tu calificación?” Delimita que probar utilidad práctica está fuera del alcance y puede ser trabajo futuro.
  - Presentación de resultados:
    - Speaker 2: “[...] con todos los valores normalizados [...] ya una global [...] saca 9, 8, 7.”
    - Speaker 1: “[...] Lo dejé así como aquí es bajo/alto [...] no le puse descriptivo de bueno o malo.”
  - Categorización por percentiles:
    - Speaker 2: “[...] cambiar los nombres [...] para que no digan ‘es crítico’ [...] déjalo como primer, segundo, tercer y cuarto percentil.”
    - Entrada del usuario: “Cambiar los adjetivos descriptivos a Números de percentiles (Crítico = .25) dejar solamente el número”.
    - Speaker 1: “Suena muy fuerte decir crítico [...] sin demostrarlo.” “Punto 25 [...] dejar solamente el número.”
- Decisiones:
  - Describir la construcción de la calificación sin afirmar utilidad práctica; cambiar etiquetas cualitativas por percentiles (0.25, 0.50, 0.75, 1.0 o primer/segundo/tercer/cuarto percentil), alineado con “dejar solo el número”.
- Problemas y desafíos:
  - Explicar percentiles de manera comprensible para lectores no técnicos.
  - Uniformidad de uso de percentiles numéricos vs. nominales en todo el documento.
### Tabla de elementos de acción
| Título | Descripción | Responsable | Plazo | Fecha límite | Notes |
| --- | --- | --- | --- | --- | --- |
| Redacción de la descripción de la calificación | Explicar variables, normalización y agregación; incluir sección de trabajo futuro; no afirmar utilidad práctica | Speaker 1 | 5–7 días | 2026-10-26 | Citar que validación externa queda fuera del alcance |
| Cambio de etiquetas a percentiles | Reemplazar adjetivos por percentiles (0.25, 0.50, 0.75, 1.0) o “primer/segundo/tercer/cuarto percentil”; reflejar en dashboard y texto | Speaker 1 | 2–3 días | 2026-10-22 | Alinear con instrucción de “dejar solo el número” |
### Preguntas abiertas
- ¿Se empleará percentil numérico (p. ej., 0.25) o nominal (“primer percentil”) de forma uniforme en todo el documento? [???]
- ¿Se requiere un ejemplo ilustrativo de interpretación de percentiles para lectores no técnicos? [???]
---
## Tema 6: Avances en mapas, red actual y recursos visuales
- Participantes: Speaker 1, Speaker 2.
- Resumen extractivo y puntos clave:
  - Avance:
    - Speaker 1: “Tratando de demostrar un punto, tuve que hacer un análisis de la red actual [...] no estaba en mis planes [...] pero quedó bien.” “[...] casi todos los mapas ya están puestos junto con el texto [...] Pongo el mapa y la descripción abajito.”
  - Feedback:
    - Speaker 2: “Perfecto.”
- Decisiones:
  - Completar integración de mapas y descripciones coherentes con el texto.
- Problemas y desafíos:
  - Verificación de consistencia de simbología y referencias.
### Tabla de elementos de acción
| Título | Descripción | Responsable | Plazo | Fecha límite | Notes |
| --- | --- | --- | --- | --- | --- |
| Completar integración de mapas y descripciones | Verificar que cada mapa tenga descripción coherente con el texto | Speaker 1 | 3–5 días | 2026-10-24 | Revisar simbología y referencias |
### Preguntas abiertas
- ¿Falta algún mapa por generar o actualizar en el capítulo correspondiente? [???]
---
## Tema 7: Correcciones metodológicas, consistencia de datos y nota de versión
- Participantes: Speaker 1, Speaker 2.
- Resumen extractivo y puntos clave:
  - Observaciones de profesor revisor:
    - Alcance geográfico: delimitar demarcaciones de la zona metropolitana correctamente.
    - Nomenclaturas inconsistentes: “Fuerza capilar” (FC vs. FCh); “factor de desviación” (DF vs. DI).
    - Datos: unificar corridas (marzo/abril vs. nuevos), adoptar velocidad oficial (Metrobús: 22 km/h), eliminar corridas especulativas.
    - LaTeX y referencias: corregir errores y roturas.
    - Speaker 1: “Los importantes [...] consistencia y errores de código [...] ya los cerré.”
  - Reconocimiento:
    - Speaker 2: “Perfecto [...] te hizo un muy buen trabajo [...] sería bueno [invitarlo como sinodal].”
- Decisiones:
  - Incorporar nota de versión detallando correcciones y estandarizaciones.
- Problemas y desafíos:
  - Mantener coherencia terminológica y de parámetros en todo el documento.
### Tabla de elementos de acción
| Título | Descripción | Responsable | Plazo | Fecha límite | Notes |
| --- | --- | --- | --- | --- | --- |
| Documentar cambios metodológicos y de datos | Añadir nota de versión: delimitación geográfica, acrónimos, velocidades oficiales, eliminación especulativos, unificación de corrida | Speaker 1 | 4–6 días | 2026-10-25 | Incluir tabla de equivalencias (FC/FCh; DF/DI) |
| Verificación final de LaTeX y reproducibilidad | Compilar documento y ejecutar pipeline final | Speaker 1 | 2–3 días | 2026-10-22 | Crear checklist de build |
### Preguntas abiertas
- ¿Debe incluirse un apéndice técnico con parámetros (p. ej., velocidades oficiales por modo) y fuentes? [???]
---
[image]
[image]
[image]
[image]
## Tema 8: Correcciones editoriales, organización de capítulos y definiciones operativas
- Participantes: Speaker 1, Speaker 2, Speaker 3, Speaker 4.
- Resumen extractivo y puntos clave:
  - Correcciones editoriales:
    - Speaker 2: Eliminar “traducción propia” donde ya existe referencia (“según García López”); traducir 2–3 figuras al español; renombrar indicadores con términos descriptivos y aclaraciones técnicas entre paréntesis (p. ej., “cobertura (coverage)”, “centralidad (betweenness/degree)”); reorganizar “contornos” definiendo antes de usarlos; glosario al final; traducir anglicismos; aclarar “caso 1 = status quo”.
  - Introducción y definiciones:
    - Speaker 2: Explicar “motor BFT Model” al introducirlo; definir “robustez sistémica” con referencia Owais et al. (2020); evitar redundancias (“colectivo” junto a “masivo”); evitar tono poético (“automóvil privado”); añadir referencia de tiempos de viaje &gt;122 minutos (ED/SEMOVI).
    - Speaker 1: Explica “desigualdad socioespacial” como disminución de calidad de vida con distancia; se recomienda describir explícitamente el concepto.
  - Alcance de modos masivos y GTFS:
    - Speaker 2: “GTFS es no masivo”; en Valle de México los modos masivos son Metro y BRT; trolebús y otros no se consideran masivos en esta metodología; Fase 1: construir grafo multimodal con feeds GTFS, ponderando solo Metro y BRT como masivos; “caso uno” debe aparecer arriba como antecedentes y marco teórico.
  - Estado del arte y marco teórico:
    - Speaker 2: Falta el estado del arte en capítulo 2; debe ir antes del marco teórico; seleccionar ~10 trabajos recientes sobre indicadores de red; eliminar micro-capítulos y usar texto fluido; al final de Cap. 1 (tras 1.7.4) incluir sinopsis de capítulos.
  - Terminología y estilo:
    - Speaker 2: Usar “modo” (no “medio”); reescribir datos abiertos y mediación técnica sin añadir objetivos; especificar tipo de “brecha” (digital/técnica); definir conceptos en su primera mención antes del Cap. 3.
  - Redundancias y precisión:
    - Speaker 2: Eliminar sección redundante; justificar uso de OpenStreetMap; coherencia de mayúsculas y objeto de estudio; al listar CETRAMs, usar “entre otros”; definir “redes capilares de superficie”.
- Decisiones:
  - Implementar correcciones editoriales, reubicar estado del arte antes del marco, traducir figuras, definir términos clave en primera mención, y ajustar terminología y año (2026) consistentemente.
- Problemas y desafíos:
  - Selección representativa de literatura (~10 trabajos).
  - Reestructuración sin perder coherencia del índice.
  - Definiciones operativas claras para términos propios (red capilar).
### Tabla de elementos de acción
| Acción | Descripción | Responsable | Plazo | Fecha de entrega | Notes |\
| --- | --- | --- | --- | --- | --- |\
| Eliminar “traducción propia” | Quitar indicación donde ya hay cita | Speaker 1 | 3 días | 2026-10-22 | Revisar resaltados |\
| Traducir figuras | Traducir 2–3 figuras al español | Speaker 1 | 5 días | 2026-10-24 | Consistencia terminológica |\
| Renombrar indicadores | Nombres descriptivos + términos técnicos entre paréntesis | Speaker 1 | 7 días | 2026-10-26 | Breve explicación no técnica |\
| Definir contornos | Introducir 1º–4º contorno antes de uso | Speaker 1 | 7 días | 2026-10-26 | Reorganizar sección |\
| Ubicar glosario | Mover glosario al final | Speaker 1 | 3 días | 2026-10-22 | Solo consulta/ubicación |\
| Traducir anglicismos | Explicar GTFS en español; mantener acrónimo | Speaker 1 | 5 días | 2026-10-24 | “Especificación General de Feed de Tránsito” |\
| Aclarar caso 1 | Incluir “caso 1 = status quo” | Speaker 1 | 3 días | 2026-10-22 | Coherencia con casos 2–3 |\
| Definir BFT Model | Explicar función y alcance en introducción | Speaker 1 | 5 días | 2026-10-24 | “BFT Model” entre paréntesis |\
| Definir robustez sistémica | Definición operacional citando Owais et al. (2020) | Speaker 1 | 7 días | 2026-10-26 | Ejemplos de pérdida de conectividad/eficiencia |\
| Añadir referencia &gt;122 min | Citar ED/SEMOVI para tiempos de viaje | Speaker 1 | 3 días | 2026-10-22 | Consistencia de año |\
| Describir desigualdad socioespacial | Reemplazar por descripción explícita | Speaker 1 | 5 días | 2026-10-24 | Mantener término si se define |\
| Clasificar modos | Señalar explícitamente Metro/BRT masivos | Speaker 1 | 3 días | 2026-10-22 | Trolebús y otros: no masivos |\
| Ajustar redacción GTFS | Explicar uso de GTFS | Speaker 1 | 5 días | 2026-10-24 | Alineado con acrónimo en español |\
| Integrar “caso 1” | Vincular con antecedentes/estado actual | Speaker 1 | 3 días | 2026-10-22 | Coherencia con metodología |\
| Insertar estado del arte | Sección antes del marco teórico | Speaker 1 | 7 días | 2026-10-26 | Posicionar aportes |\
| Compilar indicadores de red | Seleccionar ≤10 trabajos recientes | Speaker 1 | 7 días | 2026-10-26 | Citas completas |\
| Eliminar micro-capítulos | Convertir en texto fluido; año 2026 | Speaker 1 | 5 días | 2026-10-24 | Revisar numeración |\
| Sinopsis de capítulos | Redactar presentación tras 1.7.4 | Speaker 1 | 3 días | 2026-10-22 | Formato estándar |\
| Reescribir sección de datos abiertos | Quitar resaltados; mantener argumento | Speaker 1 | 3 días | 2026-10-22 | Referenciar Gurstein |\
| Especificar “brecha” | Nombrar tipo de brecha | Speaker 1 | 3 días | 2026-10-22 | Alinear con movilidad |\
| Definir en primera mención | Introducir definiciones clave antes del Cap. 3 | Speaker 1 | 5 días | 2026-10-24 | Evitar jerga no explicada |\
| Borrar redundancias | Eliminar sección repetida | Speaker 1 | 3 días | 2026-10-22 | Confirmar coherencia |\
| Definir red capilar | Definición operativa de “redes capilares de superficie” | Speaker 1 | 5 días | 2026-10-24 | Ejemplificar con modos no masivos |\
| Ajustar listado de CETRAMs | Usar “entre otros” o lista más amplia | Speaker 1 | 3 días | 2026-10-22 | Verificar número actual |\
| Presentación de capítulos | Sinopsis estándar tras 1.7.4 | Speaker 1 | 3 días | 2026-10-22 | Breve y clara |\
| Unificar año | Sustituir años incorrectos por 2026 | Speaker 1 | 3 días | 2026-10-22 | Encabezados y pies |\
| Coherencia de términos | Usar consistentemente “modo”, “masivo”, “no masivo” | Speaker 1 | 5 días | 2026-10-24 | Aplicar a todo el documento |
### Preguntas abiertas
- ¿La referencia precisa para &gt;122 minutos proviene de ED o de SEMOVI (2020 vs. 2021)? [???]
- ¿Se adoptará definición estandarizada de “desigualdad socioespacial” o solo descripción contextual? [???]
- ¿Se incluirán sistemas alimentadores no masivos en análisis secundarios (p. ej., sensibilidad)? [???]
- ¿Criterios para seleccionar los ~10 trabajos (impacto, año, redes urbanas vs. teoría general)? [???]
- ¿Se incluirá una sección breve de “convenciones terminológicas” al inicio para asegurar consistencia sin convertirlo en glosario? [???]
- ¿Qué anglicismos conservar como acrónimos (GTFS, BRT) con traducción explicativa y cuáles traducir completamente? [???]
---
[image]
## Tema 9: Términos conceptuales y conflicto de compensabilidad
- Participantes: Speaker 1, Speaker 2, Speaker 4.
- Resumen extractivo y puntos clave:
  - Definiciones necesarias:
    - Speaker 2: “[...] alta intermediación no está definido [...] tienes que definirlo [...] o usar palabras entre paréntesis [...] y a partir de ahí ya puedes utilizar alta intermediación.”
  - Compensabilidad:
    - Speaker 2: “[...] fusionaste diferentes dimensiones que no son medibles [...] compatibles [...] y puedes tener un problema de compensabilidad.” Un valor alto de eficiencia de ruta podría ocultar vulnerabilidad crítica de centralidad.
    - Speaker 1: Propuso analogía de red de agua; Speaker 4: “[...] No me gusta.”
  - Recomendación:
    - No usar con naturalidad conceptos definidos más adelante; definirlos primero o usar ejemplos claros y aterrizados.
- Decisiones:
  - Definir formalmente términos (alta intermediación, compensabilidad) antes de su uso discursivo y reestructurar texto para evitar que una dimensión oculte debilidades de otra.
- Problemas y desafíos:
  - Balancear claridad conceptual y evitar analogías confusas.
### Tabla de elementos de acción
| Tarea / Acción | Responsable | Plazo / Fecha Límite | Notes |
| --- | --- | --- | --- |
| Definir “alta intermediación” y “compensabilidad” | Speaker 1 | No especificada | Ubicar definición formal previa a su uso |
| Replantear ejemplos de compensabilidad | Speaker 1 | No especificada | Evitar analogías rechazadas; usar ejemplos concretos |
### Preguntas abiertas
- ¿Se empleará una analogía alternativa para compensabilidad o se mantendrá la explicación formal técnica? [???]
---
## Tema 10: Corrección de figuras, tablas y ecuaciones matemáticas
- Participantes: Speaker 1, Speaker 2, Speaker 3.
- Resumen extractivo y puntos clave:
  - Figuras:
    - Speaker 2: Falta contextualización de Figuras 3.1 y 3.2 y traducir al español; numerar y referenciar en el texto previo.
  - Ecuaciones y formato:
    - Speaker 2: “Te conviene más poner la fórmula [...] este índice es igual a [...] donde cada cosa significa [...]”; no crear subsecciones “Fórmula/Ecuación”; redactar párrafo introductorio a cada ecuación (“La ecuación 3.1 muestra...”).
  - Variables y tablas:
    - Inconsistencias: $C_i$ confundido y $L_C$ no definido; eliminar mención no definida y limpiar notación.
    - Tabla de $C_i$: retirar adjetivos (“alto/medio”) y dejar valores numéricos (pasajeros/hora) de la EOD.
    - Speaker 1: “[...] eso era por demanda de la EOD [...]”.
  - Limpieza:
    - Quitar notas informales de borrador (“fuente principal”, “ejemplo práctico de CDMX”).
- Decisiones:
  - Traducir y contextualizar figuras; formalizar ecuaciones con texto introductorio; limpiar notación y variables; reportar valores cuantitativos sin calificativos no justificados.
- Problemas y desafíos:
  - Coherencia entre narrativa y formulación matemática.
### Tabla de elementos de acción
| Título | Responsable | Plazo | Fecha Límite | Notes |
| --- | --- | --- | --- | --- |
| Traducir y contextualizar Fig. 3.1 y 3.2 | Speaker 1 | No especificada | No especificada | Asegurar referencia en narrativa |
| Reformular presentación de ecuaciones | Speaker 1 | No especificada | No especificada | Eliminar subsecciones “Fórmula” |
| Corregir inconsistencias ($C_i$, eliminar $L_C$) | Speaker 1 | No especificada | No especificada | Quitar notas de borrador |
| Ajustar tabla de $C_i$ | Speaker 1 | No especificada | No especificada | Dejar valores numéricos EOD |
### Preguntas abiertas
- Ninguna reportada.
---
## Tema 11: Plan de revisión editorial en dos corridas y entrega de PDF
- Participantes: Speaker 1, Speaker 2.
- Resumen extractivo y puntos clave:
  - Entrega de PDF:
    - Speaker 1: “Se está cargando, este pesa un buen en el PDF.”
    - Speaker 2: Referencia a documento revisado (posible 135 páginas), realizará revisión “en estos días”.
  - Estructura de revisión:
    - Speaker 2: “Falta [...] escritura y reestructuración [...] vamos a regresar varias veces [...]”
    - “El primer cacho [...] de las revisiones más fuertes [...] está bastante bien lo que llevas.”
    - Secuencia: Completar escritura restante → primera corrida sobre la otra mitad → segunda corrida lectura integral y ajustes finos → envío a sinodales.
    - “[...] el tuyo va a ser con 2 corridas [...] porque [...] tú no tienes problemas de escritura.”
- Decisiones:
  - Dos corridas de revisión; envío a sinodales tras la segunda.
- Problemas y desafíos:
  - Tamaño del PDF y carga de trabajo del asesor pueden afectar tiempos.
### Tabla de elementos de acción
| Tarea | Descripción | Responsable | Plazo | Fecha Límite | Notes |
| --- | --- | --- | --- | --- | --- |
| Confirmar recepción del PDF | Verificar que se recibió y se puede abrir | Speaker 2 | En estos días | No especificada | Archivo grande |
| Notificar continuidad | Informar avance y próximos pasos | Speaker 2 | Tras revisión inicial | No especificada | Depende de carga laboral |
| Completar escritura pendiente | Finalizar secciones restantes | Speaker 1 | Antes de 1ª corrida | No especificada | Paso previo indispensable |
| Primera corrida (otra mitad) | Revisar segunda mitad (estructura y contenido) | Speaker 2 | Tras recepción de versión completa | No especificada | “Cacho fuerte” |
| Segunda corrida (integral) | Lectura completa y ajustes finos | Speaker 2 | Después de 1ª corrida | No especificada | Listo para sinodales |
| Preparar envío a sinodales | Integrar comentarios y pulir documento | Speaker 1 | Tras 2ª corrida | No especificada | Listo para comité |
### Preguntas abiertas
- ¿Se confirmó la recepción completa y legible del PDF pesado? [???]
- ¿Fecha estimada de devolución de comentarios del nuevo PDF? [???]
- ¿Qué secciones específicas restan por escribir antes de la primera corrida? [???]
- ¿Qué criterios definirán que la segunda corrida esté “completa” y lista para enviar a sinodales? [???]
---
## Tema 12: Coordinación con asesores y conformación de sinodales; pasos administrativos
- Participantes: Speaker 1, Speaker 2.
- Resumen extractivo y puntos clave:
  - Coordinación multi-actor:
    - Speaker 1: “[...] me van diciendo tanto la doctora Sagrario como el doctor Héctor y [...] lo que me vaya a decir Ángeles [...] nunca pensé que tuviera que hablar con tanta gente.”
    - Speaker 2: “Si es esto del titular que tiene que hablar con todos.”
  - Confirmaciones:
    - Héctor Reséndiz (Instituto de Geografía): confirmado.
    - Sagrario Castillo Camporro (Posgrado de Urbanismo, FES Acatlán): confirmado.
    - Jairo Olguín Roque (MAC, FES Acatlán): candidato a externo; requiere solicitud.
  - Propuestos adicionales:
    - Emelina Nava García (externa, en padrón de tutores).
    - Mateo Carlos Galindo Pérez.
    - Guillermo Agustín Guajardo Soto.
    - Reserva: Pablo Miguel Pavía Ortiz (transporte, FES Acatlán).
  - Requisitos:
    - Diversidad institucional; evitar exceso de una sola sede; preferencia por padrón; externos aceptables si no hay perfil en padrón.
    - Vinculación con profesora Ángeles para trámites y aval de externos.
  - Padrón de tutores:
    - URL: https://urbanismo.posgrado.unam.mx/Doc/semestre%202027.1/Tutores%20de%20Urbanismo%202026.pdf
- Decisiones:
  - Avanzar con la solicitud para aceptar a Jairo como externo; “stalkeo” de candidatos propuestos; coordinación con Ángeles.
- Problemas y desafíos:
  - Requisitos burocráticos para externos; límites de composición institucional.
### Tabla de elementos de acción
| Acción | Descripción | Responsable | Plazo | Fecha Límite | Notes |
| --- | --- | --- | --- | --- | --- |
| Coordinar con Héctor y Sagrario | Confirmar disponibilidad, explicar proyecto | Speaker 1 | 3–5 días | 2026-10-24 | Preparar resumen ejecutivo |
| Solicitud para Jairo (externo) | Tramitar papeles y justificación (componente matemático) | Speaker 1 + Profesora Ángeles | 1 semana | 2026-10-26 | Si no se aprueba, activar suplente Pavía |
| “Stalkeo” académico | Revisar líneas de investigación y disponibilidad (Emelina, Mateo, Guillermo) | Speaker 1 | 4–6 días | 2026-10-25 | Priorizar diversidad institucional |
| Contactar a profesora Ángeles | Agendar sesión; revisar requisitos/externos | Speaker 1 | 2–3 días | 2026-10-22 | Llevar lista de candidatos y vínculo del padrón |
| Verificar composición final | 5 sinodales con distribución adecuada | Speaker 1 + Profesora Ángeles | 1–2 semanas | 2026-11-02 | Documentar en formato oficial |
### Preguntas abiertas
- ¿Cuál será el quinto sinodal definitivo tras el “stalkeo”? [???]
- ¿Hay límite explícito del número de sinodales de FES Acatlán en el comité? [???]
- ¿Qué documentación exacta requiere el comité para aceptar a un externo como Jairo? [???]
- ¿El comité sugiere otro candidato del padrón más alineado al componente matemático si Jairo no es aprobado? [???]
---
## Tema 13: Título de la tesis
- Participantes: Speaker 1, Speaker 2.
- Resumen extractivo y puntos clave:
  - Estado:
    - Speaker 1: “Lo he dejado muy al final [...] no lo he trabajado.”
  - Lineamientos:
    - Speaker 2: Debe incluir indicadores, caso del Anillo Periférico y referencia a Apímetro; balance descriptivo vs. conciso; evitar títulos excesivamente largos.
  - Componentes:
    - Speaker 1: “Las tres capas [...] tienen nombres singulares.”
- Decisiones:
  - Generar borradores de título con los elementos acordados.
- Problemas y desafíos:
  - Restricciones de formato y contenido; validar con asesor.
### Tabla de elementos de acción
| Acción | Descripción | Responsable | Plazo | Fecha Límite | Notes |
| --- | --- | --- | --- | --- | --- |
| Borradores de título | 3–5 opciones con indicadores, Anillo Periférico y Apímetro | Speaker 1 | 5–7 días | 2026-10-26 | Validar con asesor; revisar normas del posgrado |
### Preguntas abiertas
- ¿Existen límites de caracteres o línea para títulos en el posgrado? [???]
- ¿Debe incluirse explícitamente “Ciudad de México” y el año en el título? [???]
---
## Tema 14: Organización Estado del Arte vs. Metodología; poda y clasificación de contenidos
- Participantes: Speaker 1, Speaker 2, Speaker 3.
- Resumen extractivo y puntos clave:
  - Reubicación:
    - Speaker 2: La subsección “Planeación Estratégica” corresponde al estado del arte; moverla bajo ese título, conservar subtítulos.
    - Cap. 3.1 mezcla antecedentes y metodología (Lotero, Vélez, Hurtado; Albert et al. redes libres de escala): deben ir al estado del arte; métricas operativas y SIG van en metodología.
    - Recomendación: apoyarse con IA para poda y clasificación preliminar, con control del autor.
  - Teoría de grafos:
    - Speaker 2: Acotar contexto histórico a dos oraciones; eliminar desarrollos irrelevantes (caminos cerrados, transitabilidad excesiva): “[...] quita todo de eso [...]”
- Decisiones:
  - Reestructurar Cap. 3.1 separando estado del arte de metodología; sintetizar historia de grafos.
- Problemas y desafíos:
  - Delimitar qué porciones de SIG quedan en marco conceptual vs. metodología aplicada.
### Tabla de elementos de acción
| Acción | Responsable | Plazo | Fecha Límite | Notes |
| --- | --- | --- | --- | --- |
| Reestructurar Cap. 3.1 | Speaker 1 | No especificada | No especificada | Mover literatura a antecedentes; conservar métricas en metodología |
| Sintetizar historia de grafos | Speaker 1 | No especificada | No especificada | Reducir a dos oraciones; eliminar irrelevantes |
### Preguntas abiertas
- ¿Qué porciones exactas de SIG quedarán en marco conceptual y cuáles en metodología aplicada? [???]
---
## Tema 15: Estructura de conclusiones (3 puntos; 1–2 páginas)
- Participantes: Speaker 1, Speaker 2, Speaker 3.
- Resumen extractivo y puntos clave:
  - Formato:
    - Speaker 1: Solicita formato para conclusiones.
    - Speaker 2: Extensión 1–2 páginas; tres puntos estrictos:
      1. Breve resumen del trabajo y resultados principales (1–2 párrafos).
      2. Contribuciones del trabajo (aporte original).
      3. Trabajo futuro (propuesta para nivel doctoral).
- Decisiones:
  - Adoptar estructura en tres partes y extensión indicada.
- Problemas y desafíos:
  - Síntesis clara de metodología y hallazgos sin tecnicismos excesivos.
### Tabla de elementos de acción
| Acción | Responsable | Plazo | Fecha Límite | Notes |
| --- | --- | --- | --- | --- |
| Redactar borrador de conclusiones | Speaker 1 | No especificada | No especificada | Seguir estructura de 3 puntos (1–2 páginas) |
### Preguntas abiertas
- ¿Fecha específica para la entrega del siguiente bloque de correcciones sobre el documento actualizado por parte de Speaker 2? [???]
---
## Verificación de cobertura de temas
- Tema 1 (Capítulo 6 y centralidad): Cubierto.
- Tema 2 (Limitaciones metodológicas y GTFS): Cubierto.
- Tema 3 (Topología y clasificación multidimensional): Cubierto.
- Tema 4 (Cobertura y GTFS; acotación CDMX): Cubierto.
- Tema 5 (Calificación y percentiles): Cubierto.
- Tema 6 (Mapas y red actual): Cubierto.
- Tema 7 (Correcciones y nota de versión): Cubierto.
- Tema 8 (Editorial, organización, definiciones): Cubierto.
- Tema 9 (Conceptos y compensabilidad): Cubierto.
- Tema 10 (Figuras, tablas, ecuaciones): Cubierto.
- Tema 11 (Plan de revisión y PDF): Cubierto.
- Tema 12 (Sinodales y administración): Cubierto.
- Tema 13 (Título): Cubierto.
- Tema 14 (Estado del arte vs. metodología): Cubierto.
- Tema 15 (Conclusiones): Cubierto.

## Fotos relacionadas

[image]
[image]
[image]
[image]
[image]
[image]
[image]
[image]
[image]
[image]
[image]