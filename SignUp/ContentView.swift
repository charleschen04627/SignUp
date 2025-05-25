//
//  ContentView.swift
//  SignUp
//
//  Created by Charles on 25/05/2025.
//

import SwiftUI

// MARK: - Form Field Model
struct FormField {
    var text: String
    var error: String?
    var isSecure: Bool
    var contentType: UITextContentType
    var keyboardType: UIKeyboardType
}

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

// MARK: - Content View
struct ContentView: View {
    @State private var username = FormField(
        text: "",
        error: nil,
        isSecure: false,
        contentType: .username,
        keyboardType: .default
    )
    
    @State private var email = FormField(
        text: "",
        error: nil,
        isSecure: false,
        contentType: .emailAddress,
        keyboardType: .emailAddress
    )
    
    @State private var password = FormField(
        text: "",
        error: nil,
        isSecure: true,
        contentType: .password,
        keyboardType: .default
    )
    
    @State private var showAlert = false
    
    var body: some View {
        ZStack {
            Color.primaryTheme
                .ignoresSafeArea()
            VStack(alignment: .leading, spacing: 20) {
                Text("Sign up")
                    .font(.system(size: 32, weight: .heavy))
                    .foregroundColor(.white)
                FormFieldView(title: "Username", field: $username)
                FormFieldView(title: "Email", field: $email)
                FormFieldView(title: "Password", field: $password)
                submitButton
                Spacer()
            }
            .padding(.horizontal)
        }
        .alert("Success", isPresented: $showAlert) {
            Button("OK") {
                resetForm()
            }
        } message: {
            Text("Welcome to SwiftUI, \(username.text)!")
        }
    }
    
    private var submitButton: some View {
        Button {
            checkSubmitLogic()
        } label: {
            Text("Submit")
                .foregroundStyle(.white)
                .font(.system(size: 15, weight: .bold))
                .frame(maxWidth: .infinity)
                .frame(height: 50)
        }
        .background(Color.black)
        .clipShape(Capsule())
        .padding(.top)
    }
    
    private func checkSubmitLogic() {
        // Reset all errors
        username.error = nil
        email.error = nil
        password.error = nil
        
        // Validate username
        if username.text.isEmpty {
            username.error = "Username is required"
            return
        }
        
        // Validate email
        if email.text.isEmpty {
            email.error = "Email is required"
            return
        }
        
        if !isValidEmail(email.text) {
            email.error = "Invalid email format"
            return
        }
        
        // Validate password
        if password.text.isEmpty {
            password.error = "Password is required"
            return
        }
        
        if password.text.count < 6 {
            password.error = "Password must be at least 6 characters"
            return
        }
        
        // Show success alert
        showAlert = true
    }
    
    private func resetForm() {
        username.text = ""
        email.text = ""
        password.text = ""
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}

#Preview {
    ContentView()
}
