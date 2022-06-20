import Cocoa
import FlutterMacOS

// Channel names
let appUID: String = "benrmclemore.flashcardsapp"
enum ChannelName {
  static let sendFiles = "\(appUID)/sendFiles"
}

@NSApplicationMain
@objc class AppDelegate: FlutterAppDelegate, FlutterStreamHandler {
  private var eventSink: FlutterEventSink?
  
  // override func applicationDidFinishLaunching(_ notification: Notification) {
  //   guard let controller = window?.rootViewController as? FlutterViewController else {
  //     fatalError("rootViewController is not type FlutterViewController")
  //   }
  //   let sendFilesChannel = FlutterEventChannel(
  //     name: ChannelName.sendFiles,
  //     binaryMessenger: controller.binaryMessenger
  //   )
  //   sendFilesChannel.setStreamHandler(self)
  // }
  
  
  
  func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
    self.eventSink = events
    return nil
  }
  
  func onCancel(withArguments arguments: Any?) -> FlutterError? {
    NotificationCenter.default.removeObserver(self)
    eventSink = nil
    return nil
  }
    
  override func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
    return true
  }

  override func application(_ sender: NSApplication, openFile filename: String) -> Bool {
    print("APP OPEN FILE")
    return true
  }
}
