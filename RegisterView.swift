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
    
    func register(email: String, password: String, confirmPassword: String) {
        guard password == confirmPassword else {
            self.errorMessage = "Passwords do not match."
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            if let error = error {
                self?.errorMessage = error.localizedDescription
                return
            }
            self?.user = result?.user
        }
    }
}

struct RegisterView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @StateObject private var viewModel = RegisterViewModel()
    @State private var isNavigatingToHomeView = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Register")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 20)
                
                Text("Create a new account")
                    .font(.title)
                    .fontWeight(.semibold)
                
                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                SecureField("Confirm Password", text: $confirmPassword)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button("Register") {
                    viewModel.register(email: email, password: password, confirmPassword: confirmPassword)
                }
                .padding()
                .foregroundColor(.white)
                .background(Color.green)
                .cornerRadius(8)
                .padding()
                
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                }
                
                if viewModel.user != nil {
                    Text("Registration Successful!")
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
    }
}


struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
