import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff8f4953),
      surfaceTint: Color(0xff8f4953),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffffd9dc),
      onPrimaryContainer: Color(0xff72333c),
      secondary: Color(0xff8f4952),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffffd9dc),
      onSecondaryContainer: Color(0xff72333c),
      tertiary: Color(0xff8c4a60),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffffd9e2),
      onTertiaryContainer: Color(0xff703349),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff93000a),
      surface: Color(0xfffff8f7),
      onSurface: Color(0xff22191a),
      onSurfaceVariant: Color(0xff524344),
      outline: Color(0xff847374),
      outlineVariant: Color(0xffd7c1c3),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff382e2f),
      inversePrimary: Color(0xffffb2ba),
      primaryFixed: Color(0xffffd9dc),
      onPrimaryFixed: Color(0xff3b0713),
      primaryFixedDim: Color(0xffffb2ba),
      onPrimaryFixedVariant: Color(0xff72333c),
      secondaryFixed: Color(0xffffd9dc),
      onSecondaryFixed: Color(0xff3b0713),
      secondaryFixedDim: Color(0xffffb2ba),
      onSecondaryFixedVariant: Color(0xff72333c),
      tertiaryFixed: Color(0xffffd9e2),
      onTertiaryFixed: Color(0xff3a071d),
      tertiaryFixedDim: Color(0xffffb0c8),
      onTertiaryFixedVariant: Color(0xff703349),
      surfaceDim: Color(0xffe7d6d7),
      surfaceBright: Color(0xfffff8f7),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfffff0f0),
      surfaceContainer: Color(0xfffceaea),
      surfaceContainerHigh: Color(0xfff6e4e5),
      surfaceContainerHighest: Color(0xfff0dedf),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff5d222c),
      surfaceTint: Color(0xff8f4953),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffa05861),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff5d222c),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffa05861),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff5b2238),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff9d586f),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff740006),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffcf2c27),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffff8f7),
      onSurface: Color(0xff170f10),
      onSurfaceVariant: Color(0xff413334),
      outline: Color(0xff5e4f50),
      outlineVariant: Color(0xff7a696a),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff382e2f),
      inversePrimary: Color(0xffffb2ba),
      primaryFixed: Color(0xffa05861),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff834049),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xffa05861),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff834049),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff9d586f),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff804057),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffd3c3c3),
      surfaceBright: Color(0xfffff8f7),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfffff0f0),
      surfaceContainer: Color(0xfff6e4e5),
      surfaceContainerHigh: Color(0xffead9d9),
      surfaceContainerHighest: Color(0xffdfcece),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff511822),
      surfaceTint: Color(0xff8f4953),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff75353e),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff511822),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff75353e),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff4f182e),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff72354b),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff600004),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff98000a),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffff8f7),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff000000),
      outline: Color(0xff36292a),
      outlineVariant: Color(0xff554547),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff382e2f),
      inversePrimary: Color(0xffffb2ba),
      primaryFixed: Color(0xff75353e),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff591f29),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff75353e),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff591f28),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff72354b),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff571f34),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffc5b5b6),
      surfaceBright: Color(0xfffff8f7),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffffeded),
      surfaceContainer: Color(0xfff0dedf),
      surfaceContainerHigh: Color(0xffe1d0d1),
      surfaceContainerHighest: Color(0xffd3c3c3),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffffb2ba),
      surfaceTint: Color(0xffffb2ba),
      onPrimary: Color(0xff561d27),
      primaryContainer: Color(0xff72333c),
      onPrimaryContainer: Color(0xffffd9dc),
      secondary: Color(0xffffb2ba),
      onSecondary: Color(0xff561d26),
      secondaryContainer: Color(0xff72333c),
      onSecondaryContainer: Color(0xffffd9dc),
      tertiary: Color(0xffffb0c8),
      onTertiary: Color(0xff541d32),
      tertiaryContainer: Color(0xff703349),
      onTertiaryContainer: Color(0xffffd9e2),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff1a1112),
      onSurface: Color(0xfff0dedf),
      onSurfaceVariant: Color(0xffd7c1c3),
      outline: Color(0xff9f8c8d),
      outlineVariant: Color(0xff524344),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xfff0dedf),
      inversePrimary: Color(0xff8f4953),
      primaryFixed: Color(0xffffd9dc),
      onPrimaryFixed: Color(0xff3b0713),
      primaryFixedDim: Color(0xffffb2ba),
      onPrimaryFixedVariant: Color(0xff72333c),
      secondaryFixed: Color(0xffffd9dc),
      onSecondaryFixed: Color(0xff3b0713),
      secondaryFixedDim: Color(0xffffb2ba),
      onSecondaryFixedVariant: Color(0xff72333c),
      tertiaryFixed: Color(0xffffd9e2),
      onTertiaryFixed: Color(0xff3a071d),
      tertiaryFixedDim: Color(0xffffb0c8),
      onTertiaryFixedVariant: Color(0xff703349),
      surfaceDim: Color(0xff1a1112),
      surfaceBright: Color(0xff413737),
      surfaceContainerLowest: Color(0xff140c0d),
      surfaceContainerLow: Color(0xff22191a),
      surfaceContainer: Color(0xff271d1e),
      surfaceContainerHigh: Color(0xff312828),
      surfaceContainerHighest: Color(0xff3d3233),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffffd1d5),
      surfaceTint: Color(0xffffb2ba),
      onPrimary: Color(0xff48121c),
      primaryContainer: Color(0xffca7a84),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffffd1d5),
      onSecondary: Color(0xff48121c),
      secondaryContainer: Color(0xffca7a83),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffffd0dd),
      onTertiary: Color(0xff471227),
      tertiaryContainer: Color(0xffc67b93),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffd2cc),
      onError: Color(0xff540003),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff1a1112),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffedd7d8),
      outline: Color(0xffc1adae),
      outlineVariant: Color(0xff9f8c8d),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xfff0dedf),
      inversePrimary: Color(0xff73343d),
      primaryFixed: Color(0xffffd9dc),
      onPrimaryFixed: Color(0xff2c0009),
      primaryFixedDim: Color(0xffffb2ba),
      onPrimaryFixedVariant: Color(0xff5d222c),
      secondaryFixed: Color(0xffffd9dc),
      onSecondaryFixed: Color(0xff2c0009),
      secondaryFixedDim: Color(0xffffb2ba),
      onSecondaryFixedVariant: Color(0xff5d222c),
      tertiaryFixed: Color(0xffffd9e2),
      onTertiaryFixed: Color(0xff2b0013),
      tertiaryFixedDim: Color(0xffffb0c8),
      onTertiaryFixedVariant: Color(0xff5b2238),
      surfaceDim: Color(0xff1a1112),
      surfaceBright: Color(0xff4d4242),
      surfaceContainerLowest: Color(0xff0d0606),
      surfaceContainerLow: Color(0xff241b1c),
      surfaceContainer: Color(0xff2f2526),
      surfaceContainerHigh: Color(0xff3a3031),
      surfaceContainerHighest: Color(0xff463b3c),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffffebec),
      surfaceTint: Color(0xffffb2ba),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xffffacb5),
      onPrimaryContainer: Color(0xff210005),
      secondary: Color(0xffffebec),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffffacb5),
      onSecondaryContainer: Color(0xff210005),
      tertiary: Color(0xffffebef),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xfffeabc5),
      onTertiaryContainer: Color(0xff20000c),
      error: Color(0xffffece9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffaea4),
      onErrorContainer: Color(0xff220001),
      surface: Color(0xff1a1112),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffffffff),
      outline: Color(0xffffebec),
      outlineVariant: Color(0xffd3bebf),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xfff0dedf),
      inversePrimary: Color(0xff73343d),
      primaryFixed: Color(0xffffd9dc),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xffffb2ba),
      onPrimaryFixedVariant: Color(0xff2c0009),
      secondaryFixed: Color(0xffffd9dc),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffffb2ba),
      onSecondaryFixedVariant: Color(0xff2c0009),
      tertiaryFixed: Color(0xffffd9e2),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffffb0c8),
      onTertiaryFixedVariant: Color(0xff2b0013),
      surfaceDim: Color(0xff1a1112),
      surfaceBright: Color(0xff594d4e),
      surfaceContainerLowest: Color(0xff000000),
      surfaceContainerLow: Color(0xff271d1e),
      surfaceContainer: Color(0xff382e2f),
      surfaceContainerHigh: Color(0xff443939),
      surfaceContainerHighest: Color(0xff4f4445),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }


  ThemeData theme(ColorScheme colorScheme) => ThemeData(
     useMaterial3: true,
     brightness: colorScheme.brightness,
     colorScheme: colorScheme,
     textTheme: textTheme.apply(
       bodyColor: colorScheme.onSurface,
       displayColor: colorScheme.onSurface,
     ),
     scaffoldBackgroundColor: colorScheme.background,
     canvasColor: colorScheme.surface,
  );


  List<ExtendedColor> get extendedColors => [
  ];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
