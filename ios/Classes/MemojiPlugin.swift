import Flutter
import UIKit
import MemojiView

public class SwiftMemojiPlugin: NSObject, FlutterPlugin, MemojiViewDelegate {
  var channel: FlutterMethodChannel!

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "memoji", binaryMessenger: registrar.messenger())
    let instance = SwiftMemojiPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
    instance.channel = channel
  }

public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
  if call.method == "getMemoji" {
    // Create MemojiView and set its delegate
    let memojiView = MemojiView(frame: UIScreen.main.bounds)
    memojiView.delegate = self

    // Obtain the root view controller
    if let viewController = UIApplication.shared.delegate?.window??.rootViewController {
      // Add the MemojiView to the root view controller's view
      viewController.view.addSubview(memojiView)
    }
  }
}
  // MemojiView delegate
  public func didUpdateImage(image: UIImage, type: ImageType) {
    let byteArray = getByteArrayForImage(image)
    // Send the byte array to Flutter
    channel.invokeMethod("onImageUpdated", arguments: byteArray)
  }

  private func getByteArrayForImage(_ image: UIImage, compression: CGFloat = 1.0) -> Array<UInt8> {
    guard let imageData = image.jpegData(compressionQuality: compression) as? NSData else { return [] }
    let count = imageData.length / MemoryLayout<Int8>.size

    var bytes = [UInt8](repeating: 0, count: count)
    imageData.getBytes(&bytes, length:count * MemoryLayout<Int8>.size)
    return bytes
  }
}
