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
    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    var body: some View {
        NavigationView {
            VStack {
                Text("HealthyFood")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                if horizontalSizeClass == .compact {
                    verticalLayout
                } else {
                    horizontalLayout
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
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .navigationBarItems(trailing: EmptyView())
            .background(
                NavigationLink(
                    destination: HomeView().navigationBarBackButtonHidden(true),
                    isActive: $isNavigatingToHomeView,
                    label: { EmptyView() }
                )
            )
            .onReceive(viewModel.$user) { user in
                if user != nil {
                    isNavigatingToHomeView = true
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    var verticalLayout: some View {
        VStack {
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
        }
    }
    
    var horizontalLayout: some View {
        HStack {
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
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
