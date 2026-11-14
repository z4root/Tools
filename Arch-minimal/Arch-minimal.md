### Environment

#bspw #sxhkd #alacritty
#nvim #obsidian #virt-manager

- icons: https://www.nerdfonts.com/cheat-sheet

https://computingforgeeks.com/install-kvm-arch-linux/

##### Single Source of Truth

Arquitectura para cambiar el tema en alacritty y en nvim a la vez...

- El ususario puede eleguir el tema desde la propia terminal me refiero a que puede poner como `chthems <num/nombrek>`
- Base minimalista: `bspwm`, `sxhkd`, Xorg y `startx`
- Herramientas de trabajo: Alacritty, Neovim y Obsidian.
- Personalización: tus 42 temas de Neovim y 39 de Alacritty.
- Configuración reproducible: posibilidad de llevar tus preferencias a otras laptops.

Preguntar si entorno minimalista para desarrollo y para dia a dia, o entorno de hacking para VM o para environment de hacking en general y descargar las dependencias y configuraciones, como el Virt-manager para tus maquinas, dependidneo si estas en una maquina virtual obviamente no se debe instalar el Virt-manager en tu maquina virtual redundante, estonces debe detectar si tu estas en una VM si no estas en vm ahi si instar virt-manager y configurar, y tambien configurar la red si no esta configurarla.

Poner mi configuracion de atajos tambien...

Main environment:

- bspwm & sxhkd
- alacritty
- nvim
- obsidian
- Fancy-i3loocker (Mi implementacion dar credito)
- Virt-manager (Maquinas y tu maquina de hacking...)

---

#### Monitores

¡Claro! Vamos a desglosar tu salida de `xrandr` en Linux columna por columna, porque tiene algunos detalles interesantes, especialmente los símbolos `*` y `+`, las frecuencias y las dimensiones físicas.

## 1. Cómo leer la cabecera

Tu salida comienza así:

bash

```
Screen 0: minimum 320 x 200, current 1920 x 1200, maximum 16384 x 16384
eDP-1 connected primary 1920x1200+0+0 (normal left inverted right x axis y axis) 345mm x 215mm
```

La primera línea describe el espacio de pantalla que administra el servidor gráfico:

| Campo                   | Significado                                                                                |
| ----------------------- | ------------------------------------------------------------------------------------------ |
| `Screen 0`              | Identificador de la pantalla lógica de X11. No significa necesariamente un monitor físico. |
| `minimum 320 x 200`     | Resolución lógica mínima permitida.                                                        |
| `current 1920 x 1200`   | Tamaño actual del escritorio en píxeles.                                                   |
| `maximum 16384 x 16384` | Tamaño máximo del framebuffer que admite la configuración actual.                          |

La segunda línea describe tu salida de vídeo:

| Campo                                        | Significado                                                                              |
| -------------------------------------------- | ---------------------------------------------------------------------------------------- |
| `eDP-1`                                      | Nombre de la salida gráfica. `eDP` suele identificar la pantalla interna de un portátil. |
| `connected`                                  | La salida está conectada y detectada.                                                    |
| `primary`                                    | Es la pantalla principal del escritorio.                                                 |
| `1920x1200+0+0`                              | Resolución actual y posición de la pantalla en el escritorio virtual.                    |
| `(normal left inverted right x axis y axis)` | Orientaciones que admite `xrandr` para esa salida.                                       |
| `345mm x 215mm`                              | Dimensiones físicas aproximadas del panel: 34,5 × 21,5 cm.                               |

Por ejemplo, en `1920x1200+0+0`:

- `1920`: ancho en píxeles.

- `1200`: alto en píxeles.

- `+0+0`: posición de la esquina superior izquierda, con coordenadas X = 0 e Y = 0.

Si conectaras otro monitor a la derecha, podría aparecer una posición como `1920x1080+1920+0`.

## 2. Las columnas de las resoluciones

Esta es la parte más importante de tu salida:

text

```
1920x1200    165.01*+  60.01 +  59.88    59.95
1920x1080     60.01    59.97    59.96    59.93
1600x1200     85.00    75.00    70.00    65.00    60.00
```

Cada fila representa una resolución disponible, pero cada número que aparece después de ella es una frecuencia de refresco posible para esa resolución.

Ejemplo desglosado

## 1920×1200

Resolución

## 165.01

Hz

## *

Modo activo

## +

Modo preferido

En tu caso, la pantalla está funcionando a 1920 × 1200 y 165,01 Hz.

Veamos qué significa cada elemento.

### Resolución: `1920x1200`

Es la cantidad de píxeles que se dibujan en la pantalla:

- `1920`: píxeles horizontales.

- `1200`: píxeles verticales.

La resolución determina el espacio de trabajo y la definición de la imagen. No determina por sí sola el tamaño físico de los elementos, porque también interviene el escalado del escritorio.

### Frecuencia: `165.01`, `60.01`, `59.88`...

Es la frecuencia de refresco, expresada en hercios (`Hz`).

| Frecuencia  | Qué significa                                                      |
| ----------- | ------------------------------------------------------------------ |
| `165.01 Hz` | La pantalla puede actualizar la imagen unas 165 veces por segundo. |
| `85.00 Hz`  | Unas 85 actualizaciones por segundo.                               |
| `60.00 Hz`  | Unas 60 actualizaciones por segundo.                               |
| `59.88 Hz`  | Aproximadamente 59,88 actualizaciones por segundo.                 |

Una frecuencia mayor suele hacer que el movimiento se vea más fluido, especialmente al desplazarte por una página o jugar.

¿Por qué hay valores como `59.88`, `59.95` o `60.01` en lugar de exactamente `60.00`? Porque los modos de vídeo utilizan frecuencias de reloj y temporizaciones específicas. El resultado puede ser ligeramente diferente de 60 Hz.

Importante: una frecuencia de refresco de 165 Hz no significa que cualquier aplicación vaya a generar 165 fotogramas por segundo; eso depende también de la aplicación y de la GPU.

### El asterisco: `*`

Indica el modo que está activo en ese momento.

En tu salida:

text

```
1920x1200    165.01*+
```

El `*` después de `165.01` significa que ese es el refresco seleccionado actualmente.

### El signo más: `+`

Indica un modo preferido por la configuración de la pantalla o por la información EDID que proporciona el monitor.

En tu caso aparecen dos signos `+`:

text

```
1920x1200    165.01*+  60.01 +
```

Esto significa que el modo de `1920×1200` a `165.01 Hz` está activo y marcado como preferido, y que también aparece marcado como preferido el modo de aproximadamente `60.01 Hz`.

No significa que ambos estén activos a la vez: el `*` identifica el modo actual.

## 3. ¿Por qué una misma resolución tiene varias frecuencias?

Por ejemplo:

text

```
1600x1200     85.00    75.00    70.00    65.00    60.00
```

Tu pantalla anuncia varios modos para una misma resolución:

- `1600×1200 @ 85 Hz`

- `1600×1200 @ 75 Hz`

- `1600×1200 @ 70 Hz`

- `1600×1200 @ 65 Hz`

- `1600×1200 @ 60 Hz`

Cada combinación de resolución y frecuencia es un modo de vídeo distinto.

Sin embargo, esos modos no necesariamente son los más adecuados para tu panel. `xrandr` también puede mostrar modos genéricos o heredados del sistema gráfico, por lo que conviene verificar qué frecuencias admite realmente la pantalla y el controlador.

## 4. ¿Qué significan las letras de la primera columna?

En tu salida aparece esta variante:

text

```
1024x768i     86.96
```

La `i` al final indica entrelazado (interlaced).

En un modo entrelazado, la imagen se transmite en campos alternos, en lugar de actualizar todas las líneas de cada imagen de una sola vez. Es una técnica heredada de los sistemas de vídeo y no suele ser lo deseable para un escritorio moderno.

En cambio, una resolución como `1024x768` sin la `i` corresponde a un modo progresivo.

## 5. ¿Qué resoluciones tienes disponibles realmente?

Tu salida muestra, entre otras, estas posibilidades:

| Resolución  | Relación de aspecto | Uso habitual                                          |
| ----------- | ------------------- | ----------------------------------------------------- |
| `1920×1200` | 16:10               | Tu resolución actual; más espacio vertical que 1080p. |
| `1920×1080` | 16:9                | Formato panorámico habitual.                          |
| `1680×1050` | 16:10               | Resolución intermedia.                                |
| `1600×900`  | 16:9                | Menor carga gráfica que 1920×1080.                    |
| `1280×720`  | 16:9                | HD; imagen menos definida en tu panel.                |
| `1024×768`  | 4:3                 | Formato más antiguo, menos panorámico.                |

Tu panel tiene una relación de aspecto de 16:10, ya que 1920/1200=1.61920/1200=1.6. Por eso `1920×1200` aprovecha el formato de tu pantalla de manera más natural que `1920×1080`.

## 6. ¿Cómo cambiar la resolución o los Hz?

Si quieres seleccionar, por ejemplo, `1920×1200` a aproximadamente 60 Hz, puedes probar:

bash

```
xrandr --output eDP-1 --mode 1920x1200 --rate 60
```

Para volver a unos 165 Hz:

bash

```
xrandr --output eDP-1 --mode 1920x1200 --rate 165
```

Ten en cuenta que `--rate` solicita la frecuencia más cercana disponible, y que los modos exactos dependen del controlador y del entorno gráfico. Estos comandos son temporales: normalmente el cambio no persiste al reiniciar la sesión.

Puedes consultar qué modo está activo y qué modos anuncia la salida con:

bash

```
xrandr --current
```

Y comprobar si estás usando X11 o Wayland:

bash

```
echo $XDG_SESSION_TYPE
```

Esto último es importante porque `xrandr` funciona directamente con las salidas de X11; en una sesión Wayland, el resultado puede ser limitado o representar una capa de compatibilidad.

En resumen: las columnas de tu lista son la resolución, seguida de una o varias frecuencias de refresco posibles. El `*` marca la frecuencia activa, el `+` señala un modo preferido y la `i` indica entrelazado. En tu configuración actual, la pantalla interna `eDP-1` funciona a `1920×1200`, `165.01 Hz`, y está marcada como salida principal.

---

---

---

---

---

Installar bspwm , sxhkd, alacrity, nvim(configurarar) , obsidian y virt-manager(Configurar)

I use the function for monitoro configuration, the bin of the terminal taht appera in the top

### Disk partitioning

I use the following structure:

- `/boot` or `/boot/efi` (≤ 512 MB)
- `/` (root) (30 GB)
- `/home` (61.5 GB)
- `swap` (4–8 GB depending on RAM)

For Arch, I use `cfdisk` and select GPT. Even in a VM, GPT is more modern than DOS, but you can choose either.

After creating the partitions, format them:

```zsh
mkfs.vfat -F 32 /dev/sda1   # EFI
mkfs.ext4 /dev/sda2         # root
mkfs.ext4 /dev/sda3         # home
mkswap /dev/sda4
swapon /dev/sda4
```

---

### Partition layout

```zsh
NAME        MAJ:MIN RM   SIZE RO TYPE MOUNTPOINTS
nvme0n1     259:0    0 931.5G  0 disk
├─nvme0n1p1 259:1    0   512M  0 part /boot ├─nvme0n1p2 259:2    0   100G  0 part /
├─nvme0n1p3 259:3    0   130G  0 part /var  (This is optional :)
├─nvme0n1p4 259:4    0    16G  0 part [SWAP]
└─nvme0n1p5 259:5    0   685G  0 part /home

```

### Connection as ethernet or wifi:

```zsh
# Wifi

ip link (to se the interface name and the status)
ip link set 'interface' up
systemctl start iwd  (Usually the service is enable, but to be sure).
touch /var/lib/iwd/'name_of_ssid.psk'
echo "[Security]\n PreSharedKey=tu_contraseña_wifi"
iwctl station 'interface' connect 'name_of_ssid'
dhcpcd 'interface'
```

---

### Mount parttions:

Create the `dir` of your boot, as 'boot' or 'boot/efi':

```zsh

> mkdir -p /mnt/{boot,home}
> mount /dev/sda2 /mnt
> mount /dev/sda1 /mnt/boot

pacstrap -K /mnt linux linux-firmware base base-devel grub efibootmgr
```

---

### Package explanation:

- **linux:** The Linux kernel.
- **linux-firmware:** Firmware for GPU, network, sound, etc.
- **networkmanager:** Manages network connections more automatic (Wi-Fi, Ethernet, VPN).
- **wpa_supplicant:** Handles WPA/WPA2 Wi-Fi authentication.
- **grub:** Bootloader that loads the kernel.
- **efibootmgr:** Registers the boot entry in UEFI firmware.
- **base / base-devel:** Essential tools (zsh, grep, make, gcc, etc.), useful for building software and AUR.

---

### FSTAB (important):

`fstab` is a configuration file that tells the system **which partitions to mount automatically at boot and where**.

You generate it with:

```zsh

> genfstab -U /mnt >> /mnt/etc/fstab

```

**What it does:**

- Detects your partitions
- Uses UUIDs (safer than `/dev/sdX`)
- Defines mount points (`/`, `/home`, `/boot`, etc.)

Example:

```zsh
> UUID=xxxx-xxxx / ext4 defaults 0 1

> UUID=yyyy-yyyy /home ext4 defaults 0 2

> UUID=zzzz-zzzz /boot vfat defaults 0 2
```

Without `fstab`, your system will not know how to mount disks on boot.

---

Now we use: `arch-chroot /mnt` (This is the main partition, Where installed the kernel linux).
You can now do most of the operations available from your existing installation, for install the grub and create the user's.

```zsh

useradd -m "user"
usermod -aG wheel "user" #(Wheel is a special grup for make able to the user be root).
passwd user
nano /etc/sudoers #(config and uncomment the line wheel)
```

Also here in this point we can put us hostname: `echo "Arch" > /etc/hostname`.

And now we goint to install the grub:

```zsh
grub-install --target=x84_64-efi --efi-directory=/boot --bootloader-id=Grub
grub-mkconfig -o /boot/grub/grub.cfg
```

---

Now we need to reboot the system, and if everything is ok we will see the grub and choose: `Arch linux`.
And we can install the AUR repositories that isn't officially for the Arch but is supported and maintained for the community so:

```zsh

git clone https:/aur.archlinux.org/paru.git #(Local compilation For my is better less problems in my experience than 'paru-bin'.)
cd /paru
make -si

```

And also if we want to more tools we can use the black arch repository:

```zsh

curl -O https://balckarch.org/strap.sh
chmod +x strap.sh
sudo ./strap.sh

```

And if you want config the package for your self, here: `File: /etc/pacman.conf`

---

### Tiling Window Manager:

_I don't use polybar, is a personal choose_

- Bspwm + Sxhkd:

I've choose xorg insted of Wyland for the compatibile, but in the future, I will change to Wyland for suree! (And also have Nvidia :( )

Package that installed :

- `bspwm`
- `sxhkd`
- `xorg-xinit` (para poder iniciar sesión con `startx`)
- `xorg-server` (el servidor X básico)

```zsh
sudo pacman -S bspwm, sxhkd xorg-server xorg-xinit xf86-input-libinput

xorg-xdpyinfo xorg-xkill xorg-xprop xorg-xrandr xorg-xsetroot xorg-xwininfo xorg-xrdb

```

These are meta-package, and the configuration of the .xinitrc to start your environment.
I prefer to create my own file .xinitrc, but also exist this : `/etc/X11/xinit/.xinitrc`, but if you take a look most of the configuration is legacy.

I copy the example files of the "baskerville" repository of both bspwm and sxhkd:

```zsh
git clone https://github.com/baskerville/bspwm.git
pacman -S sxhkd bspwm
```

---

#### Scripts

- Scratchpad: poner un scrat bas en la parte inferio **(Mensionar al creador)**

Create a script to use with sxhkd, in order to up/down your brightness of your laptop.

```sh

sudo udevadm trigger --subsystem-match=backlight --action=add

sudo tee /etc/udev/rules.d/90-backlight.rules >/dev/null <<'EOF'
ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="nvidia_wmi_ec_backlight", RUN+="/usr/bin/chgrp video /sys/class/backlight/%k/brightness", RUN+="/usr/bin/chmod g+w /sys/class/backlight/%k/brightness"
EOF
```

- `ACTION=="add"` significa “cuando se añade o inicializa el dispositivo”.
- `SUBSYSTEM=="backlight"` limita la regla a dispositivos de retroiluminación.
- `KERNEL=="nvidia_wmi_ec_backlight"` la limita a ese dispositivo concreto.
- `%k` se sustituye por el nombre del dispositivo; aquí, `nvidia_wmi_ec_backlight`.
- `RUN+=` le pide a `udev` que ejecute el comando indicado.

---

Sí, esa es la idea, con una distinción importante: la regla guarda los permisos, no el nivel de brillo.

`/sys` es un sistema de archivos virtual: parece tener archivos y directorios, pero no son archivos guardados en el disco. El kernel crea esas entradas para exponer información y controles de los dispositivos. En este caso, leer `brightness` consulta el estado que conoce el controlador; escribir un número le pide al controlador que cambie el brillo. No es exactamente “un archivo en la RAM”: es una interfaz hacia objetos y funciones del kernel, presentada con aspecto de archivos. [linux-kernel-labs.github.io](https://linux-kernel-labs.github.io/refs/pull/189/merge/labs/device_model.html)

Cuando reinicias, se detiene el kernel y se inicia uno nuevo. El nuevo kernel vuelve a crear las entradas de `/sys` y aplica de nuevo los permisos iniciales definidos por el controlador; por eso los cambios manuales de propietario o permisos no son una configuración permanente guardada en el disco.

La regla de `udev`, en cambio, sí queda guardada en el disco. Al arrancar, cuando el kernel anuncia que el dispositivo está disponible, `udev` procesa el evento y ejecuta las acciones de la regla. Por eso no tienes que repetir manualmente `chown` y `chmod` después de cada reinicio. `udev` gestiona precisamente esos eventos de dispositivos y sus reglas pueden ejecutar acciones cuando uno aparece. [kernel.org](https://mirrors.edge.kernel.org/pub/linux/utils/kernel/hotplug/udev/udev.html)

Así que hay dos cosas distintas:

- Permisos: la regla de `udev` los vuelve a configurar al aparecer el dispositivo.
- Brillo elegido: esa regla no lo guarda. Si quieres restaurar siempre un nivel concreto de brillo, necesitas otro mecanismo que escriba ese valor al iniciar sesión o al arrancar.

# Arch Minimal — Notas de desarrollo y consideraciones para la V1

## 1. Filosofía del proyecto

El objetivo es crear un entorno minimalista para Arch Linux, basado en Xorg y bspwm, que sea reproducible, modular, comprensible y fácil de mantener.

Principios:

- Entender cada componente antes de integrarlo.
- Evitar dependencias innecesarias.
- Preferir herramientas sencillas cuando sean suficientes.
- Automatizar las tareas repetitivas sin ocultar lo que hacen.
- No modificar el sistema silenciosamente.
- Priorizar la estabilidad y la seguridad sobre las características visuales.
- Documentar las decisiones técnicas y sus limitaciones.
- Permitir que otras personas prueben el entorno y reporten errores.

## 2. Alcance de la V1

La primera versión debe centrarse en que el entorno funcione correctamente y pueda instalarse de forma reproducible.

Objetivos:

- [ ] Configurar bspwm y sxhkd.
- [ ] Configurar Xorg y las herramientas gráficas necesarias.
- [ ] Instalar únicamente los paquetes requeridos.
- [ ] Organizar las configuraciones en directorios claros.
- [ ] Instalar o enlazar los archivos de configuración.
- [ ] Configurar scripts personales.
- [ ] Verificar permisos y dependencias.
- [ ] Crear documentación de instalación.
- [ ] Probar el entorno en máquinas virtuales.
- [ ] Probar el entorno en hardware físico.
- [ ] Publicar la V1 en GitHub.

No es necesario desarrollar todas las herramientas propias antes de publicar la primera versión.

## 3. Organización de los dotfiles

Separar las configuraciones, los scripts, las dependencias y las herramientas propias.

Una estructura posible:

```
arch-minimal/
├── README.md
├── LICENSE
├── Makefile
├── install.sh
├── packages/
│   ├── base.txt
│   ├── xorg.txt
│   └── optional.txt
├── config/
│   ├── bspwm/
│   ├── sxhkd/
│   ├── picom/
│   └── ...
├── scripts/
├── system/
│   └── udev/
├── tools/
└── docs/
```

La estructura puede evolucionar conforme crezca el proyecto.

## 4. Automatización del instalador

El instalador debe ser predecible, verificable y seguro.

Consideraciones:

- Comprobar que el sistema sea Arch Linux o una plataforma explícitamente compatible.
- Comprobar que se está ejecutando como usuario normal cuando corresponda.
- Verificar las dependencias antes de utilizarlas.
- Separar la instalación de paquetes de la configuración del usuario.
- No sobrescribir configuraciones existentes sin avisar.
- Crear copias de seguridad antes de reemplazar archivos.
- Comprobar los códigos de salida de los comandos importantes.
- Evitar instalaciones con `--noconfirm` cuando sea necesario revisar cambios.
- No modificar repositorios o servicios globales sin informar al usuario.
- Hacer que las operaciones sean idempotentes: ejecutarlas varias veces no debe duplicar configuraciones ni provocar daños.
- Registrar los errores de instalación y explicar cómo solucionarlos.
- No ejecutar todo el instalador como root.

## 5. Gestión de paquetes

Arch Linux utiliza Pacman como gestor de paquetes oficial.

Buenas prácticas:

- Mantener separadas las dependencias obligatorias y las opcionales.
- Preferir los repositorios oficiales cuando proporcionen lo necesario.
- Documentar los paquetes que provienen de AUR o de repositorios de terceros.
- Revisar los archivos PKGBUILD antes de construir paquetes de AUR.
- No asumir que todos los paquetes seguirán disponibles con el mismo nombre.
- Evitar actualizaciones parciales del sistema.
- Probar el instalador con una instalación limpia de Arch Linux.

No añadir repositorios externos si no son realmente necesarios.

## 6. Scripts personales y PATH

Los scripts propios pueden mantenerse en un directorio como:

```
~/.config/bspwm/bin/
```

También puede utilizarse `~/.local/bin/` para herramientas personales que deban estar disponibles independientemente del gestor de ventanas.

Ejemplo:

```
export PATH="$HOME/.config/bspwm/bin:$PATH"
```

Consideraciones:

- Añadir el directorio al `PATH` en el lugar adecuado.
- Recordar que los procesos deben heredar ese entorno.
- Dar permisos de ejecución a los scripts que deban ejecutarse directamente.
- Utilizar rutas absolutas cuando sean necesarias para tareas automatizadas.
- Documentar las dependencias externas de cada script.
- Preferir POSIX `sh` cuando Bash no sea necesario.

## 7. Control del brillo mediante /sys

Linux expone los dispositivos de retroiluminación mediante:

```
/sys/class/backlight/
```

No se debe asumir que todos los equipos utilizan el mismo nombre de dispositivo.

Por ejemplo:

```
/sys/class/backlight/nvidia_wmi_ec_backlight/
/sys/class/backlight/intel_backlight/
```

Los nombres disponibles dependen del hardware y de los controladores.

Consideraciones:

- Detectar los dispositivos disponibles.
- Comprobar que existen `brightness` y `max_brightness`.
- Validar las operaciones solicitadas.
- Evitar valores inferiores a cero o superiores al máximo.
- Evitar incrementos de cero en dispositivos con un máximo inferior a diez.
- Informar si no existe ningún dispositivo compatible.
- No asumir que pertenecer al grupo `video` concede automáticamente acceso de escritura.

### Permisos mediante udev

Es posible definir permisos persistentes mediante reglas de udev.

Ejemplo específico para el dispositivo NVIDIA WMI:

```
ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="nvidia_wmi_ec_backlight", GROUP="video", MODE="0660"
```

Este ejemplo requiere verificar que el dispositivo y las reglas coincidan con el hardware real.

Antes de distribuirlo:

- Comprobar el dispositivo existente.
- Verificar que el grupo sea apropiado.
- Comprobar los permisos efectivos después de aplicar la regla.
- Revisar posibles reglas que entren en conflicto.
- Documentar que la regla solo cubre el dispositivo indicado.
- No añadir usuarios a grupos privilegiados sin explicar las implicaciones.
- Probar el comportamiento después de reiniciar.

Los permisos y el nivel de brillo son cosas distintas. La regla de udev no guarda el nivel de brillo seleccionado.

## 8. Resolución y frecuencia de refresco

`xrandr` permite consultar y modificar las salidas gráficas en Xorg.

Comandos útiles:

```
xrandr
xrandr --current
```

Consideraciones:

- No asumir que todos los equipos tienen una salida llamada `eDP-1`.
- Detectar las salidas disponibles cuando sea necesario.
- No fijar una resolución que el monitor no admita.
- No asumir que todos los equipos soportan 165 Hz.
- Considerar monitores externos y múltiples pantallas.
- Recordar que el comportamiento de `xrandr` en Wayland es limitado o depende de la capa de compatibilidad.

El proyecto puede declarar Xorg como requisito si no pretende admitir Wayland en la V1.

## 9. Herramientas propias

Las herramientas propias deben añadirse después de estabilizar la base del entorno.

Para cada herramienta:

- Definir claramente su propósito.
- Separar la lógica del sistema de la presentación.
- Documentar las dependencias.
- Gestionar errores de forma explícita.
- Evitar privilegios de administrador innecesarios.
- Proporcionar una ayuda mediante `--help` cuando corresponda.
- Probar casos de error, no solamente el funcionamiento normal.

### Implementación propia de i3lock-fancy

La herramienta de referencia utiliza una captura de pantalla, procesamiento de imagen y un bloqueador de pantalla.

La nueva implementación debe decidir explícitamente qué tareas realizará y cuáles delegará a otras herramientas.

Aspectos que revisar:

- Captura de pantalla en Xorg.
- Desenfoque o pixelado.
- Composición de iconos y texto.
- Dependencias externas.
- Gestión de archivos temporales.
- Compatibilidad con varios monitores.
- Manejo de errores.
- Integración con bspwm y sxhkd.

La autenticación y el bloqueo efectivo deben permanecer en manos de un bloqueador fiable. Si falla el procesamiento de imagen, no se debe dejar la sesión desbloqueada.

## 10. Pruebas y compatibilidad

El entorno debe probarse en diferentes condiciones.

### Máquinas virtuales

- [ ] Instalación limpia de Arch Linux.
- [ ] Primera ejecución del instalador.
- [ ] Segunda ejecución del instalador.
- [ ] Dependencias ausentes.
- [ ] Errores de descarga.
- [ ] Configuraciones existentes.
- [ ] Inicio de Xorg y bspwm.
- [ ] Servicios de usuario.
- [ ] Resolución y escalado.
- [ ] Comportamiento sin aceleración gráfica adecuada.

### Hardware físico

- [ ] Portátil principal.
- [ ] Toshiba Satellite L45.
- [ ] Dispositivos de retroiluminación diferentes.
- [ ] Teclas de brillo.
- [ ] Monitor externo, si está disponible.
- [ ] Suspensión y reanudación.
- [ ] Consumo de recursos.
- [ ] Comportamiento de la batería cuando corresponda.

No se puede garantizar compatibilidad universal. Los problemas encontrados deben documentarse y corregirse progresivamente.

## 11. GitHub y colaboración

Antes de publicar:

- [ ] Añadir un README claro.
- [ ] Elegir una licencia.
- [ ] Documentar los requisitos.
- [ ] Añadir instrucciones de instalación.
- [ ] Explicar los cambios que realiza el instalador.
- [ ] Añadir un `.gitignore`.
- [ ] No incluir contraseñas, claves privadas, tokens ni información personal.
- [ ] Documentar los problemas conocidos.
- [ ] Proporcionar instrucciones para reportar errores.

Para recibir contribuciones, las incidencias deberían incluir:

- Hardware o máquina virtual.
- Versión de Arch Linux y kernel.
- Entorno gráfico utilizado.
- Pasos para reproducir el problema.
- Mensajes de error relevantes.
- Resultado esperado y resultado obtenido.

## 12. Plan de desarrollo

### V1 — Entorno funcional

Estabilizar las configuraciones, automatizar la instalación y documentar los requisitos.

### V1.1 — Correcciones

Solucionar errores encontrados durante las pruebas y mejorar la compatibilidad.

### V2 — Herramientas propias

Integrar progresivamente las implementaciones propias y documentar sus dependencias.

### Futuro

Valorar perfiles adicionales, pruebas automatizadas, más hardware y nuevas herramientas únicamente cuando aporten valor real.

## Principio final

El objetivo no es crear el entorno más grande ni el más sofisticado.

El objetivo es crear un entorno minimalista que funcione, que pueda reproducirse, que se entienda y que otras personas puedan probar sin asumir riesgos innecesarios.

Cada problema encontrado durante las pruebas es una oportunidad para mejorar el proyecto y aprender algo nuevo.

### La diferencia técnica: "El Jefe" vs "El Mensajero"

1. `xdo` (El Mensajero externo): `xdo` no habla con bspwm. `xdo` habla directamente con el Servidor X (X11). Es como si tú ignoraras al administrador del edificio (bspwm) y fueras directamente a mover los muebles de la habitación. `xdo` le dice al sistema: _"No me importa quién gestione esta ventana, ponla en estas coordenadas AHORA"_.

- Por qué "funciona" siempre: Porque fuerza el movimiento a nivel de sistema, saltándose las reglas de bspwm.
- El problema: Es más lento (lanza un proceso externo) y, a veces, bspwm puede intentar "corregir" la posición después porque el administrador (bspwm) no sabe que el mueble se movió.

2. `bspc -g rectangle` (El Jefe/Administrador): `bspc` es el comando nativo. No le pide permiso al sistema, le da una orden al Gestor de Ventanas (bspwm). Tú le dices a bspwm: _"Actualiza tu registro interno y pon esta ventana aquí"_.

- Por qué a veces falla (`Invalid value`): Porque bspwm es el administrador y tiene reglas. Si la ventana está oculta (`hidden`), bspwm dice: _"No puedo poner un rectángulo a algo que no existe físicamente en el monitor ahora mismo"_.
- La ventaja: Es instantáneo y es la forma "limpia" de hacerlo. Una vez que bspwm acepta el rectángulo, la ventana se queda ahí porque el propio administrador es quien lo decidió.

### ¿Por qué con `xdo` sientes que "vuelve a su lugar"?

Lo que sucede es que `xdo` es un comando de fuerza bruta.

Cuando ejecutas el script y usas `xdo`, el comando se envía al Servidor X. Si la ventana acaba de aparecer o estaba oculta, `xdo` la "empuja" a la posición correcta sin importar el estado interno de bspwm.

Con `bspc`, si el comando falla (por el error de `Invalid value` que tuvimos), bspwm simplemente ignora la orden. Por eso sientes que "no pasa nada" o que no se mueve: no es que no funcione, es que bspwm rechazó la orden porque la ventana aún estaba oculta o no tenía el foco.

### Mi recomendación final

Si quieres que el script sea profesional, rápido y no dé errores: Sigue usando `bspc`, pero respeta el orden de los factores:

1. `hidden=off (Sacas la ventana al mundo físico).
2. `bspc node -g rectangle=...` (Le dices al administrador dónde ponerla).

Si usas `xdo`, el script funcionará, pero estarás usando una herramienta pesada para hacer algo que el gestor de ventanas puede hacer en microsegundos. Además, usar herramientas externas para gestionar ventanas en un Tiling WM suele traer problemas de "parpadeo" (la ventana aparece en un sitio y un milisegundo después salta al otro).

En resumen: `xdo` es un "hack" que fuerza la posición. `bspc` es la forma correcta que coordina la posición con el gestor de ventanas. Solo necesitas asegurarte de que la ventana sea visible antes de darle el tamaño.
