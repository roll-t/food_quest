// ignore_for_file: depend_on_referenced_packages

import 'package:dio/dio.dart';
import 'package:food_quest/core/services/deep_link_service.dart';
import 'package:food_quest/main/food/data/model/meta_data_model.dart';
import 'package:food_quest/main/food/data/model/tiktok_meta_data.dart';
import 'package:get/get.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart' as html_parser;
import 'package:tiktok_scraper/tiktok_scraper.dart';

class DeepLinkController extends GetxController {
  final Rx<MetaDataModel?> metaData = Rx(null);
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _initDeepLink();
  }

  void _initDeepLink() {
    final raw = DeepLinkService.sharedText;
    if (raw != null && raw.isEmpty) return;
    fetchMetaData(raw!);
  }

  Future<void> fetchMetaData(String url) async {
    isLoading.value = true;
    update(["EXTRA_LINK_ID"]);
    try {
      if (_isTikTokUrl(url)) {
        metaData.value = await _fetchTikTokMeta(url);
      } else {
        metaData.value = await _fetchNormalMeta(url);
      }
    } finally {
      isLoading.value = false;
    }
    update(["EXTRA_LINK_ID"]);
  }

  Future<MetaDataModel?> _fetchTikTokMeta(String url) async {
    try {
      final video = await TiktokScraper.getVideoInfo(url);
      final parsed = TiktokMetaData.fromJson(video.toMap());
      return parsed.toMetaData().copyWith(url: url);
    } catch (e) {
      return await _fetchNormalMeta(url);
    }
  }

  /// ✅ Metadata của web thông thường
  Future<MetaDataModel?> _fetchNormalMeta(String url) async {
    try {
      final document = await _fetchDocument(url);
      if (document == null) return null;

      return MetaDataModel.fromMap(_parseMetadata(document, url));
    } catch (e) {
      return null;
    }
  }

  Future<Document?> _fetchDocument(String url) async {
    try {
      final dio = Dio(BaseOptions(
        headers: {
          "User-Agent": "Mozilla/5.0 (compatible; Discordbot/2.0; +https://discordapp.com)",
        },
        followRedirects: true,
      ));

      final response = await dio.get(url);
      return html_parser.parse(response.data);
    } catch (e) {
      return null;
    }
  }

  Map<String, dynamic> _parseMetadata(Document doc, String url) {
    String? title, description, image, favicon, appleIcon;

    for (var meta in doc.getElementsByTagName("meta")) {
      final property = meta.attributes["property"];
      final content = meta.attributes["content"];
      if (property == "og:title") title = content;
      if (property == "og:description") description = content;
      if (property == "og:image") image = content;
    }

    for (var link in doc.getElementsByTagName("link")) {
      final rel = link.attributes['rel'];
      final href = link.attributes['href'];
      if (rel == 'apple-touch-icon') appleIcon = href;
      if (rel?.contains('icon') == true) favicon = href;
    }

    title ??= doc.getElementsByTagName("title").first.text;

    return {
      'URL': url,
      'TITLE': title,
      'DESCRIPTION': description ?? '',
      'IMAGE_URL': image ?? '',
      'FAVICON': favicon ?? '',
      'APPLE_ICON': appleIcon ?? '',
    };
  }

  bool _isTikTokUrl(String url) => url.contains("tiktok.com");
}
