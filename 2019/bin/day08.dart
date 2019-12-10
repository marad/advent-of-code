import 'dart:io';
import 'package:aoc2019/src/day08.dart';


void renderImage(ImageMeta meta, String input) {
  for(var y=0; y < meta.height; y++) {
    for(var x=0; x < meta.width; x++) {
      String pixel = getPixel(meta, input, x, y);
      if (pixel == "1") stdout.write(pixel);
      else stdout.write(' ');
    }
  print('');
  }
}

int calcChecksum(ImageMeta meta, String input) {
  String bestLayer = null;
  int bestZeroes = meta.layerSize;
  for(var i=0; i < countLayers(meta, input); i++) {
    var layer = readLayer(meta, i, input);
    var zeroes = countChar(layer, "0");
    if (zeroes < bestZeroes) {
      bestLayer = layer;
      bestZeroes = zeroes;
    }
  }

  var onesCount = countChar(bestLayer, "1");
  var twosCount = countChar(bestLayer, "2");
  var checksum = onesCount * twosCount;
  return checksum;
}



void main() {
  ImageMeta meta = ImageMeta(25, 6);

  String input = File('inputs/day08.txt').readAsStringSync();
  var checksum = calcChecksum(meta, input);
  print('checksum: $checksum');

  renderImage(meta, input);
}