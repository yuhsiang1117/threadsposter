import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff5d5f5f),
      surfaceTint: Color(0xff5d5f5f),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffffffff),
      onPrimaryContainer: Color(0xff747676),
      secondary: Color(0xff5e5e5e),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffe4e2e2),
      onSecondaryContainer: Color(0xff646464),
      tertiary: Color(0xff5d5f5f),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffffffff),
      onTertiaryContainer: Color(0xff747676),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff93000a),
      surface: Color(0xfffcf8f8),
      onSurface: Color(0xff1c1b1b),
      onSurfaceVariant: Color(0xff444748),
      outline: Color(0xff747878),
      outlineVariant: Color(0xffc4c7c8),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff313030),
      inversePrimary: Color(0xffc6c6c7),
      primaryFixed: Color(0xffe2e2e2),
      onPrimaryFixed: Color(0xff1a1c1c),
      primaryFixedDim: Color(0xffc6c6c7),
      onPrimaryFixedVariant: Color(0xff454747),
      secondaryFixed: Color(0xffe4e2e2),
      onSecondaryFixed: Color(0xff1b1c1c),
      secondaryFixedDim: Color(0xffc8c6c6),
      onSecondaryFixedVariant: Color(0xff474747),
      tertiaryFixed: Color(0xffe2e2e2),
      onTertiaryFixed: Color(0xff1a1c1c),
      tertiaryFixedDim: Color(0xffc6c6c7),
      onTertiaryFixedVariant: Color(0xff454747),
      surfaceDim: Color(0xffddd9d9),
      surfaceBright: Color(0xfffcf8f8),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff6f3f2),
      surfaceContainer: Color(0xfff1edec),
      surfaceContainerHigh: Color(0xffebe7e7),
      surfaceContainerHighest: Color(0xffe5e2e1),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff343637),
      surfaceTint: Color(0xff5d5f5f),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff6c6d6d),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff363636),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff6d6d6d),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff343637),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff6c6d6d),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff740006),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffcf2c27),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffcf8f8),
      onSurface: Color(0xff111111),
      onSurfaceVariant: Color(0xff333738),
      outline: Color(0xff4f5354),
      outlineVariant: Color(0xff6a6e6e),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff313030),
      inversePrimary: Color(0xffc6c6c7),
      primaryFixed: Color(0xff6c6d6d),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff535555),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff6d6d6d),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff555555),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff6c6d6d),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff535555),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffc9c6c5),
      surfaceBright: Color(0xfffcf8f8),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff6f3f2),
      surfaceContainer: Color(0xffebe7e7),
      surfaceContainerHigh: Color(0xffdfdcdb),
      surfaceContainerHighest: Color(0xffd4d1d0),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff2a2c2d),
      surfaceTint: Color(0xff5d5f5f),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff48494a),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff2c2c2c),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff494949),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff2a2c2d),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff48494a),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff600004),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff98000a),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffcf8f8),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff000000),
      outline: Color(0xff292d2d),
      outlineVariant: Color(0xff464a4a),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff313030),
      inversePrimary: Color(0xffc6c6c7),
      primaryFixed: Color(0xff48494a),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff313333),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff494949),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff323333),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff48494a),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff313333),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffbbb8b7),
      surfaceBright: Color(0xfffcf8f8),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff4f0ef),
      surfaceContainer: Color(0xffe5e2e1),
      surfaceContainerHigh: Color(0xffd7d4d3),
      surfaceContainerHighest: Color(0xffc9c6c5),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffffffff),
      surfaceTint: Color(0xffc6c6c7),
      onPrimary: Color(0xff2f3131),
      primaryContainer: Color(0xffe2e2e2),
      onPrimaryContainer: Color(0xff636565),
      secondary: Color(0xffc8c6c6),
      onSecondary: Color(0xff303030),
      secondaryContainer: Color(0xff494949),
      onSecondaryContainer: Color(0xffb9b8b8),
      tertiary: Color(0xffffffff),
      onTertiary: Color(0xff2f3131),
      tertiaryContainer: Color(0xffe2e2e2),
      onTertiaryContainer: Color(0xff636565),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff141313),
      onSurface: Color(0xffe5e2e1),
      onSurfaceVariant: Color(0xffc4c7c8),
      outline: Color(0xff8e9192),
      outlineVariant: Color(0xff444748),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe5e2e1),
      inversePrimary: Color(0xff5d5f5f),
      primaryFixed: Color(0xffe2e2e2),
      onPrimaryFixed: Color(0xff1a1c1c),
      primaryFixedDim: Color(0xffc6c6c7),
      onPrimaryFixedVariant: Color(0xff454747),
      secondaryFixed: Color(0xffe4e2e2),
      onSecondaryFixed: Color(0xff1b1c1c),
      secondaryFixedDim: Color(0xffc8c6c6),
      onSecondaryFixedVariant: Color(0xff474747),
      tertiaryFixed: Color(0xffe2e2e2),
      onTertiaryFixed: Color(0xff1a1c1c),
      tertiaryFixedDim: Color(0xffc6c6c7),
      onTertiaryFixedVariant: Color(0xff454747),
      surfaceDim: Color(0xff141313),
      surfaceBright: Color(0xff3a3939),
      surfaceContainerLowest: Color(0xff0e0e0e),
      surfaceContainerLow: Color(0xff1c1b1b),
      surfaceContainer: Color(0xff201f1f),
      surfaceContainerHigh: Color(0xff2a2a2a),
      surfaceContainerHighest: Color(0xff353434),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffffffff),
      surfaceTint: Color(0xffc6c6c7),
      onPrimary: Color(0xff2f3131),
      primaryContainer: Color(0xffe2e2e2),
      onPrimaryContainer: Color(0xff464849),
      secondary: Color(0xffdedcdb),
      onSecondary: Color(0xff252626),
      secondaryContainer: Color(0xff919090),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffffffff),
      onTertiary: Color(0xff2f3131),
      tertiaryContainer: Color(0xffe2e2e2),
      onTertiaryContainer: Color(0xff464849),
      error: Color(0xffffd2cc),
      onError: Color(0xff540003),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff141313),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffdadddd),
      outline: Color(0xffafb2b3),
      outlineVariant: Color(0xff8d9191),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe5e2e1),
      inversePrimary: Color(0xff464849),
      primaryFixed: Color(0xffe2e2e2),
      onPrimaryFixed: Color(0xff0f1112),
      primaryFixedDim: Color(0xffc6c6c7),
      onPrimaryFixedVariant: Color(0xff343637),
      secondaryFixed: Color(0xffe4e2e2),
      onSecondaryFixed: Color(0xff111111),
      secondaryFixedDim: Color(0xffc8c6c6),
      onSecondaryFixedVariant: Color(0xff363636),
      tertiaryFixed: Color(0xffe2e2e2),
      onTertiaryFixed: Color(0xff0f1112),
      tertiaryFixedDim: Color(0xffc6c6c7),
      onTertiaryFixedVariant: Color(0xff343637),
      surfaceDim: Color(0xff141313),
      surfaceBright: Color(0xff454444),
      surfaceContainerLowest: Color(0xff070707),
      surfaceContainerLow: Color(0xff1e1d1d),
      surfaceContainer: Color(0xff282828),
      surfaceContainerHigh: Color(0xff333232),
      surfaceContainerHighest: Color(0xff3e3d3d),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffffffff),
      surfaceTint: Color(0xffc6c6c7),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xffe2e2e2),
      onPrimaryContainer: Color(0xff282a2b),
      secondary: Color(0xfff2efef),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffc4c2c2),
      onSecondaryContainer: Color(0xff0b0b0b),
      tertiary: Color(0xffffffff),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffe2e2e2),
      onTertiaryContainer: Color(0xff282a2b),
      error: Color(0xffffece9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffaea4),
      onErrorContainer: Color(0xff220001),
      surface: Color(0xff141313),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffffffff),
      outline: Color(0xffeef0f1),
      outlineVariant: Color(0xffc0c3c4),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe5e2e1),
      inversePrimary: Color(0xff464849),
      primaryFixed: Color(0xffe2e2e2),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xffc6c6c7),
      onPrimaryFixedVariant: Color(0xff0f1112),
      secondaryFixed: Color(0xffe4e2e2),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffc8c6c6),
      onSecondaryFixedVariant: Color(0xff111111),
      tertiaryFixed: Color(0xffe2e2e2),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffc6c6c7),
      onTertiaryFixedVariant: Color(0xff0f1112),
      surfaceDim: Color(0xff141313),
      surfaceBright: Color(0xff51504f),
      surfaceContainerLowest: Color(0xff000000),
      surfaceContainerLow: Color(0xff201f1f),
      surfaceContainer: Color(0xff313030),
      surfaceContainerHigh: Color(0xff3c3b3b),
      surfaceContainerHighest: Color(0xff474646),
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
     scaffoldBackgroundColor: colorScheme.surface,
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
