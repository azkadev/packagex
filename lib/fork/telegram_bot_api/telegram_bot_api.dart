/* <!-- START LICENSE -->


This Software / Program / Source Code Created By Developer From Company GLOBAL CORPORATION
Social Media:

   - Youtube: https://youtube.com/@Global_Corporation 
   - Github: https://github.com/globalcorporation
   - TELEGRAM: https://t.me/GLOBAL_CORP_ORG_BOT

All code script in here created 100% original without copy / steal from other code if we copy we add description source at from top code

If you wan't edit you must add credit me (don't change)

If this Software / Program / Source Code has you

Jika Program ini milik anda dari hasil beli jasa developer di (Global Corporation / apapun itu dari turunan itu jika ada kesalahan / bug / ingin update segera lapor ke sub)

Misal anda beli Beli source code di Slebew CORPORATION anda lapor dahulu di slebew jangan lapor di GLOBAL CORPORATION!

Jika ada kendala program ini (Pastikan sebelum deal project tidak ada negosiasi harga)
Karena jika ada negosiasi harga kemungkinan

1. Software Ada yang di kurangin
2. Informasi tidak lengkap
3. Bantuan Tidak Bisa remote / full time (Ada jeda)

Sebelum program ini sampai ke pembeli developer kami sudah melakukan testing

jadi sebelum nego kami sudah melakukan berbagai konsekuensi jika nego tidak sesuai ? 
Bukan maksud kami menipu itu karena harga yang sudah di kalkulasi + bantuan tiba tiba di potong akhirnya bantuan / software kadang tidak lengkap


<!-- END LICENSE --> */
// ignore_for_file: non_constant_identifier_names, camel_case_extensions, slash_for_doc_comments, empty_catches, unnecessary_brace_in_string_interps

//
import 'dart:async' show Completer, Future, Stream, StreamTransformer;
import 'dart:convert' as convert;
import 'dart:typed_data';

// import 'dart:convert';

// import 'package:serverUniverseNative/serverUniverseNative.dart';
import 'package:general_lib/general_lib.dart';
import 'package:http/http.dart';
import 'package:io_universe/io_universe.dart';
import "package:path/path.dart" as path;

/// Telegram Bot Api library:
/// example:
/// ```dart
/// TelegramBotApi tg = TelegramBotApi("token_bot");
/// tg.request("sendMessage",  parameters: {
///   "chat_id": 12345,
///   "text": "Hello world"
/// });
/// ````
///
class TelegramBotApi {
  /// TelegramClientUncompleDocumentation
  late final String token_bot;

  /// TelegramClientUncompleDocumentation
  final Client httpClient;

  /// TelegramClientUncompleDocumentation
  final Map client_option = {
    "api_id": 0,
    "api_hash": "",
    "botPath": "/bot/",
    "userPath": "/user/",
    "port": 8080,
    "type": "bot",
    "logger": false,
    "api": "https://api.telegram.org/",
    "allowed_updates": [
      "message",
      "edited_message",
      "channel_post",
      "edited_channel_post",
      "inline_query",
      "chosen_inline_result",
      "callback_query",
      "shipping_query",
      "pre_checkout_query",
      "poll",
      "poll_answer",
      "my_chat_member",
      "chat_member",
      "chat_join_request",
    ],
  };

  /// list methods:
  /// api:
  /// ```dart
  /// tg.request("getMe");
  /// ```
  ///
  TelegramBotApi({
    required this.token_bot,
    Map? clientOption,
    Client? httpClient,
  }) : httpClient = httpClient ?? Client() {
    if (clientOption != null) {
      client_option.addAll(clientOption);
    }
  }

  /// TelegramClientUncompleDocumentation
  TelegramBotApiFileData telegram_bot_api_file_data({
    required String name,
    required Uint8List buffer_data,
  }) {
    return TelegramBotApiFileData(buffer_data: buffer_data, name: name);
  }

  /// TelegramClientUncompleDocumentation

  TelegramBotApiFileData telegram_bot_api_file({required File file}) {
    return TelegramBotApiFileData(
      buffer_data: file.readAsBytesSync(),
      name: path.basename(file.path),
    );
  }

  // /// TelegramClientUncompleDocumentation
  // Map typeFile(dynamic content) {
  //   Map data = {};
  //   if (content is String) {
  //     if (RegExp(r"^http", caseSensitive: false).hashData(content)) {
  //       data = {"@type": 'inputFileRemote', "data": content};
  //     }
  //     if (content is int) {
  //       data = {"@type": 'inputFileId', "data": content};
  //     } else {
  //       data = {"@type": 'inputFileRemote', "data": content};
  //     }
  //   } else {
  //     data = {"@type": 'inputFileRemote', "data": content};
  //   }
  //   return data;
  // }

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  Map typeFile(dynamic content) {
    // Map return {};
    if (content is String) {
      if (RegExp(r"^http", caseSensitive: false).hasMatch(content)) {
        return {"@type": 'inputFileRemote', "data": content};
      } else if (RegExp(
        r"^(\/|\.\.?\/|~\/)",
        caseSensitive: false,
      ).hasMatch(content)) {
        File file = File(content);
        // file.uri.;
        return {
          "@type": 'inputFileLocal',
          "data": telegram_bot_api_file(file: file),
        };
      } else if (content is int) {
        return {"@type": 'inputFileId', "data": content};
      } else {
        return {"@type": 'inputFileRemote', "data": content};
      }
    } else {
      return {"@type": 'inputFileRemote', "data": content};
    }
  }

  /// call api latest [bot api](https://core.telegram.org/bots/api#available-methods)
  /// example:
  /// ```dart
  /// invoke("sendMessage", parameters: {
  ///   "chat_id": 123456,
  ///   "text": "<b>Hello</b> <code>word</code>",
  ///   "parse_mode": "html"
  /// });
  /// ```
  Future<Map> invoke({
    required Map parameters,
    bool is_form = false,
    String? tokenBot,
    String? urlApi,
    String? clientType,
    bool isThrowOnError = true,
    void Function(int bytesCount, int totalBytes)? onUploadProgress,
  }) async {
    if (parameters["@type"] is String == false) {
      parameters["@type"] = "";
    }
    final String method = parameters["@type"];
    clientType ??= client_option["type"];
    urlApi ??= client_option["api"];
    tokenBot ??= token_bot;
    Map<dynamic, dynamic> option = <dynamic, dynamic>{"method": "post"};
    // auto set reply parameters
    if (parameters["reply_parameters"] is Map == false) {
      if (parameters["reply_to_message_id"] is num) {
        if (parameters["reply_parameters"] is Map) {
          parameters["reply_parameters"]["message_id"] =
              parameters["reply_to_message_id"];
          parameters["reply_parameters"]["allow_sending_without_reply"] = true;
        } else {
          parameters["reply_parameters"] = {
            "message_id": parameters["reply_to_message_id"],
            "allow_sending_without_reply": true,
          };
        }
      }
    }
    String url = Uri.parse((urlApi ?? "")).replace(
      pathSegments: [(clientType ?? "bot") + tokenBot, method],
    ).toString();
    if (!is_form) {
      List<String> methodForm = [
        "sendDocument",
        "sendPhoto",
        "sendAudio",
        "sendVideo",
        "sendVoice",
        "setChatPhoto",
        "sendVideoNote",
        "sendAnimation",
        "sendMediaGroup",
      ];
      List<String> keyForm = [
        "video",
        "audio",
        "voice",
        "document",
        "photo",
        "animation",
        "video_note",
        "media",
      ];

      if (methodForm
          .map((e) => e.toLowerCase())
          .toList()
          .contains(method.toLowerCase())) {
        parameters.forEach((key, value) {
          try {
            if (keyForm.contains(key)) {
              if (key == "media") {
                if (value is List) {
                  for (var i = 0; i < value.length; i++) {
                    Map value_data = value[i];
                    value_data.forEach((key_loop, value_loop) {
                      if (key_loop == "media") {
                        if (value_loop is File) {
                          value[i][key_loop] = value_loop.uri.toString();
                        } else {
                          try {
                            value[i][key_loop] = typeFile(value_loop)["data"];
                            if (value[i][key_loop] is String == false) {
                              is_form = true;
                            }
                          } catch (e) {}
                        }
                      }
                    });
                  }
                }
              } else if (value is File) {
                parameters[key] = value.uri.toString();
              } else {
                parameters[key] = typeFile(value)["data"];
                if (parameters[key] is String == false) {
                  is_form = true;
                }
              }
            }
          } catch (e) {}
        });
      }
    }
    try {
      if (is_form) {
        final httpClientForm = HttpClient();
        final request = await httpClientForm.postUrl(Uri.parse(url));
        final form = MultipartRequest("post", Uri.parse(url));

        parameters.forEach((key, value) async {
          if (value is File) {
            form.fields[key] = value.uri.toString();
          } else if (value is Map) {
            if (value["is_post_file"] == true) {
              var files = await MultipartFile.fromPath(key, value["file_path"]);
              form.files.add(files);
            } else if (value["is_post_buffer"] == true) {
              var files = MultipartFile.fromBytes(
                key,
                (value["buffer"] as List).cast<int>(),
                filename: value["name"],
                contentType: value["content_type"],
              );
              form.files.add(files);
            } else {
              form.fields[key] = convert.json.encode(value);
            }
          } else if (value is TelegramBotApiFileData) {
            var files = MultipartFile.fromBytes(
              key,
              value.buffer_data,
              filename: value.name,
              contentType: null,
            );
            form.files.add(files);
          } else if (value is String) {
            form.fields[key] = value;
          } else if (key == "media" && value is List<Map>) {
            List<Map> values = [];
            for (var i = 0; i < value.length; i++) {
              Map value_data = value[i];
              Map jsonData = {};
              value_data.forEach((key_loop, value_loop) {
                if (key_loop == "media" && value_loop is Map) {
                  if (value_loop["is_post_buffer"] == true) {
                    String name_file = "file_${i}_${value_loop["name"]}";
                    var files = MultipartFile.fromBytes(
                      name_file,
                      value_loop["buffer"],
                      filename: value_loop["name"],
                      contentType: value_loop["content_type"],
                    );
                    form.files.add(files);
                    jsonData[key_loop] = "attach://${name_file}";
                  } else {
                    jsonData[key_loop] = value_loop.toString();
                  }
                } else if (value_loop is TelegramBotApiFileData) {
                  String name_file = "file_${i}_${value_loop.name}";
                  var files = MultipartFile.fromBytes(
                    name_file,
                    value_loop.buffer_data,
                    filename: value_loop.name,
                    contentType: null,
                  );
                  form.files.add(files);
                  jsonData[key_loop] = "attach://${name_file}";
                } else if (value_loop is File) {
                  jsonData[key_loop] = value_loop.uri.toString();
                } else {
                  jsonData[key_loop] = value_loop.toString();
                }
              });
              values.add(jsonData);
            }
            form.fields[key] = convert.json.encode(values);
          } else {
            form.fields[key] = value.toString();
          }
        });

        utils_remove_parameters(data: parameters);
        var msStream = form.finalize();
        var totalByteLength = form.contentLength;
        request.contentLength = totalByteLength;
        request.headers.set(
          HttpHeaders.contentTypeHeader,
          form.headers[HttpHeaders.contentTypeHeader]!,
        );
        int byteCount = 0;
        Stream<List<int>> streamUpload = msStream.transform(
          StreamTransformer.fromHandlers(
            handleData: (data, sink) {
              sink.add(data);
              byteCount += data.length;
              if (onUploadProgress != null) {
                onUploadProgress(byteCount, totalByteLength);
              }
            },
            handleError: (error, stack, sink) {
              throw error;
            },
            handleDone: (sink) {
              sink.close();
            },
          ),
        );
        await request.addStream(streamUpload);
        final httpResponse = await request.close();
        var statusCode = httpResponse.statusCode;
        var completer = Completer<String>();
        var contents = StringBuffer();
        httpResponse.transform(convert.utf8.decoder).listen(
          (String data) {
            contents.write(data);
          },
          onDone: () => completer.complete(contents.toString()),
        );
        var body = convert.json.decode(await completer.future);
        if (statusCode == 200) {
          return body;
        } else {
          if (isThrowOnError) {
            throw body;
          } else {
            return body;
          }
        }
      } else {
        utils_remove_parameters(data: parameters);
        option["body"] = convert.json.encode(parameters);
        final response = await httpClient.post(
          Uri.parse(url),
          headers: {
            'Accept': 'application/json',
            "Access-Control-Allow-Origin": "*",
            "Content-Type": "application/json",
          },
          body: option["body"],
        );
        if (response.statusCode == 200) {
          if (method.toString().toLowerCase() == "getfile") {
            var getFile = convert.json.decode(response.body);
            var url = "${urlApi}file/${clientType}${tokenBot.toString()}";
            getFile["result"]["file_url"] =
                "${url}/${getFile["result"]["file_path"]}";
            return getFile;
          } else {
            return convert.json.decode(response.body);
          }
        } else {
          var json = convert.json.decode(response.body);
          if (isThrowOnError) {
            throw json;
          } else {
            return json;
          }
        }
      }
    } catch (e) {
      if (RegExp(r"^(send)", caseSensitive: false).hasMatch(method)) {
        if (e is Map) {
          if (RegExp(
            "Unsupported start tag",
            caseSensitive: false,
          ).hasMatch(e["description"])) {
            parameters.remove("parse_mode");
            return await invoke(
              parameters: parameters,
              is_form: is_form,
              isThrowOnError: isThrowOnError,
              tokenBot: tokenBot,
              urlApi: urlApi,
              clientType: clientType,
              onUploadProgress: onUploadProgress,
            );
            // Bad Request: can't parse entities: Unsupported start tag "spoir" at byte offset 79
          }
        }
        rethrow;
      } else {
        rethrow;
      }
    }
  }

  /// TelegramClientUncompleDocumentation
  void utils_remove_parameters({required Map data}) {
    data.removeWhere((key, value) {
      if (value is File) {
        return true;
      }
      if (value is Map) {
        utils_remove_parameters(data: data[key] as Map);
      }
      if (value is List) {
        utils_remove_parameterss(datas: value);
      }
      return false;
    });
  }

  /// TelegramClientUncompleDocumentation
  void utils_remove_parameterss({required List datas}) {
    datas.removeWhere((element) {
      if (element is Map) {
        utils_remove_parameters(data: element);
      }
      if (element is List) {
        utils_remove_parameterss(datas: element);
      }
      return false;
    });
  }

  /// call api latest [bot api](https://core.telegram.org/bots/api#available-methods)
  /// example:
  /// ```dart
  /// request("sendMessage", parameters: {
  ///   "chat_id": 123456,
  ///   "text": "<b>Hello</b> <code>word</code>",
  ///   "parse_mode": "html"
  /// });
  /// ```
  Future<Map> request(
    String method, {
    Map? parameters,
    bool is_form = false,
    String? tokenBot,
    String? urlApi,
    String? clientType,
    void Function(int bytesCount, int totalBytes)? onUploadProgress,
    bool isAutoExtendMessage = false,
    bool isThrowOnError = true,
    Client? httpClient,
  }) async {
    parameters ??= {};
    clientType ??= client_option["type"];
    urlApi ??= client_option["api"];
    tokenBot ??= token_bot;

    if (parameters["is_natural"] == true) {}

    if (isAutoExtendMessage) {
      if (parameters["text"] is String) {
        String text = parameters["text"];
        if (text.length >= 4096) {
          List<String> messagesJson = GeneralLibUtils.splitByLength(text, 4096);
          List result = [];
          for (var i = 0; i < messagesJson.length; i++) {
            var loopData = messagesJson[i];
            try {
              await Future.delayed(Duration(milliseconds: 500));
              parameters["text"] = loopData;
              if (RegExp(
                "(editMessageText)",
                caseSensitive: false,
              ).hashData(method)) {
                if (i != 0) {
                  method = "sendMessage";
                }
              }
              var res = await invoke(
                parameters: parameters,
                is_form: is_form,
                tokenBot: tokenBot,
                urlApi: urlApi,
                clientType: clientType,
                onUploadProgress: onUploadProgress,
                isThrowOnError: isThrowOnError,
              );
              result.add(res);
            } catch (e) {
              result.add(e);
            }
          }
          return {"result": result};
        }
      }

      if (parameters["caption"] is String) {
        String caption = parameters["caption"];
        if (caption.length >= 1024) {
          List<String> messagesJson =
              GeneralLibUtils.splitByLength(caption, 1024);
          List result = [];
          for (var i = 0; i < messagesJson.length; i++) {
            var loopData = messagesJson[i];
            try {
              await Future.delayed(Duration(milliseconds: 500));
              parameters["caption"] = loopData;
              if (RegExp(
                "(editMessageCaption)",
                caseSensitive: false,
              ).hashData(method)) {
                if (i != 0) {
                  parameters["text"] = loopData;
                  method = "sendMessage";
                }
              }
              var res = await invoke(
                parameters: parameters,
                is_form: is_form,
                tokenBot: tokenBot,
                urlApi: urlApi,
                clientType: clientType,
                onUploadProgress: onUploadProgress,
                isThrowOnError: isThrowOnError,
              );
              result.add(res);
            } catch (e) {
              result.add(e);
            }
          }
          return {"result": result};
        }
      }
    }

    return await invoke(
      parameters: parameters,
      is_form: is_form,
      tokenBot: tokenBot,
      urlApi: urlApi,
      clientType: clientType,
      onUploadProgress: onUploadProgress,
      isThrowOnError: isThrowOnError,
    );
  }

  /// call api latest [bot api](https://core.telegram.org/bots/api#available-methods) with upload file
  /// example:
  /// ```dart
  /// requestForm("sendDocument",  parameters: {
  ///   "chat_id": 123456,
  ///   "document": tg.file("./doc.json"),
  ///   "parse_mode": "html"
  /// });
  /// ```
  Future<Map> requestForm(
    String method, {
    Map parameters = const {},
    bool is_form = false,
    String? tokenBot,
    String? urlApi,
    String? clientType,
    void Function(int bytesCount, int totalBytes)? onUploadProgress,
    bool isAutoExtendMessage = false,
    bool isThrowOnError = true,
    Client? httpClient,
  }) async {
    tokenBot ??= token_bot;
    return await request(
      method,
      parameters: parameters,
      is_form: true,
      tokenBot: tokenBot,
      urlApi: urlApi,
      clientType: clientType,
      onUploadProgress: onUploadProgress,
      isAutoExtendMessage: isAutoExtendMessage,
      isThrowOnError: isThrowOnError,
      httpClient: httpClient,
    );
  }

  /// donload file with proggres
  Future<String> fileDownload(
    String url, {
    required String path,
    void Function(int bytes, int totalBytes)? onDownloadProgress,
  }) async {
    final httpClient = HttpClient();
    final request = await httpClient.getUrl(Uri.parse(url));
    request.headers.add(
      HttpHeaders.contentTypeHeader,
      "application/octet-stream",
    );
    var httpResponse = await request.close();
    int byteCount = 0;
    int totalBytes = httpResponse.contentLength;
    File file = File(path);
    var raf = file.openSync(mode: FileMode.write);
    Completer completer = Completer<String>();
    httpResponse.listen(
      (data) {
        byteCount += data.length;
        raf.writeFromSync(data);
        if (onDownloadProgress != null) {
          onDownloadProgress(byteCount, totalBytes);
        }
      },
      onDone: () {
        raf.closeSync();
        completer.complete(file.path);
      },
      onError: (e) {
        raf.closeSync();
        file.deleteSync();
        completer.completeError(e);
      },
      cancelOnError: true,
    );
    return await completer.future;
  }
}

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
class TelegramBotApiFileData {
  /// TelegramClientUncompleDocumentation
  final String name;

  /// TelegramClientUncompleDocumentation
  final Uint8List buffer_data;

  /// TelegramClientUncompleDocumentation
  const TelegramBotApiFileData({required this.name, required this.buffer_data});
}
