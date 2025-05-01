import 'dart:math';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class Photo {
  Photo({
    required this.albumId,
    required this.id,
    required this.title,
    required this.url,
    required this.thumbnail,
    required this.width,
    required this.height,
  });

  final int albumId;
  final int id;
  final String title;
  final String url;
  final String thumbnail;
  final int width;
  final int height;

  factory Photo.fromPlaceholderJson(dynamic json) {
    final id = json["thumbnailUrl"].split('/').last;
    final width = Random(id.hashCode ^ 1).nextInt(1000) + 300;
    final height = Random(id.hashCode ^ 2).nextInt(1000) + 300;
    return Photo(
      albumId: json["albumId"],
      id: json["id"],
      title: json["title"],
      url: json["url"],
      thumbnail: 'https://picsum.photos/seed/$id/$width/$height',
      width: width,
      height: height,
    );
  }
}


class RemoteApi {
  static Future<List<Photo>> getPhotos(
    int page, {
    int limit = 20,
    String? search,
  }) {
    if (Random().nextInt(10) == 0) {
      throw RandomChanceException();
    }

    return Future.delayed(
      const Duration(seconds: 0),
      () => http
          .get(
            _ApiUrlBuilder.photos(page, limit, search),
          )
          .mapFromResponse<List<Photo>, List<dynamic>>(
            (jsonArray) => _parseItemListFromJsonArray(
              jsonArray,
              Photo.fromPlaceholderJson,
            ),
          ),
    );
  }

  static List<T> _parseItemListFromJsonArray<T>(
    List<dynamic> jsonArray,
    T Function(dynamic object) mapper,
  ) =>
      jsonArray.map(mapper).toList();
}

class GenericHttpException implements Exception {
  const GenericHttpException({
    this.message,
    this.statusCode,
  });

  final String? message;
  final int? statusCode;

  @override
  String toString() {
    if (statusCode != null) {
      return 'HTTP $statusCode: $message';
    } else {
      return message ?? 'Unknown error';
    }
  }
}

class NoConnectionException implements Exception {
  @override
  String toString() => 'No connection';
}

class RandomChanceException implements Exception {
  @override
  String toString() => 'Random chance';
}

class _ApiUrlBuilder {
  static const _baseUrl = 'jsonplaceholder.typicode.com';
  static const _photosResource = 'photos';

  static Uri photos(int page, int limit, String? search) => Uri(
        scheme: 'https',
        host: _baseUrl,
        path: '/$_photosResource',
        queryParameters: {
          '_start': '${(page - 1) * limit}',
          '_limit': limit.toString(),
          'q': search,
        },
      );
}

extension on Future<http.Response> {
  Future<R> mapFromResponse<R, T>(R Function(T) jsonParser) async {
    try {
      final response = await this;
      if (response.statusCode == 200) {
        return jsonParser(jsonDecode(response.body));
      } else {
        throw GenericHttpException(
          message: response.reasonPhrase,
          statusCode: response.statusCode,
        );
      }
    } on SocketException {
      throw NoConnectionException();
    } on Object catch (e, s) {
      Zone.current.handleUncaughtError(e, s);
      rethrow;
    }
  }
}
class CustomFirstPageError extends StatelessWidget {
  const CustomFirstPageError({
    super.key,
    required this.pagingController,
  });

  final PagingController<Object, Object> pagingController;

  @override
  Widget build(BuildContext context) {
    return PagingListener(
      controller: pagingController,
      builder: (context, state, _) => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Something went wrong :(',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            if (state.error != null) ...[
              const SizedBox(
                height: 16,
              ),
              Text(
                state.error.toString(),
                textAlign: TextAlign.center,
              ),
            ],
            const SizedBox(
              height: 48,
            ),
            SizedBox(
              width: 200,
              child: ElevatedButton.icon(
                onPressed: pagingController.refresh,
                icon: const Icon(Icons.refresh),
                label: const Text(
                  'Try Again',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomNewPageError extends StatelessWidget {
  const CustomNewPageError({
    super.key,
    required this.pagingController,
  });

  final PagingController<Object, Object> pagingController;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: pagingController.fetchNextPage,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'We didn\'t catch that. Try again?',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 4),
            const Icon(
              Icons.refresh,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
class ImageListTile extends StatelessWidget {
  const ImageListTile({
    super.key,
    required this.item,
  });

  final Photo item;

  @override
  Widget build(BuildContext context) => ListTile(
        leading: CircleAvatar(
          radius: 20,
          backgroundImage: CachedNetworkImageProvider(item.thumbnail),
        ),
        title: Text(item.title),
      );
}

class SearchAppBar extends StatefulWidget implements PreferredSizeWidget {
  const SearchAppBar({
    super.key,
    required this.searchTerm,
    required this.onSearch,
  });

  final String? searchTerm;
  final ValueChanged<String> onSearch;

  @override
  State<SearchAppBar> createState() => _SearchAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _SearchAppBarState extends State<SearchAppBar> {
  bool _isSearchMode = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      child: _isSearchMode
          ? AppBar(
              title: TextFormField(
                initialValue: widget.searchTerm,
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: 'Search...',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(16),
                ),
                style: Theme.of(context).textTheme.titleLarge,
                onFieldSubmitted: (value) {
                  widget.onSearch(value);
                  setState(() => _isSearchMode = false);
                },
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => setState(() => _isSearchMode = false),
                ),
              ],
            )
          : AppBar(
              title: const Text('Photos'),
              actions: [
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () => setState(() => _isSearchMode = true),
                ),
              ],
            ),
    );
  }
}
