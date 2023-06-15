import Flutter
import UIKit
import MemojiView


public class SwiftMemojiPlugin: NSObject, FlutterPlugin, UITextViewDelegate {
  var result: FlutterResult?

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "memoji", binaryMessenger: registrar.messenger())
    let instance = SwiftMemojiPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    if (call.method == "getMemoji") {
      self.result = result
      showTextView()
    } else {
      result(FlutterMethodNotImplemented)
    }
  }

  func showTextView() {
    let textView = UITextView(frame: CGRect.zero)
    textView.delegate = self
    textView.isHidden = true
    textView.isEditable = true
    textView.allowsEditingTextAttributes = true

    let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
    keyWindow?.addSubview(textView)

    textView.becomeFirstResponder()
  }

  public func textViewDidChange(_ textView: UITextView) {
    guard let attributedString = textView.attributedText else { return }

    attributedString.enumerateAttribute(NSAttributedString.Key.attachment, in: NSRange(location: 0, length: attributedString.length), options: [], using: {(value, range, stop) -> Void in
      if let attachement = value as? NSTextAttachment {
        var image: UIImage?
        if let attachementImage = attachement.image {
          image = attachementImage
        } else {
          image = attachement.image(forBounds: attachement.bounds, textContainer: nil, characterIndex: range.location)
        }

        if let imageData = image?.pngData() {
          result?(imageData)
          textView.removeFromSuperview()
        }
      }
    })
  }
}
