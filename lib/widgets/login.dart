import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 402,
          height: 874,
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                  width: 402,
                  height: 874,
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: Colors.white /* Backgrounds-Primary */,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(44),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 402,
                        child: Stack(
                          children: [
                            Positioned(
                              left: 0,
                              top: 0,
                              child: Container(
                                width: 402,
                                height: 54,
                                clipBehavior: Clip.antiAlias,
                                decoration: ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      width: 0.33,
                                      color: Colors.black.withValues(alpha: 77) /* Miscellaneous-Bar-border */,
                                    ),
                                  ),
                                ),
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 0,
                                      top: 0,
                                      child: Container(
                                        width: 402,
                                        height: 54,
                                        decoration: BoxDecoration(
                                          color: Colors.white.withValues(alpha: 191),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: 402,
                              height: 54,
                              padding: const EdgeInsets.only(top: 21),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: double.infinity,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      spacing: 134,
                                      children: [
                                        Expanded(
                                          child: Container(
                                            padding: const EdgeInsets.only(left: 16, right: 6),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              spacing: 10,
                                              children: [
                                                Text(
                                                  '9:41',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Colors.black /* Labels-Primary */,
                                                    fontSize: 17,
                                                    fontFamily: 'SF Pro',
                                                    fontWeight: FontWeight.w600,
                                                    height: 1.29,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 124, height: 10),
                                        Expanded(
                                          child: Container(
                                            padding: const EdgeInsets.only(left: 6, right: 16),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              spacing: 7,
                                              children: [
                                                Opacity(
                                                  opacity: 0.35,
                                                  child: Container(
                                                    width: 25,
                                                    height: 13,
                                                    decoration: ShapeDecoration(
                                                      shape: RoundedRectangleBorder(
                                                        side: BorderSide(
                                                          width: 1,
                                                          color: Colors.black /* Labels-Primary */,
                                                        ),
                                                        borderRadius: BorderRadius.circular(4.30),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  width: 21,
                                                  height: 9,
                                                  decoration: ShapeDecoration(
                                                    color: Colors.black /* Labels-Primary */,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(2.50),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 402,
                        height: 817,
                        child: Stack(
                          children: [
                            Positioned(
                              left: 0,
                              top: 0,
                              child: Container(
                                width: 402,
                                height: 817,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFEF7FF) /* Schemes-Surface-Bright */,
                                ),
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 64,
                                      top: 80,
                                      child: SizedBox(
                                        width: 274,
                                        child: Text(
                                          'ThreadsPoster',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 40,
                                            fontFamily: 'Pacifico',
                                            fontWeight: FontWeight.w400,
                                            height: 0.55,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 41,
                                      top: 142,
                                      child: ConstrainedBox(
                                        constraints: BoxConstraints(minWidth: 320),
                                        child: Container(
                                          padding: const EdgeInsets.all(24),
                                          decoration: ShapeDecoration(
                                            color: Colors.white /* Background-Default-Default */,
                                            shape: RoundedRectangleBorder(
                                              side: BorderSide(
                                                width: 1,
                                                color: const Color(0xFFD9D9D9) /* Border-Default-Default */,
                                              ),
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                          ),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            spacing: 24,
                                            children: [
                                              SizedBox(
                                                width: double.infinity,
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  spacing: 8,
                                                  children: [
                                                    SizedBox(
                                                      width: 272,
                                                      child: Text(
                                                        'Email',
                                                        style: TextStyle(
                                                          color: const Color(0xFF1E1E1E) /* Text-Default-Default */,
                                                          fontSize: 16,
                                                          fontFamily: 'Inter',
                                                          fontWeight: FontWeight.w400,
                                                          height: 1.40,
                                                        ),
                                                      ),
                                                    ),
                                                    ConstrainedBox(
                                                      constraints: BoxConstraints(minWidth: 240),
                                                      child: Container(
                                                        width: double.infinity,
                                                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                                        clipBehavior: Clip.antiAlias,
                                                        decoration: ShapeDecoration(
                                                          color: Colors.white /* Background-Default-Default */,
                                                          shape: RoundedRectangleBorder(
                                                            side: BorderSide(
                                                              width: 1,
                                                              strokeAlign: BorderSide.strokeAlignCenter,
                                                              color: const Color(0xFFD9D9D9) /* Border-Default-Default */,
                                                            ),
                                                            borderRadius: BorderRadius.circular(8),
                                                          ),
                                                        ),
                                                        child: Row(
                                                          mainAxisSize: MainAxisSize.min,
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: [
                                                            SizedBox(
                                                              width: 240,
                                                              child: Text(
                                                                'email',
                                                                style: TextStyle(
                                                                  color: const Color(0xFFB3B3B3) /* Text-Default-Tertiary */,
                                                                  fontSize: 16,
                                                                  fontFamily: 'Inter',
                                                                  fontWeight: FontWeight.w400,
                                                                  height: 1,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                width: double.infinity,
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  spacing: 8,
                                                  children: [
                                                    SizedBox(
                                                      width: 272,
                                                      child: Text(
                                                        'Password',
                                                        style: TextStyle(
                                                          color: const Color(0xFF1E1E1E) /* Text-Default-Default */,
                                                          fontSize: 16,
                                                          fontFamily: 'Inter',
                                                          fontWeight: FontWeight.w400,
                                                          height: 1.40,
                                                        ),
                                                      ),
                                                    ),
                                                    ConstrainedBox(
                                                      constraints: BoxConstraints(minWidth: 240),
                                                      child: Container(
                                                        width: double.infinity,
                                                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                                        clipBehavior: Clip.antiAlias,
                                                        decoration: ShapeDecoration(
                                                          color: Colors.white /* Background-Default-Default */,
                                                          shape: RoundedRectangleBorder(
                                                            side: BorderSide(
                                                              width: 1,
                                                              strokeAlign: BorderSide.strokeAlignCenter,
                                                              color: const Color(0xFFD9D9D9) /* Border-Default-Default */,
                                                            ),
                                                            borderRadius: BorderRadius.circular(8),
                                                          ),
                                                        ),
                                                        child: Row(
                                                          mainAxisSize: MainAxisSize.min,
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: [
                                                            SizedBox(
                                                              width: 240,
                                                              child: Text(
                                                                'password',
                                                                style: TextStyle(
                                                                  color: const Color(0xFFB3B3B3) /* Text-Default-Tertiary */,
                                                                  fontSize: 16,
                                                                  fontFamily: 'Inter',
                                                                  fontWeight: FontWeight.w400,
                                                                  height: 1,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                width: double.infinity,
                                                child: Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  spacing: 16,
                                                  children: [
                                                    Expanded(
                                                      child: Container(
                                                        padding: const EdgeInsets.all(12),
                                                        clipBehavior: Clip.antiAlias,
                                                        decoration: ShapeDecoration(
                                                          color: const Color(0xFF2C2C2C) /* Background-Brand-Default */,
                                                          shape: RoundedRectangleBorder(
                                                            side: BorderSide(
                                                              width: 1,
                                                              color: const Color(0xFF2C2C2C) /* Border-Brand-Default */,
                                                            ),
                                                            borderRadius: BorderRadius.circular(8),
                                                          ),
                                                        ),
                                                        child: Row(
                                                          mainAxisSize: MainAxisSize.min,
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          spacing: 8,
                                                          children: [
                                                            Text(
                                                              'Sign In',
                                                              style: TextStyle(
                                                                color: const Color(0xFFF5F5F5) /* Text-Brand-On-Brand */,
                                                                fontSize: 16,
                                                                fontFamily: 'Inter',
                                                                fontWeight: FontWeight.w400,
                                                                height: 1,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                width: double.infinity,
                                                child: Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Forgot password?',
                                                      style: TextStyle(
                                                        color: const Color(0xFF1E1E1E) /* Text-Default-Default */,
                                                        fontSize: 16,
                                                        fontFamily: 'Inter',
                                                        fontWeight: FontWeight.w400,
                                                        decoration: TextDecoration.underline,
                                                        height: 1.40,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 186,
                                      top: 517,
                                      child: Text(
                                        'OR',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w900,
                                          height: 1.10,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 59,
                                      top: 637,
                                      child: Container(
                                        width: 45,
                                        height: 45,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage("https://placehold.co/45x45"),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 118,
                                      top: 649,
                                      child: Text(
                                        'continue with instagram',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w600,
                                          height: 1.10,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 59,
                                      top: 564,
                                      child: Container(
                                        width: 45,
                                        height: 45,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage("https://placehold.co/45x45"),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 125,
                                      top: 576,
                                      child: Text(
                                        'continue with google',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w600,
                                          height: 1.10,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 0,
                top: 840,
                child: SizedBox(
                  width: 402,
                  height: 34,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 273,
                        top: 26,
                        child: Container(
                          transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(3.14),
                          width: 144,
                          height: 5,
                          decoration: ShapeDecoration(
                            color: Colors.black /* Labels-Primary */,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 0,
                top: 0,
                child: SizedBox(
                  width: 402,
                  height: 874,
                  child: Stack(
                    children: [
                      Positioned(
                        left: -24,
                        top: -23,
                        child: Container(
                          width: 450,
                          height: 920,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage("https://placehold.co/450x920"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}