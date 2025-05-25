import SwiftUI

// MARK: - Form Field Model
struct FormField {
    var text: String
    var error: String?
    var isSecure: Bool
    var contentType: UITextContentType
    var keyboardType: UIKeyboardType
} 