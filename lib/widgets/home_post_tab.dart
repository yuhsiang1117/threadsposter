import 'package:flutter/material.dart';

class Post extends StatelessWidget {
  const Post({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 402,
          height: 866,
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
                              top: 733,
                              child: SizedBox(
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
                                      child: SizedBox(
                                        width: 402,
                                        height: 84,
                                        child: Stack(
                                          children: [
                                            Positioned(
                                              left: 22,
                                              top: 20,
                                              child: SizedBox(
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
                                            Positioned(
                                              left: 304,
                                              top: 20,
                                              child: SizedBox(
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
                                              child: SizedBox(
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
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  spacing: 10,
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      height: 733,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(),
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            left: 24,
                                            top: 31,
                                            child: Text(
                                              '發文',
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
                                            left: 24,
                                            top: 70,
                                            child: SizedBox(
                                              width: 358,
                                              height: 664,
                                              child: Stack(
                                                children: [
                                                  Positioned(
                                                    left: 0,
                                                    top: 15,
                                                    child: SizedBox(
                                                      height: 70,
                                                      child: Column(
                                                        mainAxisSize: MainAxisSize.min,
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        spacing: 8,
                                                        children: [
                                                          SizedBox(
                                                            width: 160,
                                                            child: Text(
                                                              '模仿對象',
                                                              style: TextStyle(
                                                                color: const Color(0xFF1E1E1E) /* Text-Default-Default */,
                                                                fontSize: 16,
                                                                fontFamily: 'Inter',
                                                                fontWeight: FontWeight.w400,
                                                                height: 1.40,
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            width: 160,
                                                            height: 40,
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
                                                            child: Stack(
                                                              children: [
                                                                Positioned(
                                                                  left: 16,
                                                                  top: 9,
                                                                  child: SizedBox(
                                                                    width: 208,
                                                                    child: Text(
                                                                      '使用者ID',
                                                                      style: TextStyle(
                                                                        color: const Color(0xFFB3B3B3) /* Text-Default-Tertiary */,
                                                                        fontSize: 16,
                                                                        fontFamily: 'Inter',
                                                                        fontWeight: FontWeight.w400,
                                                                        height: 1.40,
                                                                      ),
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
                                                    top: 268,
                                                    child: SizedBox(
                                                      width: 358,
                                                      height: 70,
                                                      child: Column(
                                                        mainAxisSize: MainAxisSize.min,
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        spacing: 8,
                                                        children: [
                                                          SizedBox(
                                                            width: 358,
                                                            child: Text(
                                                              'Tag',
                                                              style: TextStyle(
                                                                color: const Color(0xFF1E1E1E) /* Text-Default-Default */,
                                                                fontSize: 16,
                                                                fontFamily: 'Inter',
                                                                fontWeight: FontWeight.w400,
                                                                height: 1.40,
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            width: double.infinity,
                                                            height: 40,
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
                                                            child: Stack(
                                                              children: [
                                                                Positioned(
                                                                  left: 16,
                                                                  top: 9,
                                                                  child: SizedBox(
                                                                    width: 208,
                                                                    child: Text(
                                                                      'ex: #清大, #資工',
                                                                      style: TextStyle(
                                                                        color: const Color(0xFFB3B3B3) /* Text-Default-Tertiary */,
                                                                        fontSize: 16,
                                                                        fontFamily: 'Inter',
                                                                        fontWeight: FontWeight.w400,
                                                                        height: 1.40,
                                                                      ),
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
                                                    top: 99,
                                                    child: SizedBox(
                                                      width: 160,
                                                      child: Column(
                                                        mainAxisSize: MainAxisSize.min,
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        spacing: 8,
                                                        children: [
                                                          SizedBox(
                                                            width: 160,
                                                            child: Text(
                                                              '風格',
                                                              style: TextStyle(
                                                                color: const Color(0xFF1E1E1E) /* Text-Default-Default */,
                                                                fontSize: 16,
                                                                fontFamily: 'Inter',
                                                                fontWeight: FontWeight.w400,
                                                                height: 1.40,
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            width: double.infinity,
                                                            height: 40,
                                                            padding: const EdgeInsets.only(
                                                              top: 12,
                                                              left: 16,
                                                              right: 12,
                                                              bottom: 12,
                                                            ),
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
                                                              spacing: 8,
                                                              children: [
                                                                SizedBox(
                                                                  width: 108,
                                                                  child: Text(
                                                                    '幽默',
                                                                    style: TextStyle(
                                                                      color: const Color(0xFF1E1E1E) /* Text-Default-Default */,
                                                                      fontSize: 16,
                                                                      fontFamily: 'Inter',
                                                                      fontWeight: FontWeight.w400,
                                                                      height: 1,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  width: 16,
                                                                  height: 16,
                                                                  clipBehavior: Clip.antiAlias,
                                                                  decoration: BoxDecoration(),
                                                                  child: Stack(),
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
                                                    top: 183,
                                                    child: SizedBox(
                                                      width: 160,
                                                      child: Column(
                                                        mainAxisSize: MainAxisSize.min,
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        spacing: 8,
                                                        children: [
                                                          SizedBox(
                                                            width: 160,
                                                            child: Text(
                                                              '長度',
                                                              style: TextStyle(
                                                                color: const Color(0xFF1E1E1E) /* Text-Default-Default */,
                                                                fontSize: 16,
                                                                fontFamily: 'Inter',
                                                                fontWeight: FontWeight.w400,
                                                                height: 1.40,
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            width: 160,
                                                            height: 40,
                                                            padding: const EdgeInsets.only(
                                                              top: 12,
                                                              left: 16,
                                                              right: 12,
                                                              bottom: 12,
                                                            ),
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
                                                              spacing: 8,
                                                              children: [
                                                                SizedBox(
                                                                  width: 108,
                                                                  child: Text(
                                                                    '50字以內',
                                                                    style: TextStyle(
                                                                      color: const Color(0xFF1E1E1E) /* Text-Default-Default */,
                                                                      fontSize: 16,
                                                                      fontFamily: 'Inter',
                                                                      fontWeight: FontWeight.w400,
                                                                      height: 1,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  width: 16,
                                                                  height: 16,
                                                                  clipBehavior: Clip.antiAlias,
                                                                  decoration: BoxDecoration(),
                                                                  child: Stack(),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    left: 198,
                                                    top: 99,
                                                    child: SizedBox(
                                                      width: 160,
                                                      child: Column(
                                                        mainAxisSize: MainAxisSize.min,
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        spacing: 8,
                                                        children: [
                                                          SizedBox(
                                                            width: 160,
                                                            child: Text(
                                                              '參考貼文',
                                                              style: TextStyle(
                                                                color: const Color(0xFF1E1E1E) /* Text-Default-Default */,
                                                                fontSize: 16,
                                                                fontFamily: 'Inter',
                                                                fontWeight: FontWeight.w400,
                                                                height: 1.40,
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            width: 160,
                                                            height: 40,
                                                            padding: const EdgeInsets.only(
                                                              top: 12,
                                                              left: 16,
                                                              right: 12,
                                                              bottom: 12,
                                                            ),
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
                                                              spacing: 8,
                                                              children: [
                                                                SizedBox(
                                                                  width: 108,
                                                                  child: Text(
                                                                    '100讚以上',
                                                                    style: TextStyle(
                                                                      color: const Color(0xFF1E1E1E) /* Text-Default-Default */,
                                                                      fontSize: 16,
                                                                      fontFamily: 'Inter',
                                                                      fontWeight: FontWeight.w400,
                                                                      height: 1,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  width: 16,
                                                                  height: 16,
                                                                  clipBehavior: Clip.antiAlias,
                                                                  decoration: BoxDecoration(),
                                                                  child: Stack(),
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
                                                    top: 352,
                                                    child: SizedBox(
                                                      width: 358,
                                                      height: 208,
                                                      child: Column(
                                                        mainAxisSize: MainAxisSize.min,
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        spacing: 8,
                                                        children: [
                                                          SizedBox(
                                                            width: 358,
                                                            child: Text(
                                                              '其他輸入',
                                                              style: TextStyle(
                                                                color: const Color(0xFF1E1E1E) /* Text-Default-Default */,
                                                                fontSize: 16,
                                                                fontFamily: 'Inter',
                                                                fontWeight: FontWeight.w400,
                                                                height: 1.40,
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: ConstrainedBox(
                                                              constraints: BoxConstraints(minWidth: 240, minHeight: 80),
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
                                                                child: Stack(
                                                                  children: [
                                                                    SizedBox(
                                                                      width: 326,
                                                                      child: Text.rich(
                                                                        TextSpan(),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    left: 126,
                                                    top: 582,
                                                    child: Container(
                                                      height: 40,
                                                      clipBehavior: Clip.antiAlias,
                                                      decoration: ShapeDecoration(
                                                        color: const Color(0xFF65558F) /* Schemes-Primary */,
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(100),
                                                        ),
                                                      ),
                                                      child: Column(
                                                        mainAxisSize: MainAxisSize.min,
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        spacing: 8,
                                                        children: [
                                                          Expanded(
                                                            child: Container(
                                                              width: double.infinity,
                                                              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                                                              child: Row(
                                                                mainAxisSize: MainAxisSize.min,
                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                spacing: 8,
                                                                children: [
                                                                  Text(
                                                                    'Generate',
                                                                    textAlign: TextAlign.center,
                                                                    style: TextStyle(
                                                                      color: Colors.white /* Schemes-On-Primary */,
                                                                      fontSize: 14,
                                                                      fontFamily: 'Roboto',
                                                                      fontWeight: FontWeight.w500,
                                                                      height: 1.43,
                                                                      letterSpacing: 0.10,
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
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 0,
                top: 832,
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