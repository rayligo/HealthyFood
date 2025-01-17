//
//  LoginView.swift
//  HealthyFood
//
//  Created by Li Yiu Yeung  on 17/1/2025.
//
//
import Foundation
import SwiftUI
import FirebaseAuth

class SignInViewModel: ObservableObject {
    @Published var user: User?
    @Published var errorMessage: String?
    @Published var isLoading = false
    
    func signIn(email: String, password: String) {
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Please fill in all fields."
            return
        }
        
        isLoading = true
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            self?.isLoading = false
            if let error = error {
                self?.errorMessage = error.localizedDescription
                return
            }
            self?.user = result?.user
        }
    }
}

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @StateObject private var viewModel = SignInViewModel()
    @State private var isNavigatingToHomeView = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Login with email")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                
                if viewModel.isLoading {
                    ProgressView()
                } else {
                    Button("Login") {
                        viewModel.signIn(email: email, password: password)
                    }
                    .buttonStyle(.borderedProminent)
                }
                
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(Color.red)
                }
                Text("Don't have an account?")
                NavigationLink(destination: RegisterView()) {
                    Text("Register here")
                        .foregroundColor(.blue)
                }
            }
            .padding()
            .onReceive(viewModel.$user) { user in
                if user != nil {
                    isNavigatingToHomeView = true
                }
            }
            .navigationDestination(isPresented: $isNavigatingToHomeView) {
                HomeView()
                    .navigationBarBackButtonHidden(true)  
            }
        }
        .onTapGesture {
            hideKeyboard()
        }
    }
}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
