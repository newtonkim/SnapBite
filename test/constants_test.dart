import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:snapbit/utils/constants.dart';

void main() {
  test('textFont is a TextStyle with correct properties', () {
    expect(textFont, isA<TextStyle>());
    expect(textFont.fontSize, 16);
    expect(textFont.color, Colors.white);
  });
}
