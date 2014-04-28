# Script Inliner

_A transformer for pub._

## Speed up your app's initial load

What if you could give _90ms_ back to your app's users?

Dart apps require a dart.js file, which helps decide if the original
Dart code, or the generated JavaScript code, should be loaded by
the browser.

The browser must fetch dart.js before it can fetch the application logic.
This causes unnecessary startup delay for your users.

## How it works

This small transformer inlines script contents, ensuring the dart.js file
is included in the initial HTML download. No more resource fetch just to
get the app!

## Configuring

Add the transformer to your pubspec.yaml:

    transformers:
    - script_inliner
    
(Assuming you already added this package to your pubspec.yaml file.)

## Usage

Add a `data-pub-inline` attribute to the script tag.

    <script data-pub-inline src="packages/browser/dart.js"></script>
    
Run `pub build` to build the application, or `pub serve` to run a development
server. In both cases, `pub` will inline the dart.js file:


    <script data-pub-inline="packages/browser/dart.js">
    // Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
    // for details. All rights reserved. Use of this source code is governed by a
    // BSD-style license that can be found in the LICENSE file.
    
    (function() {
    // Bootstrap support for Dart scripts on the page as this script.
    if (navigator.userAgent.indexOf('(Dart)') === -1) {
      // TODO:
    ...
    ...
    
## Known issues

I've tested only with dart.js and a CSS file. Please let me know how it works
for you!

## Bugs/requests

Please report [bugs and feature requests][bugs].


[bugs]: https://github.com/sethladd/script_inliner/issues