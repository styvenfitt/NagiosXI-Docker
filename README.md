
# 🛰️ Nagios XI + Docker + Rocky Linux

Monitorización empresarial lista para producción en contenedores Docker, con **Nagios XI** sobre una base moderna y sólida como **Rocky Linux 9**, y base de datos desacoplada mediante **MariaDB** en un contenedor independiente.

---

## 🚀 Características principales

- 🐳 **Contenedor personalizado de Nagios XI**
- 🧱 **Base sólida en Rocky Linux 9**
- 🛢️ **MariaDB externa mediante Docker Compose**
- ⚙️ Instalación automatizada y lista para escalar
- 🔧 Start script que espera a base de datos antes de iniciar
- 📁 Volúmenes persistentes y variables configurables

---

## 📦 Despliegue rápido

```bash
git clone https://github.com/tu-usuario/nagiosxi-docker.git
cd nagiosxi-docker
docker-compose up -d

```
El acceso por defecto estará disponible en:
http://localhost/nagiosxi/

📁 Estructura del proyecto
nagiosxi-docker/
├── Dockerfile
├── docker-compose.yml
├── start.sh
├── config.inc.php
├── scripts/
└── README.md

⚙️ Variables configurables (docker-compose.yml)
```yalm
environment:
  DB_HOST: mariadb
  DB_NAME: nagiosxi
  DB_USER: nagios
  DB_PASS: nagiospass
```
Puedes modificarlas fácilmente para adaptarlas a tu entorno.

📈 Requisitos
Docker >= 20.10

Docker Compose >= 1.29

Al menos 2 GB de RAM asignados al entorno

# Docker container for Nagios XI

At the moment this is a quick and dirty built, but it works.
It is based on the fullinstall-script provided by the NagiosXI team, so as long as they don 't change to much stuff, it will keep working.

You can start the container with the command:

```
docker run -d -p 80:80 -p 5666:5666 -p 5667:5667 --name nagiosxi tgoetheyn/docker-nagiosxi
```

Afterwards you can access the console at:

```
http://YOUR_IP/nagiosxi/
```

Finish the installation wizard and enjoy!


You can safelly ignore the "SSH" error and "ntpd" warning in Nagios.
it's normal because the container doesn't have SSH enabled.
Also ntpd can 't run, because it cannot change the system time.

For licensing, change to "free license" to keep using the product.
The free license implice a 7 host limit.

🧠 Créditos
Inspirado y adaptado desde múltiples fuentes de la comunidad. Esta versión está orientada a entornos modernos y simplificados para despliegue rápido en local, laboratorio o producción.

🔐 Aviso de licencia
Nagios XI es un producto de Nagios Enterprises. Esta imagen está pensada para ser usada con fines de evaluación o con una licencia válida del producto.
