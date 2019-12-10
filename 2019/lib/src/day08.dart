
class ImageMeta {
  int width;
  int height;
  int get layerSize => width * height;
  ImageMeta(this.width, this.height);
}

int countLayers(ImageMeta meta, String input) {
  return input.length ~/ meta.layerSize;
}

int countChar(String layer, String char) {
  var charCode = char.codeUnitAt(0);
  return layer.codeUnits.where((char) => char == charCode).length;
}

String readLayer(ImageMeta meta, int layer, String input) {
  var startIndex = meta.layerSize * layer;
  var endIndex = startIndex + meta.layerSize;
  return input.substring(startIndex, endIndex);
}

List<String> readLayers(ImageMeta meta, String input) {
  List<String> layers = [];
  for(var i=0; i < countLayers(meta, input); i++) {
    layers.add(readLayer(meta, i, input));
  }
  return layers;
}

String getPixel(ImageMeta meta, String input, int x, int y) {
  for(var i=0; i < countLayers(meta, input); i++) {
    var layerPixel = _getLayerPixel(meta, input, i, x, y);
    if (layerPixel == "2") continue;
    return layerPixel;
  }
  return "2";
}

String _getLayerPixel(ImageMeta meta, String input, int layer, int x, int y) {
  var layerIndex = layer * meta.layerSize;
  var pixelIndex = layerIndex + (y * meta.width) + x;
  return input[pixelIndex];
}
