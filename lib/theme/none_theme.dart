import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff765085),
      surfaceTint: Color(0xff765085),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xfff8d8ff),
      onPrimaryContainer: Color(0xff5d386b),
      secondary: Color(0xff69596d),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xfff1dcf4),
      onSecondaryContainer: Color(0xff504255),
      tertiary: Color(0xff815250),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffffdad8),
      onTertiaryContainer: Color(0xff663b3a),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff93000a),
      surface: Color(0xfffff7fb),
      onSurface: Color(0xff1f1a1f),
      onSurfaceVariant: Color(0xff4c444d),
      outline: Color(0xff7d747d),
      outlineVariant: Color(0xffcec3cd),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff342f34),
      inversePrimary: Color(0xffe4b7f3),
      primaryFixed: Color(0xfff8d8ff),
      onPrimaryFixed: Color(0xff2d0b3d),
      primaryFixedDim: Color(0xffe4b7f3),
      onPrimaryFixedVariant: Color(0xff5d386b),
      secondaryFixed: Color(0xfff1dcf4),
      onSecondaryFixed: Color(0xff231728),
      secondaryFixedDim: Color(0xffd4c0d7),
      onSecondaryFixedVariant: Color(0xff504255),
      tertiaryFixed: Color(0xffffdad8),
      onTertiaryFixed: Color(0xff331111),
      tertiaryFixedDim: Color(0xfff5b7b5),
      onTertiaryFixedVariant: Color(0xff663b3a),
      surfaceDim: Color(0xffe1d7df),
      surfaceBright: Color(0xfffff7fb),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfffbf1f8),
      surfaceContainer: Color(0xfff5ebf3),
      surfaceContainerHigh: Color(0xffefe5ed),
      surfaceContainerHighest: Color(0xffe9e0e7),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff4b2859),
      surfaceTint: Color(0xff765085),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff865e94),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff3f3143),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff78687c),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff532b2a),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff92605e),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff740006),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffcf2c27),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffff7fb),
      onSurface: Color(0xff141015),
      onSurfaceVariant: Color(0xff3b343c),
      outline: Color(0xff585059),
      outlineVariant: Color(0xff736a73),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff342f34),
      inversePrimary: Color(0xffe4b7f3),
      primaryFixed: Color(0xff865e94),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff6c467a),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff78687c),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff5f5063),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff92605e),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff764847),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffcdc4cb),
      surfaceBright: Color(0xfffff7fb),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfffbf1f8),
      surfaceContainer: Color(0xffefe5ed),
      surfaceContainerHigh: Color(0xffe4dae1),
      surfaceContainerHighest: Color(0xffd8cfd6),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff401d4e),
      surfaceTint: Color(0xff765085),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff5f3b6e),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff352739),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff534457),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff472120),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff693d3c),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff600004),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff98000a),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffff7fb),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff000000),
      outline: Color(0xff302a32),
      outlineVariant: Color(0xff4e474f),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff342f34),
      inversePrimary: Color(0xffe4b7f3),
      primaryFixed: Color(0xff5f3b6e),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff472456),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff534457),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff3b2e40),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff693d3c),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff4f2726),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffbfb6bd),
      surfaceBright: Color(0xfffff7fb),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff8eef5),
      surfaceContainer: Color(0xffe9e0e7),
      surfaceContainerHigh: Color(0xffdbd2d9),
      surfaceContainerHighest: Color(0xffcdc4cb),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffe4b7f3),
      surfaceTint: Color(0xffe4b7f3),
      onPrimary: Color(0xff442253),
      primaryContainer: Color(0xff5d386b),
      onPrimaryContainer: Color(0xfff8d8ff),
      secondary: Color(0xffd4c0d7),
      onSecondary: Color(0xff392c3d),
      secondaryContainer: Color(0xff504255),
      onSecondaryContainer: Color(0xfff1dcf4),
      tertiary: Color(0xfff5b7b5),
      onTertiary: Color(0xff4c2524),
      tertiaryContainer: Color(0xff663b3a),
      onTertiaryContainer: Color(0xffffdad8),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff161217),
      onSurface: Color(0xffe9e0e7),
      onSurfaceVariant: Color(0xffcec3cd),
      outline: Color(0xff978e97),
      outlineVariant: Color(0xff4c444d),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe9e0e7),
      inversePrimary: Color(0xff765085),
      primaryFixed: Color(0xfff8d8ff),
      onPrimaryFixed: Color(0xff2d0b3d),
      primaryFixedDim: Color(0xffe4b7f3),
      onPrimaryFixedVariant: Color(0xff5d386b),
      secondaryFixed: Color(0xfff1dcf4),
      onSecondaryFixed: Color(0xff231728),
      secondaryFixedDim: Color(0xffd4c0d7),
      onSecondaryFixedVariant: Color(0xff504255),
      tertiaryFixed: Color(0xffffdad8),
      onTertiaryFixed: Color(0xff331111),
      tertiaryFixedDim: Color(0xfff5b7b5),
      onTertiaryFixedVariant: Color(0xff663b3a),
      surfaceDim: Color(0xff161217),
      surfaceBright: Color(0xff3d373d),
      surfaceContainerLowest: Color(0xff110d12),
      surfaceContainerLow: Color(0xff1f1a1f),
      surfaceContainer: Color(0xff231e23),
      surfaceContainerHigh: Color(0xff2d282e),
      surfaceContainerHighest: Color(0xff383339),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xfff5d0ff),
      surfaceTint: Color(0xffe4b7f3),
      onPrimary: Color(0xff381647),
      primaryContainer: Color(0xffab82ba),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffebd6ed),
      onSecondary: Color(0xff2e2132),
      secondaryContainer: Color(0xff9d8ba0),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffffd2cf),
      onTertiary: Color(0xff3f1b1a),
      tertiaryContainer: Color(0xffba8381),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffd2cc),
      onError: Color(0xff540003),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff161217),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffe5d9e3),
      outline: Color(0xffb9afb9),
      outlineVariant: Color(0xff978d97),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe9e0e7),
      inversePrimary: Color(0xff5e3a6d),
      primaryFixed: Color(0xfff8d8ff),
      onPrimaryFixed: Color(0xff220032),
      primaryFixedDim: Color(0xffe4b7f3),
      onPrimaryFixedVariant: Color(0xff4b2859),
      secondaryFixed: Color(0xfff1dcf4),
      onSecondaryFixed: Color(0xff180d1d),
      secondaryFixedDim: Color(0xffd4c0d7),
      onSecondaryFixedVariant: Color(0xff3f3143),
      tertiaryFixed: Color(0xffffdad8),
      onTertiaryFixed: Color(0xff250707),
      tertiaryFixedDim: Color(0xfff5b7b5),
      onTertiaryFixedVariant: Color(0xff532b2a),
      surfaceDim: Color(0xff161217),
      surfaceBright: Color(0xff484349),
      surfaceContainerLowest: Color(0xff0a060b),
      surfaceContainerLow: Color(0xff211c21),
      surfaceContainer: Color(0xff2b262c),
      surfaceContainerHigh: Color(0xff363137),
      surfaceContainerHighest: Color(0xff413c42),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xfffdeaff),
      surfaceTint: Color(0xffe4b7f3),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xffe0b3ef),
      onPrimaryContainer: Color(0xff190026),
      secondary: Color(0xfffdeaff),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffd0bcd3),
      onSecondaryContainer: Color(0xff120717),
      tertiary: Color(0xffffecea),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xfff1b3b1),
      onTertiaryContainer: Color(0xff1e0304),
      error: Color(0xffffece9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffaea4),
      onErrorContainer: Color(0xff220001),
      surface: Color(0xff161217),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffffffff),
      outline: Color(0xfff9ecf7),
      outlineVariant: Color(0xffcabfc9),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe9e0e7),
      inversePrimary: Color(0xff5e3a6d),
      primaryFixed: Color(0xfff8d8ff),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xffe4b7f3),
      onPrimaryFixedVariant: Color(0xff220032),
      secondaryFixed: Color(0xfff1dcf4),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffd4c0d7),
      onSecondaryFixedVariant: Color(0xff180d1d),
      tertiaryFixed: Color(0xffffdad8),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xfff5b7b5),
      onTertiaryFixedVariant: Color(0xff250707),
      surfaceDim: Color(0xff161217),
      surfaceBright: Color(0xff544e54),
      surfaceContainerLowest: Color(0xff000000),
      surfaceContainerLow: Color(0xff231e23),
      surfaceContainer: Color(0xff342f34),
      surfaceContainerHigh: Color(0xff3f3a3f),
      surfaceContainerHighest: Color(0xff4b454b),
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
