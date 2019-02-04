// swiftlint:disable all
// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
internal enum L10n {
  /// Author
  internal static let author = L10n.tr("Localizable", "Author")
  /// Body
  internal static let body = L10n.tr("Localizable", "Body")
  /// Comments
  internal static let comments = L10n.tr("Localizable", "Comments")
  /// Details
  internal static let detailsScreenName = L10n.tr("Localizable", "DetailsScreenName")
  /// Error
  internal static let error = L10n.tr("Localizable", "Error")
  /// Posts
  internal static let postsScreenName = L10n.tr("Localizable", "PostsScreenName")
  /// Retry
  internal static let retry = L10n.tr("Localizable", "Retry")
  /// Title
  internal static let title = L10n.tr("Localizable", "Title")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
