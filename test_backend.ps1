# Script para verificar la conexión con el backend FitManager
# Autor: GitHub Copilot
# Fecha: 2025-11-06

Write-Host "🔍 Verificando Backend FitManager..." -ForegroundColor Cyan
Write-Host ""

$backendUrl = "http://localhost:9090/fitmanager/v1"

# Verificar si el backend está corriendo
try {
    Write-Host "1️⃣ Verificando conexión al backend..." -ForegroundColor Yellow
    $response = Invoke-WebRequest -Uri "$backendUrl/auth/usuario/login" -Method POST -ContentType "application/json" -Body '{"email":"test","password":"test"}' -UseBasicParsing -ErrorAction SilentlyContinue
    
    Write-Host "   ✅ Backend está corriendo en puerto 9090!" -ForegroundColor Green
    Write-Host ""
} catch {
    if ($_.Exception.Response.StatusCode.value__ -eq 400 -or $_.Exception.Response.StatusCode.value__ -eq 401) {
        Write-Host "   ✅ Backend está corriendo en puerto 9090!" -ForegroundColor Green
        Write-Host "   (Respuesta 400/401 es esperada con credenciales de prueba)" -ForegroundColor Gray
        Write-Host ""
    } else {
        Write-Host "   ❌ Backend NO está corriendo!" -ForegroundColor Red
        Write-Host "   Error: No se puede conectar a $backendUrl" -ForegroundColor Red
        Write-Host ""
        Write-Host "   📝 Pasos para iniciar el backend:" -ForegroundColor Yellow
        Write-Host "   1. Abre una terminal en la carpeta del backend" -ForegroundColor White
        Write-Host "   2. Ejecuta: mvn spring-boot:run" -ForegroundColor White
        Write-Host "   3. Espera a ver: 'Started FitManagerApplication'" -ForegroundColor White
        Write-Host ""
        exit 1
    }
}

# Instrucciones para probar la app
Write-Host "2️⃣ Pasos para probar la integración:" -ForegroundColor Yellow
Write-Host ""
Write-Host "   a) Iniciar el emulador o conectar dispositivo" -ForegroundColor White
Write-Host "   b) En la carpeta 'fit_manager', ejecutar:" -ForegroundColor White
Write-Host "      flutter run" -ForegroundColor Cyan
Write-Host ""
Write-Host "   c) En la app:" -ForegroundColor White
Write-Host "      - Presionar 'Crear Cuenta'" -ForegroundColor White
Write-Host "      - Llenar el formulario completo" -ForegroundColor White
Write-Host "      - Debe navegar al Dashboard automáticamente" -ForegroundColor White
Write-Host ""

# Información adicional
Write-Host "3️⃣ Configuración del frontend:" -ForegroundColor Yellow
Write-Host ""
Write-Host "   📱 Emulador Android: http://10.0.2.2:9090/fitmanager/v1 (configurado)" -ForegroundColor Green
Write-Host "   📱 Dispositivo físico: Cambiar a tu IP local en auth_service.dart" -ForegroundColor Gray
Write-Host ""

Write-Host "4️⃣ Endpoints disponibles:" -ForegroundColor Yellow
Write-Host ""
Write-Host "   POST /auth/usuario/login      - Iniciar sesión" -ForegroundColor White
Write-Host "   POST /auth/usuario/register   - Registrar usuario" -ForegroundColor White
Write-Host "   POST /auth/change-password    - Cambiar contraseña" -ForegroundColor White
Write-Host "   POST /auth/logout             - Cerrar sesión" -ForegroundColor White
Write-Host ""

Write-Host "✅ Verificación completada!" -ForegroundColor Green
Write-Host ""
Write-Host "📚 Ver documentación completa en: INTEGRACION_BACKEND.md" -ForegroundColor Cyan
