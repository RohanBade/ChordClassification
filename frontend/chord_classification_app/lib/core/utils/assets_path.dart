//Centralization of Assets

class _AssetsImagesGen {
  const _AssetsImagesGen();
  static const _imagePath = "${Assets._basePath}/images";

  String get splashImage => "$_imagePath/splash.gif";
  String get loadingImage => "$_imagePath/loading.gif";
}

class _AssetsSvgIconGen {
  const _AssetsSvgIconGen();
}

class Assets {
  Assets._();
  static const _basePath = "assets";

  static const images = _AssetsImagesGen();
  static const icons = _AssetsSvgIconGen();
}
