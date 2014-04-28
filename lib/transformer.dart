import 'package:barback/barback.dart';
import 'dart:async';
import 'package:html5lib/parser.dart' show parse;
import 'dart:io';
//import 'package:html5lib/dom.dart';

class ScriptInliningTransformer extends Transformer {
  ScriptInliningTransformer.asPlugin();

  String get allowedExtensions => ".html";

  Future apply(Transform transform) {
    var id = transform.primaryInput.id;
    return transform.primaryInput.readAsString().then((content) {
      var document = parse(content);

      // attribute selectors don't work yet, do it manually
      var processing = document.querySelectorAll('script').where((tag) {
        return tag.attributes['data-pub-inline'] != null && tag.attributes['src'] != null;
      }).map((tag) {
        var src = tag.attributes['src'];
        return new File(src).readAsString().then((source) {
          tag.text = source;
          tag.attributes.remove('src');
        }).catchError((e) => print("ERROR: reading $src, error: $e"));
                             // TODO: what's the right way to log?
      });

      return Future.wait(processing).then((_) {
        transform.addOutput(new Asset.fromString(id, document.outerHtml));
      });
    });
  }
}