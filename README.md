Banco Perla - prototipo de app mobile

Este proyecto es un prototipo de banca móvil diseñado para ofrecer una experiencia segura, fluida y moderna. Enfocado en construir una base sólida que permita escalar la aplicación sin perder el orden.

Construccion
En lugar de mezclar todo el código, decidimos separar la aplicación en capas de responsabilidad:

Capa Visual: Se encarga únicamente de mostrar los botones, colores y animaciones. No toma decisiones, solo reacciona a lo que sucede.

Parte logica: Cuando el usuario hace algo, se procesa la petición y se le devuelve a la pantalla exactamente lo qué debe mostrar para evitar errores de sincronización

Proveedor de Datos: Una sección dedicada a conectarse con el mundo exterior (APIs o bases de datos), permitiendo que el resto de la app sea independiente de dónde viene la información.

Detalles
Privacidad: Un sistema de visibilidad que oculta datos sensibles (saldos de cuenta y tarjetas) con un solo toque, manteniendo la discreción del usuario.

Entrada de Datos: Se filtra activamente lo que el usuario ingresa en los campos. Si el campo pide números, el sistema ignora cualquier otro carácter, previniendo errores.

Navegación Segura: Al salir de la cuenta, limpiamos por completo la "memoria de recorrido" del teléfono. Así, nadie puede volver a ver la información financiera usando el botón 'atrás' del dispositivo.