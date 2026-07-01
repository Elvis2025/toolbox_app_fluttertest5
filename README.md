# Toolbox App Flutter

Aplicación Flutter con MVVM que incluye:

- Caja de herramientas en pantalla principal.
- Predicción de género con Genderize.
- Predicción de edad con Agify.
- Universidades por país con Adamix Proxy.
- Clima actual en RD con Open-Meteo.
- Pokémon con imagen, experiencia, habilidades y sonido latest.
- Noticias WordPress con últimas 3 publicaciones.
- Acerca de con foto y datos de contacto.

## Antes de ejecutar

1. Coloca tu foto en:

```txt
assets/images/my_photo.png
```

2. Cambia tus datos en:

```txt
lib/features/about/presentation/pages/about_page.dart
```

3. Instala dependencias:

```bash
flutter pub get
```

4. Genera el icono con tu foto:

```bash
dart run flutter_launcher_icons
```

5. Ejecuta:

```bash
flutter run
```

6. Genera APK:

```bash
flutter build apk --release
```

APK generado:

```txt
build/app/outputs/flutter-apk/app-release.apk
```

## API WordPress para publicar en el foro

```txt
https://techcrunch.com/wp-json/wp/v2/posts?per_page=3
```
