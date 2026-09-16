# tableau/geo_proxy/

Servidor proxy ligero (FastAPI, puerto 5050) que sirve los GeoJSON de Apimetro y VFTModel
como **Spatial Files** para Tableau Desktop.

## Por qué existe este proxy

Tableau Desktop puede recibir datos tabulares a través de un WDC, pero **no puede recibir
geometrías complejas** (MultiLineString, MultiPolygon) por esa vía.
La solución es conectar Tableau vía **Spatial File connector**, que sí entiende GeoJSON.
El proxy actúa de puente: expone los endpoints de las APIs como URLs locales que
Tableau puede consumir directamente como fuentes espaciales.

```
Tableau Desktop
  → Conectar → Archivo espacial → http://localhost:5050/apimetro/lineas.geojson
                                           ↓
                                      GeoProxy :5050
                                           ↓
                                    Apimetro :8080/movilidad/mapas/geojsonLinea
```

## Arrancar el proxy

```bash
# Desde la raíz del repo
cd tableau/geo_proxy

# Instalar dependencias (primera vez)
pip install -r requirements.txt

# Copiar y ajustar variables de entorno
cp .env.example .env

# Arrancar
uvicorn main:app --port 5050 --reload
```

El proxy queda disponible en `http://localhost:5050`.
La documentación interactiva (Swagger) en `http://localhost:5050/docs`.

## Variables de entorno (`.env`)

| Variable | Default | Descripción |
|----------|---------|-------------|
| `APIMETRO_URL` | `http://localhost:8080` | URL base de Apimetro |
| `VFTMODEL_URL` | `http://localhost:8000` | URL base de VFTModel |

## Endpoints disponibles

### Apimetro (operativo)

| URL | Geometría | Filtros query |
|-----|-----------|--------------|
| `/apimetro/lineas.geojson` | MultiLineString | `?sistema=METRO` |
| `/apimetro/poligonos.geojson` | MultiPolygon | — |
| `/apimetro/estaciones.geojson` | Point | `?sistema=METRO` |

### VFTModel (requiere CORS habilitado en VFTModel)

| URL | Geometría | Filtros query |
|-----|-----------|--------------|
| `/vftmodel/cobertura.geojson` | MultiPolygon / Polygon | `?layer=cobertura_800m` |
| `/vftmodel/capillary.geojson` | Point | `?layer=fc_puntos` |
| `/vftmodel/detour.geojson` | Point / Polygon | `?layer=df_por_alcaldia` |

> **Nota VFTModel**: agregar `CORSMiddleware` en `VFTModel/src/api/main.py` antes de usar
> los endpoints `/vftmodel/*`. Ver `tableau/connectors/README.md`.

## Cómo conectar en Tableau Desktop

1. Con el proxy corriendo en `:5050`, abrir Tableau Desktop.
2. **Conectar → Más... → Archivo espacial**.
3. Escribir la URL del endpoint deseado en el campo de ruta:
   ```
   http://localhost:5050/apimetro/lineas.geojson
   ```
4. Tableau descarga el GeoJSON y crea una fuente espacial.
5. (Opcional) Extraer a `.hyper` para trabajar sin el proxy corriendo.

## Servicios requeridos para trabajar localmente

| Servicio | Puerto | Cómo arrancar |
|----------|--------|--------------|
| Apimetro | 8080 | `cd ../apimetro && go run cmd/main.go` |
| VFTModel | 8000 | `cd ../VFTModel && uvicorn src.api.main:app --reload` |
| GeoProxy | 5050 | `uvicorn main:app --port 5050` (este archivo) |
