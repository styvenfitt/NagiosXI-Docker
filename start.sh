#!/bin/bash

echo "🚀 Iniciando Nagios XI en Ubuntu 22.04..."

# Configurar variables de entorno predeterminadas
export DB_HOST=${DB_HOST:-localhost}
export DB_USER=${DB_USER:-nagiosxi}
export DB_PASS=${DB_PASS:-nagiosxi}
export DB_NAME=${DB_NAME:-nagiosxi}

# Iniciar servicios básicos de Ubuntu necesarios
echo "� Iniciando servicios del sistema..."

# Crear directorios necesarios si no existen
mkdir -p /var/run/apache2
mkdir -p /var/lock/apache2
mkdir -p /var/log/apache2
mkdir -p /usr/local/nagios/var
mkdir -p /usr/local/nagios/var/spool/checkresults

# Configurar permisos
chown -R www-data:www-data /var/run/apache2
chown -R www-data:www-data /var/log/apache2
chown -R nagios:nagios /usr/local/nagios/var

echo "🌐 Iniciando Apache..."
/usr/sbin/apache2ctl -D FOREGROUND &

echo "⏰ Iniciando Cron..."
service cron start

echo "📊 Iniciando Rsyslog..."
service rsyslog start

# Si existe configuración de Nagios, intentar iniciarlo
if [ -f "/usr/local/nagios/bin/nagios" ]; then
    echo "� Iniciando Nagios Core..."
    /usr/local/nagios/bin/nagios -d /usr/local/nagios/etc/nagios.cfg
fi

echo "✅ Servicios iniciados."
echo ""
echo "🎉 Nagios XI está ejecutándose!"
echo "📱 Acceso web: http://localhost:8080/nagiosxi/"
echo ""
echo "📋 Para depuración, puedes ejecutar:"
echo "   docker exec -it nagiosxi-test bash"
echo ""

# Mantener el contenedor ejecutándose
echo "🔄 Manteniendo servicios activos..."
while true; do
    # Verificar que Apache siga ejecutándose
    if ! pgrep apache2 > /dev/null; then
        echo "⚠️  Apache se detuvo, reiniciando..."
        /usr/sbin/apache2ctl start
    fi
    sleep 30
done

