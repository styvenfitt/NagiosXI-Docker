#!/bin/bash
/usr/sbin/init

# Esperar a que la base de datos esté disponible
echo "⏳ Esperando a que MariaDB esté disponible en $DB_HOST..."
until mysql -h"$DB_HOST" -u"$DB_USER" -p"$DB_PASS" -e "SELECT 1;" "$DB_NAME" &>/dev/null; do
  sleep 3
done
echo "✅ MariaDB está disponible."

# Iniciar servicios necesarios
echo "🚀 Iniciando servicios de Nagios XI..."

# starting services

# Apache
/sbin/service httpd start

# Otros servicios
/sbin/service ajaxterm start
/sbin/service crond start
/sbin/service xinetd start
/sbin/service ndo2db start
/sbin/service npcd start
/sbin/service nagios start
/sbin/service rsyslog start

#repair database to ensure consistency
echo "🛠️ Reparando base de datos..."
/usr/local/nagiosxi/scripts/repair_databases.sh

# Reiniciar cron por si acaso
/sbin/service crond restart

# welcome everyone

cat <<-EOF

	🎉 Bienvenido a Nagios XI

	Accede a la interfaz web en:
	    http://your_ip/nagiosxi/

EOF

# Mostrar logs en tiempo real
tail -F /usr/local/nagios/var/nagios.log

