// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "ColorAsset.Color", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetColorTypeAlias = ColorAsset.Color
@available(*, deprecated, renamed: "ImageAsset.Image", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetImageTypeAlias = ImageAsset.Image

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
internal enum Asset {
  internal enum Assets {
    internal static let icnLaunch = ImageAsset(name: "icn_launch")
  }
  internal enum ColorsAssets {
    internal static let descriptionColor = ColorAsset(name: "descriptionColor")
    internal static let primaryColor = ColorAsset(name: "primaryColor")
    internal static let titleColor = ColorAsset(name: "titleColor")
    internal static let viewBackgroundColor = ColorAsset(name: "viewBackgroundColor")
  }
  internal enum Icons {
    internal static let iconArrowBack = ImageAsset(name: "icon_arrow_back")
    internal static let iconsAppleMaps = ImageAsset(name: "icons-apple-maps")
    internal static let illnessHurtAlotmore4 = ImageAsset(name: "illnessHurtAlotmore_4")
    internal static let illnessHurtEvenMore3 = ImageAsset(name: "illnessHurtEvenMore_3")
    internal static let illnessHurtLittle1 = ImageAsset(name: "illnessHurt_little_1")
    internal static let illnessHurtMore2 = ImageAsset(name: "illnessHurt_more_2")
    internal static let illnessHurtWorst5 = ImageAsset(name: "illnessHurt_worst5")
    internal static let illnessNoPain0 = ImageAsset(name: "illnessNoPain_0")
    internal static let flag = ImageAsset(name: "Flag")
    internal static let map = ImageAsset(name: "Map")
    internal static let monument = ImageAsset(name: "Monument")
    internal static let mural = ImageAsset(name: "Mural")
    internal static let plaque = ImageAsset(name: "Plaque")
    internal static let sculpture = ImageAsset(name: "Sculpture")
    internal static let placeholder = ImageAsset(name: "placeholder")
  }
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

internal final class ColorAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Color = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Color = UIColor
  #endif

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  internal private(set) lazy var color: Color = Color(asset: self)

  fileprivate init(name: String) {
    self.name = name
  }
}

internal extension ColorAsset.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  convenience init!(asset: ColorAsset) {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

internal struct ImageAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Image = UIImage
  #endif

  internal var image: Image {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let image = bundle.image(forResource: NSImage.Name(name))
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image named \(name).")
    }
    return result
  }
}

internal extension ImageAsset.Image {
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init!(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
    let bundle = BundleToken.bundle
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    Bundle(for: BundleToken.self)
  }()
}
// swiftlint:enable convenience_type
