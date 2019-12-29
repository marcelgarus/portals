import 'dart:math' as math;
import 'dart:typed_data';

extension Bytes on Uint8List {
  String toHex() =>
      map((byte) => byte.toRadixString(16).fillWithLeadingZeros(2)).join('');

  static Uint8List fromHex(String hexString) {
    return <int>[
      for (var i = 0; i < hexString.length ~/ 2; i++)
        int.parse(hexString.substring(2 * i, 2 * i + 2), radix: 16),
    ].toBytes();
  }
}

extension ToBytesConverter on Iterable<int> {
  /// Turns this [Iterable<int>] into a [Uint8List].
  Uint8List toBytes() => Uint8List.fromList(toList());
}

extension Minimum on Iterable<int> {
  /// Returns the minimum of this list.
  int get min => reduce(math.min);
}

extension LeadingZeros on String {
  /// Fill this string with leading zeros, so that the total length is at least
  /// [length].
  String fillWithLeadingZeros(int length) =>
      '${[for (var i = length - this.length; i > 0; i--) '0'].join()}$this';
}

extension FilterStreamByType<T> on Stream<T> {
  Stream<S> whereType<S extends T>() =>
      this.where((item) => item is S).cast<S>();
}
