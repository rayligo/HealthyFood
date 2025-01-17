//
//  ContentView.swift
//  HealthyFood
//
//  Created by Li Yiu Yeung  on 17/1/2025.
//

import SwiftUI
struct ContentView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isLoggedIn: Bool = false

    var body: some View {
        VStack {
            TextField("Username", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Login") {
                // Add your logic for validating the username and password here
                if username == "exampleUser" && password == "examplePassword" {
                    isLoggedIn = true
                }
            }
            .padding()
            .foregroundColor(.white)
            .background(Color.blue)
            .cornerRadius(8)
            .padding()

            if isLoggedIn {
                Text("Login Successful!")
            }
        }
        .padding()
    }
}
#Preview {
    ContentView()
}
