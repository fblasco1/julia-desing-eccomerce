# CI/CD: GitHub → FTP Tienda Nube (Julia Design)

## Seguridad

- **Nunca** subas `FTP_PASSWORD` al repositorio ni lo pegues en issues/chats.
- Si la contraseña se expuso, **cambiála en Tienda Nube** y actualizá el secret en GitHub.

## Secretos en GitHub

En el repo: **Settings → Secrets and variables → Actions → New repository secret**

| Secret | Descripción |
|--------|-------------|
| `FTP_SERVER` | Host FTP que te da TN (ej. `ftp.tiendanube.com`) |
| `FTP_USERNAME` | Usuario FTP del theme |
| `FTP_PASSWORD` | Contraseña FTP |

Opcional: si TN indica carpeta remota concreta, podés agregar `FTP_SERVER_DIR` y en `.github/workflows/deploy.yml` descomentar `server-dir: ${{ secrets.FTP_SERVER_DIR }}`.

## Cuándo se despliega

- **Push a la rama `main`** (o manualmente: **Actions → Deploy theme to Tienda Nube (FTP) → Run workflow**).

## Qué se sube

El contenido del repo **excepto** lo listado en `exclude` del workflow (`.github/`, `index.html` de prototipo, `assets/`, etc.). Ajustá esa lista si agregás carpetas solo locales.

## Rama `main`

Convención recomendada: **`main` = lo que debe estar en producción**. Desarrollá en ramas `feature/*` y mergeá a `main` cuando quieras publicar.

## Estado incremental (obligatorio para delta entre ejecuciones)

El workflow usa [FTP-Deploy-Action](https://github.com/SamKirkland/FTP-Deploy-Action), que mantiene un archivo **`.ftp-deploy-sync-state.json`** en la **raíz del repositorio**.

- **Primera ejecución:** puede subir todo (no hay estado previo en el repo).
- **Siguientes ejecuciones:** solo suben archivos **nuevos o modificados** respecto a ese estado.

Para que el estado sobreviva entre runs de GitHub Actions, el workflow incluye un paso que **commitea y pushea** `.ftp-deploy-sync-state.json` con el mensaje **`[skip ci]`** para **no disparar otro deploy** en bucle.

### Requisitos en GitHub

- **Settings → Actions → General → Workflow permissions**: debe permitir que los workflows tengan permisos de escritura (o el `permissions: contents: write` del YAML ya lo pide para el `GITHUB_TOKEN`).
- Si **`main` está protegida** y bloquea push directo, el paso “Guardar estado incremental” puede fallar: en ese caso habilitá excepción para `github-actions[bot]` o usá un PAT con permisos en un secret (avanzado).

### Archivo en el repo

- Tras el **primer deploy exitoso**, deberías ver el commit automático con `.ftp-deploy-sync-state.json`. **No lo borres** del historial si querés seguir con despliegues incrementales.
- **No** agregues `.ftp-deploy-sync-state.json` al `.gitignore`.

### Limpieza total del servidor

Con `dangerous-clean-slate: false` **no** se eliminan en el FTP archivos que ya no existen en el repo. Si alguna vez necesitás un espejo exacto (borrar remotos huérfanos), revisá la documentación de la acción y usá `dangerous-clean-slate: true` **solo** cuando sepas el riesgo.
