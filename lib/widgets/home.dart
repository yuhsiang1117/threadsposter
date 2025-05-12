class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
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
                      Container(
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
                                  Container(
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
                                                    fontWeight: FontWeight.w590,
                                                    height: 1.29,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(width: 124, height: 10),
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
                      Container(
                        width: 402,
                        height: 817,
                        child: Stack(
                          children: [
                            Positioned(
                              left: 0,
                              top: 733,
                              child: Container(
                                width: 402,
                                height: 84,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 0,
                                      top: 0,
                                      child: Container(
                                        width: 402,
                                        height: 84,
                                        clipBehavior: Clip.antiAlias,
                                        decoration: ShapeDecoration(
                                          shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                              width: 0.33,
                                              strokeAlign: BorderSide.strokeAlignOutside,
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
                                                height: 84,
                                                decoration: BoxDecoration(
                                                  color: Colors.white.withValues(alpha: 191),
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
                                      child: Container(
                                        width: 402,
                                        height: 84,
                                        child: Stack(
                                          children: [
                                            Positioned(
                                              left: 22,
                                              top: 20,
                                              child: Container(
                                                width: 80.40,
                                                height: 40,
                                                child: Stack(
                                                  children: [
                                                    Positioned(
                                                      left: 0,
                                                      top: 32,
                                                      child: SizedBox(
                                                        width: 80,
                                                        height: 8,
                                                        child: Text(
                                                          'Home',
                                                          textAlign: TextAlign.center,
                                                          style: TextStyle(
                                                            color: const Color(0xFF007AFF),
                                                            fontSize: 10,
                                                            fontFamily: 'Inter',
                                                            fontWeight: FontWeight.w400,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Positioned(
                                                      left: 25,
                                                      top: 0,
                                                      child: Container(
                                                        width: 30,
                                                        height: 30,
                                                        clipBehavior: Clip.antiAlias,
                                                        decoration: BoxDecoration(),
                                                        child: Stack(),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              left: 304,
                                              top: 20,
                                              child: Container(
                                                width: 80.40,
                                                height: 40,
                                                child: Stack(
                                                  children: [
                                                    Positioned(
                                                      left: 25.20,
                                                      top: -2,
                                                      child: Container(
                                                        width: 30,
                                                        height: 30,
                                                        clipBehavior: Clip.antiAlias,
                                                        decoration: BoxDecoration(),
                                                        child: Stack(),
                                                      ),
                                                    ),
                                                    Positioned(
                                                      left: 0.20,
                                                      top: 30,
                                                      child: SizedBox(
                                                        width: 80,
                                                        height: 8,
                                                        child: Text(
                                                          'Setting',
                                                          textAlign: TextAlign.center,
                                                          style: TextStyle(
                                                            color: const Color(0xFF999999),
                                                            fontSize: 10,
                                                            fontFamily: 'Inter',
                                                            fontWeight: FontWeight.w400,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              left: 163,
                                              top: 20,
                                              child: Container(
                                                width: 80.40,
                                                height: 40,
                                                child: Stack(
                                                  children: [
                                                    Positioned(
                                                      left: 0,
                                                      top: 30,
                                                      child: SizedBox(
                                                        width: 80,
                                                        height: 8,
                                                        child: Text(
                                                          'Post',
                                                          textAlign: TextAlign.center,
                                                          style: TextStyle(
                                                            color: const Color(0xFF999999),
                                                            fontSize: 10,
                                                            fontFamily: 'Inter',
                                                            fontWeight: FontWeight.w400,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Positioned(
                                                      left: 25,
                                                      top: 0,
                                                      child: Container(
                                                        width: 30,
                                                        height: 30,
                                                        clipBehavior: Clip.antiAlias,
                                                        decoration: BoxDecoration(),
                                                        child: Stack(),
                                                      ),
                                                    ),
                                                  ],
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
                            ),
                            Positioned(
                              left: 0,
                              top: 0,
                              child: Container(
                                width: 402,
                                height: 733,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFEF7FF) /* Schemes-Surface-Bright */,
                                ),
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 24,
                                      top: 31,
                                      child: Text(
                                        '本日熱門',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 32,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 0,
                                      top: 77,
                                      child: Container(
                                        width: 402,
                                        height: 648,
                                        clipBehavior: Clip.antiAlias,
                                        decoration: BoxDecoration(),
                                        child: Stack(
                                          children: [
                                            Positioned(
                                              left: 21,
                                              top: 20,
                                              child: Container(
                                                width: 361,
                                                height: 837,
                                                child: Stack(
                                                  children: [
                                                    Positioned(
                                                      left: 5.50,
                                                      top: 651,
                                                      child: Opacity(
                                                        opacity: 0.24,
                                                        child: Container(
                                                          width: 344,
                                                          height: 186,
                                                          decoration: ShapeDecoration(
                                                            image: DecorationImage(
                                                              image: NetworkImage("https://placehold.co/344x186"),
                                                              fit: BoxFit.cover,
                                                            ),
                                                            shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(22),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Positioned(
                                                      left: 0,
                                                      top: 696,
                                                      child: SizedBox(
                                                        width: 355,
                                                        child: Text(
                                                          '#家寧',
                                                          textAlign: TextAlign.center,
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 32,
                                                            fontFamily: 'Inter',
                                                            fontWeight: FontWeight.w900,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Positioned(
                                                      left: 120,
                                                      top: 751,
                                                      child: Container(
                                                        width: 116,
                                                        height: 49,
                                                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                                        decoration: ShapeDecoration(
                                                          color: const Color(0xFF007AFF) /* Colors-Blue */,
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(40),
                                                          ),
                                                        ),
                                                        child: Row(
                                                          mainAxisSize: MainAxisSize.min,
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          spacing: 3,
                                                          children: [
                                                          ,
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Positioned(
                                                      left: 148,
                                                      top: 766,
                                                      child: Text(
                                                        '立即發文',
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 15,
                                                          fontFamily: 'Inter',
                                                          fontWeight: FontWeight.w900,
                                                          height: 1.33,
                                                          letterSpacing: -0.23,
                                                        ),
                                                      ),
                                                    ),
                                                    Positioned(
                                                      left: 5.50,
                                                      top: 434,
                                                      child: Opacity(
                                                        opacity: 0.24,
                                                        child: Container(
                                                          width: 344,
                                                          height: 186,
                                                          decoration: ShapeDecoration(
                                                            image: DecorationImage(
                                                              image: NetworkImage("https://placehold.co/344x186"),
                                                              fit: BoxFit.cover,
                                                            ),
                                                            shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(22),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Positioned(
                                                      left: 0,
                                                      top: 479,
                                                      child: SizedBox(
                                                        width: 355,
                                                        child: Text(
                                                          '#清大',
                                                          textAlign: TextAlign.center,
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 32,
                                                            fontFamily: 'Inter',
                                                            fontWeight: FontWeight.w900,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Positioned(
                                                      left: 120,
                                                      top: 534,
                                                      child: Container(
                                                        width: 116,
                                                        height: 49,
                                                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                                        decoration: ShapeDecoration(
                                                          color: const Color(0xFF007AFF) /* Colors-Blue */,
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(40),
                                                          ),
                                                        ),
                                                        child: Row(
                                                          mainAxisSize: MainAxisSize.min,
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          spacing: 3,
                                                          children: [
                                                          ,
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Positioned(
                                                      left: 148,
                                                      top: 549,
                                                      child: Text(
                                                        '立即發文',
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 15,
                                                          fontFamily: 'Inter',
                                                          fontWeight: FontWeight.w900,
                                                          height: 1.33,
                                                          letterSpacing: -0.23,
                                                        ),
                                                      ),
                                                    ),
                                                    Positioned(
                                                      left: 11.50,
                                                      top: 217,
                                                      child: Opacity(
                                                        opacity: 0.24,
                                                        child: Container(
                                                          width: 344,
                                                          height: 186,
                                                          decoration: ShapeDecoration(
                                                            image: DecorationImage(
                                                              image: NetworkImage("https://placehold.co/344x186"),
                                                              fit: BoxFit.cover,
                                                            ),
                                                            shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(22),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Positioned(
                                                      left: 6,
                                                      top: 262,
                                                      child: SizedBox(
                                                        width: 355,
                                                        child: Text(
                                                          '#台股',
                                                          textAlign: TextAlign.center,
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 32,
                                                            fontFamily: 'Inter',
                                                            fontWeight: FontWeight.w900,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Positioned(
                                                      left: 126,
                                                      top: 317,
                                                      child: Container(
                                                        width: 116,
                                                        height: 49,
                                                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                                        decoration: ShapeDecoration(
                                                          color: const Color(0xFF007AFF) /* Colors-Blue */,
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(40),
                                                          ),
                                                        ),
                                                        child: Row(
                                                          mainAxisSize: MainAxisSize.min,
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          spacing: 3,
                                                          children: [
                                                          ,
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Positioned(
                                                      left: 154,
                                                      top: 332,
                                                      child: Text(
                                                        '立即發文',
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 15,
                                                          fontFamily: 'Inter',
                                                          fontWeight: FontWeight.w900,
                                                          height: 1.33,
                                                          letterSpacing: -0.23,
                                                        ),
                                                      ),
                                                    ),
                                                    Positioned(
                                                      left: 11,
                                                      top: 0,
                                                      child: Opacity(
                                                        opacity: 0.24,
                                                        child: Container(
                                                          width: 344,
                                                          height: 186,
                                                          decoration: ShapeDecoration(
                                                            image: DecorationImage(
                                                              image: NetworkImage("https://placehold.co/344x186"),
                                                              fit: BoxFit.cover,
                                                            ),
                                                            shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(22),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Positioned(
                                                      left: 5.50,
                                                      top: 45,
                                                      child: SizedBox(
                                                        width: 355,
                                                        child: Text(
                                                          '#地震',
                                                          textAlign: TextAlign.center,
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 32,
                                                            fontFamily: 'Inter',
                                                            fontWeight: FontWeight.w900,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Positioned(
                                                      left: 125.50,
                                                      top: 100,
                                                      child: Container(
                                                        width: 116,
                                                        height: 49,
                                                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                                        decoration: ShapeDecoration(
                                                          color: const Color(0xFF007AFF) /* Colors-Blue */,
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(40),
                                                          ),
                                                        ),
                                                        child: Row(
                                                          mainAxisSize: MainAxisSize.min,
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          spacing: 3,
                                                          children: [
                                                          ,
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Positioned(
                                                      left: 153.50,
                                                      top: 115,
                                                      child: Text(
                                                        '立即發文',
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 15,
                                                          fontFamily: 'Inter',
                                                          fontWeight: FontWeight.w900,
                                                          height: 1.33,
                                                          letterSpacing: -0.23,
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
                child: Container(
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
                child: Container(
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