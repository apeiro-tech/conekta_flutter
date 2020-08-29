#import "ConektaFlutterPlugin.h"
#if __has_include(<conekta_flutter/conekta_flutter-Swift.h>)
#import <conekta_flutter/conekta_flutter-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "conekta_flutter-Swift.h"
#endif

@implementation ConektaFlutterPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftConektaFlutterPlugin registerWithRegistrar:registrar];
}
@end
