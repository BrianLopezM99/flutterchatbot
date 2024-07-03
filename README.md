# Chatbot App

Este es un proyecto de aplicación de chatbot desarrollado en Flutter. La aplicación simula conversaciones utilizando un array de strings para generar respuestas de manera aleatoria. El proyecto utiliza el patrón BLoC para la gestión de estado y sigue una estructura de carpetas limpia y organizada.

## Características

- **Chatbot**: La aplicación simula un chatbot con respuestas aleatorias.
- **Gestión de Estado con BLoC**: Utiliza el patrón BLoC para manejar el estado de la aplicación.
- **Estructura de Carpetas Limpia**: El proyecto está organizado en carpetas claras y específicas siguiendo clean arquitecture.

## Estructura del Proyecto

- **chat/bloc**: Contiene los archivos relacionados con BLoC (`chat_bloc.dart`, `chat_event.dart`, `chat_state.dart`) y mocks (`bot_messages.dart`).
- **chat**: Contiene la pantalla principal del chat (`chat_home.dart`) y el modelo de mensaje (`chat_message.dart`).
- **chat/widgets**: Contiene los widgets específicos del chat (`chat_container_widget.dart`, `chat_widget.dart`) y el widget de notificaciones (`notification_widget.dart`).
- **dashboard**: Contiene el widget del panel principal (`dashboard_widget.dart`).

## Instalación

Para instalar y ejecutar este proyecto localmente, sigue los siguientes pasos:

1. **Clona el repositorio**:
   ```bash
   git clone https://github.com/tu_usuario/chatbot_app.git
   cd chatbot_app
Instala las dependencias:

flutter pub get
Ejecuta la aplicación:


flutter run
Uso
Una vez que la aplicación esté en funcionamiento, podrás iniciar una conversación con el chatbot. El chatbot responderá con mensajes aleatorios seleccionados de un array de strings definido en el proyecto.
