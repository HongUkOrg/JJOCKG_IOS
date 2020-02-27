// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

#if os(OSX)
  import AppKit.NSImage
  internal typealias Image = NSImage
#elseif os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIImage
  internal typealias Image = UIImage
#endif

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

@available(*, deprecated, renamed: "JGImage")
internal typealias JGAssetType = JGImage

internal struct JGImage {
  internal fileprivate(set) var name: String

  internal var image: Image? {
    let bundle = Bundle(for: BundleToken.self)
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(OSX)
    let image = bundle.image(forResource: NSImage.Name(name))
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else { return nil /*fatalError("Unable to load image named \(name).")*/ }
    return result
  }
}

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
internal enum JGAsset {
  internal enum Cartoon {
    internal static let cartoon012 = JGImage(name: "cartoon01-2")
    internal static let cartoon01 = JGImage(name: "cartoon01")
    internal static let cartoon02 = JGImage(name: "cartoon02")
    internal static let cartoon03 = JGImage(name: "cartoon03")
    internal static let cartoon04 = JGImage(name: "cartoon04")
    internal static let cartoon05 = JGImage(name: "cartoon05")
    internal static let cartoon06 = JGImage(name: "cartoon06")
    internal static let cartoon07 = JGImage(name: "cartoon07")
    internal static let cartoon08 = JGImage(name: "cartoon08")
    internal static let nextpage = JGImage(name: "nextpage")
    internal static let splash = JGImage(name: "splash")
  }
  internal enum Finder {
    internal static let finder01 = JGImage(name: "finder_01")
    internal static let finder02 = JGImage(name: "finder_02")
    internal static let finder03 = JGImage(name: "finder_03")
    internal static let finder04 = JGImage(name: "finder_04")
    internal static let finder05 = JGImage(name: "finder_05")
    internal static let finder06 = JGImage(name: "finder_06")
    internal static let finder07 = JGImage(name: "finder_07")
    internal static let finder08 = JGImage(name: "finder_08")
  }
  internal enum Icons {
    internal static let archon = JGImage(name: "archon")
    internal static let btInfo32X32 = JGImage(name: "btInfo32X32")
    internal static let cancelBtn = JGImage(name: "cancel_btn")
    internal static let currentLetter = JGImage(name: "current_letter")
    internal static let findLetterBtn = JGImage(name: "find_letter_btn")
    internal static let icLock20X20 = JGImage(name: "icLock20X20")
    internal static let imMenuLeft104X46 = JGImage(name: "imMenuLeft104X46")
    internal static let imMenuRight104X46 = JGImage(name: "imMenuRight104X46")
    internal static let jgBtn = JGImage(name: "jg_btn")
    internal static let mainArchon = JGImage(name: "main_archon")
    internal static let phoneBook = JGImage(name: "phone_book")
    internal static let saveLetterBtn = JGImage(name: "save_letter_btn")
    internal static let skip = JGImage(name: "skip")
  }
  internal enum Letters {
    internal static let appName = JGImage(name: "app_name")
  }

  // swiftlint:disable trailing_comma
  internal static let allImages: [JGImage] = [
    Cartoon.cartoon012,
    Cartoon.cartoon01,
    Cartoon.cartoon02,
    Cartoon.cartoon03,
    Cartoon.cartoon04,
    Cartoon.cartoon05,
    Cartoon.cartoon06,
    Cartoon.cartoon07,
    Cartoon.cartoon08,
    Cartoon.nextpage,
    Cartoon.splash,
    Finder.finder01,
    Finder.finder02,
    Finder.finder03,
    Finder.finder04,
    Finder.finder05,
    Finder.finder06,
    Finder.finder07,
    Finder.finder08,
    Icons.archon,
    Icons.btInfo32X32,
    Icons.cancelBtn,
    Icons.currentLetter,
    Icons.findLetterBtn,
    Icons.icLock20X20,
    Icons.imMenuLeft104X46,
    Icons.imMenuRight104X46,
    Icons.jgBtn,
    Icons.mainArchon,
    Icons.phoneBook,
    Icons.saveLetterBtn,
    Icons.skip,
    Letters.appName,
  ]
  // swiftlint:enable trailing_comma
  @available(*, deprecated, renamed: "allImages")
  internal static let allValues: [JGAssetType] = allImages
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

internal extension Image {
  @available(iOS 1.0, tvOS 1.0, watchOS 1.0, *)
  @available(OSX, deprecated,
    message: "This initializer is unsafe on macOS, please use the JGImage.image property")
  convenience init!(asset: JGImage) {
    #if os(iOS) || os(tvOS)
    let bundle = Bundle(for: BundleToken.self)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(OSX)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

private final class BundleToken {}
