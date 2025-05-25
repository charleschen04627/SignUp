import SwiftUI

// MARK: - Form Field View
struct FormFieldView: View {
    let title: String
    @Binding var field: FormField
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.system(size: 15, weight: .bold))
                .foregroundColor(.white)
            
            if let error = field.error {
                Text(error)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(.red)
            }
            
            Group {
                if field.isSecure {
                    SecureField(title, text: $field.text)
                } else {
                    TextField(title, text: $field.text)
                }
            }
            .textFieldStyle(.roundedBorder)
            .textContentType(field.contentType)
            .keyboardType(field.keyboardType)
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled()
        }
    }
} 