//Centralization of Assets

final class _AssetsImagesGen {
  const _AssetsImagesGen();
  static const _imagePath = "${Assets._basePath}/images";

  String get splashImage => "$_imagePath/splash.gif";
  String get loadingImage => "$_imagePath/loading.gif";
}

final class _AssetsSvgIconGen {
  const _AssetsSvgIconGen();
}

abstract final class Assets {
  Assets._();
  static const _basePath = "assets";

  static const images = _AssetsImagesGen();
  static const icons = _AssetsSvgIconGen();
}
