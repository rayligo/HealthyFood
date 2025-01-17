//
//  registerView.swift
//  HealthyFood
//
//  Created by Li Yiu Yeung  on 17/1/2025.
//

import Foundation
import SwiftUI

struct RegistrationView: View {
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isRegistered: Bool = false

    var body: some View {
        VStack {
            TextField("Name", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Register") {
                // Add your registration logic here
                if !name.isEmpty && !email.isEmpty && !password.isEmpty {
                    // Registration logic can be added here
                    isRegistered = true
                }
            }
            .padding()
            .foregroundColor(.white)
            .background(Color.green)
            .cornerRadius(8)
            .padding()

            if isRegistered {
                Text("Registration Successful!")
            }
        }.padding()
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
