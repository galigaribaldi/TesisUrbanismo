# 09-04 Reunión de Tesis: Planificación, Herramienta de Visualización 'Apímetro' y Reenfoque Estratégico

# Resumen de Reunión Técnica - Planificación de Tesis de Maestría
**Fecha de la Reunión:** 04 de septiembre de 2026
**Hora de la Reunión:** 14:46:59
**Asistentes:** Galileo (Estudiante de Maestría), Tutor (Ingeniero/Asesor)
### **Índice de Temas**
1. **Revisión y Comentarios del Borrador de la Tesis**
   - Revisión por el Dr. Jairo Olguín Roque
   - Recomendaciones de la Profesora Ruth
   - Próximos Pasos para el Desarrollo de la Tesis
2. **Desarrollo de la Herramienta de Visualización ("Apímetro")**
   - Tecnologías Utilizadas (Tableau y TikZ)
   - Visualización de Datos de Afluencia
   - Análisis del Indicador de Calidad de Servicio
3. **Reenfoque Estratégico y Estructura de la Tesis**
   - Cambio de Enfoque: De Análisis de Caso a Venta de Herramienta
   - Estructura Sugerida para la Tesis
   - Audiencia Objetivo: Urbanistas sin Conocimientos de Programación
4. **Planificación y Cronograma de Trabajo**
   - Fechas de Entrega Clave
   - Proceso de Revisiones
5. **Búsqueda y Gestión de Sínodos**
   - Sínodo Propuesto: Dr. Jairo Olguín Roque
   - Sínodos Potenciales: Dr. Enrique Pérez y Héctor Reséndiz
   - Estrategia de Contacto
---
### **1. Revisión y Comentarios del Borrador de la Tesis**
Se discutieron los comentarios recibidos de revisores externos sobre el borrador actual de la tesis de Galileo, centrada en una herramienta de análisis de transporte.
#### **1.1. Revisión por el Dr. Jairo Olguín Roque**
Galileo presentó los comentarios del Dr. Jairo Olguín Roque de FES Acatlán, UNAM, quien es especialista en matemáticas aplicadas. El Dr. Olguín revisó la tesis para validar la metodología y la coherencia de los cálculos.
- **Comentarios Generales:** El Dr. Olguín consideró que el trabajo está bien fundamentado, pero señaló áreas de mejora.
- **Título:** Sugirió reorientar el título para que refleje claramente la aplicación en urbanismo mediante una herramienta tecnológica. El título actual, centrado en "transportes anillares", podría ser secundario.
- **Extensión del Contenido:** Aconsejó a Galileo no extender más la tesis, ya que el contenido actual es suficientemente denso y robusto. La propuesta de analizar un segundo anillo exterior fue descartada y sugerida como material para futuros artículos o un doctorado.
- **Correcciones Menores:** Identificó errores de ortografía y puntuación en el documento, específicamente relacionados con el formato en LaTeX.
- **Propuesta como Sínodo:** El Dr. Olguín se ofreció para ser uno de los sínodos de la tesis.
#### **1.2. Recomendaciones de la Profesora Ruth**
La profesora Ruth, junto con el Dr. Olguín, recomendó mejorar la visualización de los resultados.
- **Visualización de Datos:** Se señaló que la tesis contiene texto muy denso en la sección de resultados. La recomendación fue incorporar más mapas y gráficas para ilustrar el proceso y las conclusiones de manera más accesible y visualmente atractiva, especialmente para una audiencia de urbanistas.
- **Claridad del Proceso:** Se debe visualizar no solo el resultado final del modelo BFD (Análisis de Flujo de Transporte), sino también las capas intermedias del proceso para que el lector pueda seguir el razonamiento.
#### **1.3. Próximos Pasos para el Desarrollo de la Tesis**
Galileo está trabajando en implementar estas recomendaciones:
- Mover detalles técnicos, como las tablas de modelo de datos relacional y código, a los anexos para no sobrecargar el cuerpo principal del documento.
- Desarrollar activamente las visualizaciones de datos para cada capa de análisis.
#### **Perspectiva de IA (auto)**
- **Puntos no resueltos:** Aunque se acordó reorientar el título, no se definió una versión final. El título provisional discutido fue **"Modelado de toma de decisiones para la planeación de transporte"**. La estrategia exacta para "compactar" el texto sin perder rigor técnico aún es abstracta y requerirá un trabajo editorial detallado.
- **Recomendaciones:**
  1. **Taller de Título:** Realizar una sesión de lluvia de ideas con los tres asesores (Tutor, Ruth, Jairo) para definir un título final que equilibre el rigor técnico con el enfoque de mercado (urbanismo).
  2. **Crear una "Guía de Estilo de Contenido":** Definir qué se considera "demasiado técnico" y debe ir a un anexo. Por ejemplo: `Todo fragmento de código SQL/Python > 5 líneas`, `definiciones matemáticas formales que no sean cruciales para el argumento principal`, y `diagramas de entidad-relación detallados`.
---
### **2. Desarrollo de la Herramienta de Visualización ("Apímetro")**
Galileo presentó los avances en la herramienta de visualización de datos, denominada "Apímetro", que forma parte central de su tesis. El objetivo es traducir los datos y resultados complejos en gráficos comprensibles para los urbanistas.
#### **2.1. Tecnologías Utilizadas (Tableau y TikZ)**
- **Tableau:** Galileo está utilizando Tableau para crear dashboards interactivos. Aprovechó su experiencia laboral reciente para generar visualizaciones dinámicas de los datos de afluencia y otros indicadores.
- **TikZ/LaTeX:** Para los diagramas más estáticos y esquemáticos dentro del documento de la tesis, Galileo está utilizando el paquete TikZ de LaTeX. Aunque el proceso es laborioso, permite generar gráficos vectoriales de alta calidad directamente en el documento. Se mencionó el uso de asistentes de IA como `ChatGPT` para depurar el código de TikZ.
#### **2.2. Visualización de Datos de Afluencia**
Se mostraron y discutieron varios gráficos generados en Tableau:
- **Afluencia por Línea de Metro:** Una gráfica lineal que muestra el número de pasajeros por línea de metro. Los datos se obtienen del Portal de Datos Abiertos, se descargan y se procesan para ser integrados en el sistema de Galileo.
- **Top 10 de Estaciones con Mayor Afluencia:** Un gráfico de barras que identifica las estaciones más congestionadas (Pantitlán, Indios Verdes, Cuatro Caminos, etc.). Este gráfico sirve para justificar la necesidad de un sistema de transporte anillar, demostrando que los puntos de mayor saturación coinciden con las ubicaciones propuestas para el anillo periférico.
- **Afluencia por Mes:** Se generó un gráfico que desglosa la afluencia mensual. La profesora Ruth consideró que este nivel de granularidad podría ser redundante y no aportar información significativamente diferente a la afluencia anual.
[image]

#### **2.3. Análisis del Indicador de Calidad de Servicio**
Se discutió un gráfico complejo que compara la **velocidad promedio (Km/h)** y la **frecuencia (minutos)** de diferentes corredores de transporte.
- **Indicador IBTF:** El gráfico demuestra la funcionalidad del "apímetro IBTF". Muestra que el sistema **INTERURBANO** es el más eficiente (alta velocidad, frecuencia óptima), mientras que el **RTP** es el más deficiente (baja velocidad).
- **Problema de Interpretación:** La profesora Ruth advirtió que el gráfico no es autoexplicativo. Se acordó que debe ser presentado en la tesis junto con una sección dedicada que explique en detalle:
  1. **Qué es el indicador.**
  2. **Cómo se calcula.**
  3. **Para qué sirve.**
  4. **Qué resultados específicos arroja el Apímetro y cómo interpretarlos.**
- **Análisis "Antes y Después":** Se planea usar este y otros indicadores para realizar un análisis comparativo: mostrar el estado actual del sistema y luego simular el impacto de la propuesta del "Anillo de Transporte" para visualizar las mejoras.
#### **Perspectiva de IA (auto)**
- **Puntos no resueltos:** El flujo de datos desde el Portal de Datos Abiertos es manual (`descargar y procesar`). No se discutió una automatización del pipeline de ingesta de datos, lo cual podría ser una limitación para la escalabilidad y actualización de la herramienta a futuro. Además, no se definió la nomenclatura final ni la fórmula exacta que se presentará en la tesis para el "indicador de calidad de servicio".
- **Recomendaciones:**
  1. **Automatización de Datos:** Como trabajo futuro, proponer el desarrollo de un script (e.g., Python con `requests` y `pandas`) que se conecte a la API del portal (si existe) o automatice la descarga y limpieza de los archivos CSV/JSON para mantener los datos del "Apímetro" actualizados con mínima intervención manual.
  2. **Formalización del Indicador:** Crear una subsección titulada **"Métrica de Eficiencia de Corredor (MEC)"** donde se presente la fórmula matemática formal, se definan sus componentes (velocidad, frecuencia) y se justifique su relevancia desde la teoría de planificación de transporte.
---
### **3. Reenfoque Estratégico y Estructura de la Tesis**
La discusión más importante de la reunión fue el cambio en el enfoque fundamental de la tesis: pasar de un estudio de caso sobre un anillo de transporte a la "venta" de una herramienta de software para urbanistas.
#### **3.1. Cambio de Enfoque: De Análisis de Caso a Venta de Herramienta**
- **Enfoque Original:** Resolver un problema específico de urbanismo (la necesidad de un anillo de transporte en la periferia).
- **Nuevo Enfoque:** Presentar "Apímetro" como una herramienta de modelado de toma de decisiones para la planificación de transporte. La tesis se convierte en un argumento de venta para convencer a los urbanistas de la utilidad y potencia de la herramienta. El análisis del anillo de transporte se utilizará como un **caso de estudio hipotético** para demostrar las capacidades del software.
#### **3.2. Estructura Sugerida para la Tesis**
Para reflejar este nuevo enfoque, se recomendó la siguiente estructura:
1. **Ocultar Detalles Técnicos:** Elementos como modelos de datos relacionales, código fuente y configuraciones complejas de bases de datos deben ser movidos a los anexos. El cuerpo principal de la tesis debe ser accesible para alguien sin conocimientos de programación.
2. **Resaltar Propiedades Urbanísticas:** El foco debe estar en las **funcionalidades y propiedades urbanísticas** del "apímetro IBTF". Se debe explicar qué análisis permite hacer, qué preguntas puede responder y cómo facilita la toma de decisiones.
3. **Sección de Resultados como "Demostración de Venta":** La sección de resultados urbanísticos debe usar mapas, gráficos y análisis para demostrar de manera convincente la utilidad de la herramienta. Debe comunicarse directamente con los urbanistas, mostrando cómo pueden aplicar la herramienta a sus propios problemas.
4. **Normalización de Datos GTFS:** Resaltar como una ventaja clave que la herramienta puede procesar datos GTFS **no normalizados**, un problema común que enfrentan los planificadores de transporte.
#### **3.3. Audiencia Objetivo: Urbanistas sin Conocimientos de Programación**
Se subrayó que el público objetivo son los urbanistas que pueden tener conocimientos de Sistemas de Información Geográfica (GIS) pero no necesariamente de programación, bases de datos o ciencia de datos. La herramienta debe presentarse como una solución "plug-and-play" que abstrae la complejidad técnica.
#### **Perspectiva de IA (auto)**
- **Puntos no resueltos:** El "cambio de enfoque" es conceptual. No se ha definido un plan concreto de reescritura de los capítulos existentes (introducción, marco teórico). La transición de un tono académico-analítico a uno de "marketing de producto" requiere una habilidad de escritura específica que podría ser un desafío.
- **Recomendaciones:**
  1. **Crear un "User Persona":** Definir un perfil detallado del "urbanista objetivo" (e.g., "Ana, 35 años, planificadora de movilidad en una agencia gubernamental, experta en ArcGIS pero con nulos conocimientos de Python"). Escribir la tesis dirigiéndose a esta persona.
  2. **Reestructurar la Introducción:** La introducción debe ser reescrita para plantear el problema no como "la falta de un anillo de transporte", sino como **"la falta de herramientas accesibles para que los urbanistas modelen y evalúen escenarios de planificación de transporte de manera ágil y sin barreras técnicas"**. El "Apímetro" se presenta como la solución a este problema.
---
### **4. Planificación y Cronograma de Trabajo**
Se establecieron fechas límite y un proceso de revisión para asegurar la finalización de la tesis en el semestre en curso.
#### **4.1. Fechas de Entrega Clave**
- **Artículo para Congreso:** La fecha límite de entrega es el **miércoles de la semana siguiente** (aproximadamente 9-11 de septiembre de 2026). Este artículo servirá como un resumen del trabajo.
- **Borrador Alfa de la Tesis:** La fecha límite para entregar el primer borrador completo (versión alfa) al tutor es el **15 de octubre de 2026**.
- **Envío a Sínodos:** El objetivo es enviar la versión final de la tesis a los sínodos a **finales de noviembre de 2026**. Esto permitiría que el proceso de revisión comience antes de las vacaciones de diciembre, con el objetivo de titularse en enero de 2027.
#### **4.2. Proceso de Revisiones**
Se definió un plan de 3 revisiones principales antes de la defensa:
1. **Revisión Alfa (15 de octubre):** El tutor realizará una revisión exhaustiva para reestructurar el contenido, enfocarlo al urbanismo y hacer correcciones mayores. Se advirtió a Galileo que esta revisión implicará muchos cambios.
2. **Revisión Beta:** Una segunda ronda de revisiones para afinar los cambios de la versión alfa.
3. **Revisión de Pulido:** Una tercera revisión para detalles finos antes de enviar a los sínodos.
#### **Perspectiva de IA (auto)**
- **Puntos no resueltos:** El cronograma es ambicioso, especialmente la entrega del borrador alfa para el 15 de octubre, considerando que implica una reescritura significativa para adoptar el nuevo enfoque. No se estableció un plan de contingencia si no se cumple esta fecha.
- **Recomendaciones:**
  1. **Desglosar Tareas con un Diagrama de Gantt:** Crear un cronograma detallado que desglose la reescritura de cada capítulo, el desarrollo de visualizaciones y la redacción del artículo. Asignar estimaciones de tiempo a cada tarea para evaluar la viabilidad del 15 de octubre y ajustar si es necesario.
  2. **Establecer Check-ins Semanales:** Dado el plazo ajustado, programar reuniones cortas (15-20 minutos) cada semana hasta el 15 de octubre para resolver dudas rápidamente y asegurar que el trabajo avance en la dirección correcta, evitando grandes desviaciones.
---
### **5. Búsqueda y Gestión de Sínodos**
Se discutió la composición del comité sinodal y los pasos a seguir para formalizarlo.
#### **5.1. Sínodo Propuesto: Dr. Jairo Olguín Roque**
- El Dr. Olguín, quien ya revisó la tesis, expresó su interés en ser sínodo. Al ser un profesor externo al padrón de tutores de urbanismo (es de matemáticas aplicadas), se deberá seguir un proceso administrativo para justificar su inclusión.
- **Justificación:** Su perfil es ideal dado el fuerte componente cuantitativo y de modelado matemático de la tesis. Probablemente entraría como sínodo suplente.
#### **5.2. Sínodos Potenciales**
El tutor sugirió contactar a los siguientes académicos, ya que el padrón de tutores no estaba disponible en ese momento:
- **Dr. Enrique Pérez:** Geógrafo (`eperez@geografia.unam.mx`). Se recomendó contactarlo y explicarle el proyecto.
- **Héctor Reséndiz:** También del área de Geografía.
- **Miembro de Acatlán:** Se sugirió buscar en el padrón de tutores (una vez disponible) a un especialista en transporte de FES Acatlán.
#### **5.3. Estrategia de Contacto**
Se recomendó el siguiente protocolo para contactar a los sínodos potenciales a finales de septiembre:
1. Enviar un correo electrónico explicando el tema de la tesis y el enfoque de la herramienta.
2. Adjuntar el artículo del congreso como un resumen del trabajo.
3. Mencionar que el borrador completo estará listo para revisión alrededor de noviembre.
4. Preguntar si estarían interesados en ser sínodos o si podrían recomendar a otro colega.
#### **Perspectiva de IA (auto)**
- **Puntos no resueltos:** La estrategia depende de la disponibilidad del padrón de tutores, que actualmente no está en línea. No se definió un plan B si los Dres. Pérez y Reséndiz no están disponibles o no son adecuados para el tema.
- **Recomendaciones:**
  1. **Networking Proactivo:** En lugar de esperar al padrón, Galileo debería pedir a la profesora Ruth y al Dr. Jairo que le presenten directamente a colegas suyos que trabajen en temas de transporte y GIS, aprovechando sus redes profesionales.
  2. **Preparar un "Paquete de Sínodo":** Crear un documento conciso de 1-2 páginas que incluya: el abstract de la tesis, una breve biografía de Galileo, los objetivos del proyecto y una demostración visual (un enlace a un dashboard de Tableau o un video corto). Esto haría la propuesta más atractiva y fácil de evaluar para los posibles sínodos.
---
### **Mapa Mental de la Reunión**
[image]

%22%2C%20fillcolor%3D%22%23CD5C5C%22%5D%3B%0A%22Ap%C3%ADmetro%22%20--%20sub_api1%3B%0Asub_api2%20%5Blabel%3D%22Datos%20de%20Afluencia%22%2C%20fillcolor%3D%22%23CD5C5C%22%5D%3B%0A%22Ap%C3%ADmetro%22%20--%20sub_api2%3B%0Asub_api3%20%5Blabel%3D%22Indicador%20Calidad%20Servicio%22%2C%20fillcolor%3D%22%23CD5C5C%22%5D%3B%0A%22Ap%C3%ADmetro%22%20--%20sub_api3%3B%0A%0Asub_enf1%20%5Blabel%3D%22Cambio%20a%20Venta%20de%20Herramienta%22%2C%20fillcolor%3D%22%2320B2AA%22%5D%3B%0A%22Enfoque%20Tesis%22%20--%20sub_enf1%3B%0Asub_enf2%20%5Blabel%3D%22Estructura%20Sugerida%22%2C%20fillcolor%3D%22%2320B2AA%22%5D%3B%0A%22Enfoque%20Tesis%22%20--%20sub_enf2%3B%0Asub_enf3%20%5Blabel%3D%22Audiencia%3A%20Urbanistas%22%2C%20fillcolor%3D%22%2320B2AA%22%5D%3B%0A%22Enfoque%20Tesis%22%20--%20sub_enf3%3B%0A%0Asub_plan1%20%5Blabel%3D%22Fechas%20Clave%22%2C%20fillcolor%3D%22%23D2691E%22%5D%3B%0A%22Planificaci%C3%B3n%22%20--%20sub_plan1%3B%0Asub_plan2%20%5Blabel%3D%22Proceso%20de%20Revisiones%22%2C%20fillcolor%3D%22%23D2691E%22%5D%3B%0A%22Planificaci%C3%B3n%22%20--%20sub_plan2%3B%0A%0Asub_sin1%20%5Blabel%3D%22S%C3%ADnodos%20Propuestos%22%2C%20fillcolor%3D%22%23BDB76B%22%5D%3B%0A%22S%C3%ADnodos%22%20--%20sub_sin1%3B%0Asub_sin2%20%5Blabel%3D%22Estrategia%20de%20Contacto%22%2C%20fillcolor%3D%22%23BDB76B%22%5D%3B%0A%22S%C3%ADnodos%22%20--%20sub_sin2%3B%0A%7D)