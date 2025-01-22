//
//  RegisterView.swift
//  HealthyFood
//
//  Created by Li Yiu Yeung  on 17/1/2025.
//


import Foundation
import SwiftUI
import FirebaseAuth

class RegisterViewModel: ObservableObject {
    @Published var user: User?
    @Published var errorMessage: String?
    @Published var isLoading = false
    
    func register(email: String, password: String, confirmPassword: String) {
        guard password == confirmPassword else {
            self.errorMessage = "Passwords do not match."
            return
        }

        isLoading = true
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            self?.isLoading = false
            if let error = error {
                self?.errorMessage = error.localizedDescription
                return
            }
            self?.user = result?.user
        }
    }
}

struct RegisterView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @StateObject private var viewModel = RegisterViewModel()
    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    var body: some View {
        NavigationView {
            VStack {
                Text("Create a new account")
                    .font(.title)
                    .fontWeight(.semibold)
                
                if horizontalSizeClass == .compact {
                    verticalLayout
                } else {
                    horizontalLayout
                }
                
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(Color.red)
                }
                
                if viewModel.user != nil {
                    Text("Registration successful!")
                }

                if viewModel.isLoading {
                    ProgressView("Registering...")
                        .padding()
                }
            }
            .padding()
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    var verticalLayout: some View {
        VStack {
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .keyboardType(.emailAddress)
                .onChange(of: email) { newValue in
                    print("Email changed to: \(newValue)")
                }

            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .onChange(of: password) { newValue in
                    print("Password changed to: \(newValue)")
                }
            
            SecureField("Confirm Password", text: $confirmPassword)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .onChange(of: confirmPassword) { newValue in
                    print("Confirm Password changed to: \(newValue)")
                }
            
            Button("Register") {
                viewModel.register(email: email, password: password, confirmPassword: confirmPassword)
            }
            .padding()
            .foregroundColor(.white)
            .background(viewModel.isLoading ? Color.gray : Color.green)
            .cornerRadius(8)
            .padding()
            .disabled(viewModel.isLoading)
        }
    }
    
    var horizontalLayout: some View {
        HStack {
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .keyboardType(.emailAddress)
                .onChange(of: email) { newValue in
                    print("Email changed to: \(newValue)")
                }

            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .onChange(of: password) { newValue in
                    print("Password changed to: \(newValue)")
                }
            
            SecureField("Confirm Password", text: $confirmPassword)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .onChange(of: confirmPassword) { newValue in
                    print("Confirm Password changed to: \(newValue)")
                }

            if viewModel.isLoading {
                ProgressView()
            } else {
                Button("Register") {
                    viewModel.register(email: email, password: password, confirmPassword: confirmPassword)
                }
                .padding()
                .foregroundColor(.white)
                .background(Color.green)
                .cornerRadius(8)
                .padding()
                .disabled(viewModel.isLoading)
            }
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
