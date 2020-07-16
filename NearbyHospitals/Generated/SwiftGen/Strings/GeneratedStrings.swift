// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
internal enum L10n {
  internal enum About {
    /// Here you'll find implementations of popular algorithms and data structures in everyone's favorite new language Swift, with detailed explanations of how they work.\n\nIf you're a computer science student who needs to learn this stuff for exams -- or if you're a self-taught programmer who wants to brush up on the theory behind your craft -- you've come to the right place!\n\nThe goal of this project is to explain how algorithms work. The focus is on clarity and readability of the code, not on making a reusable library that you can drop into your own projects. That said, most of the code should be ready for production use but you may need to tweak it to fit into your own codebase.\n\nCode is compatible with Xcode 9 and Swift 4. We'll keep this updated with the latest version of Swift.\n\nSuggestions and contributions are welcome! 😍
    internal static let aboutDescription = L10n.tr("About", "ABOUT_DESCRIPTION")
    /// Welcome to the Algorithms & Data Structures!
    internal static let aboutTitle = L10n.tr("About", "ABOUT_TITLE")
  }
  internal enum DiseaseList {
    /// Disease List
    internal static let navigationTitle = L10n.tr("DiseaseList", "NAVIGATION_TITLE")
    /// Select an illness:
    internal static let tableViewTitle = L10n.tr("DiseaseList", "TABLE_VIEW_TITLE")
  }
  internal enum HospitaList {
    /// Waiting time %@
    internal static func averageTime(_ p1: Any) -> String {
      return L10n.tr("HospitaList", "AVERAGE_TIME", String(describing: p1))
    }
    /// Hospital List
    internal static let navigationTitle = L10n.tr("HospitaList", "NAVIGATION_TITLE")
    /// Our suggested Hospitals:
    internal static let tableViewTitle = L10n.tr("HospitaList", "TABLE_VIEW_TITLE")
    /// Waiting time: 
    internal static let waitingTime = L10n.tr("HospitaList", "WAITING_TIME")
  }
  internal enum SeverityLevel {
    /// Withing Parasite
    internal static let collectionviewViewTitle = L10n.tr("SeverityLevel", "COLLECTIONVIEW_VIEW_TITLE")
    /// Select severity level
    internal static let navigationTitle = L10n.tr("SeverityLevel", "NAVIGATION_TITLE")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    Bundle(for: BundleToken.self)
  }()
}
// swiftlint:enable convenience_type
