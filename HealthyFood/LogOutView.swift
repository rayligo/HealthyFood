//
//  LogOutView.swift
//  HealthyFood
//
//  Created by Li Yiu Yeung  on 22/1/2025.
//

import Foundation
import SwiftUI
import FirebaseAuth
import Firebase

struct LogOutView: View {
    @Binding var isLoggedOut: Bool

    var body: some View {
        VStack {
            Text("Are you sure you want to logout?")
                .font(.headline)
                .padding()
            
            Button(action: {
                handleLogout()
            }) {
                Text("Logout")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.red)
                    .cornerRadius(8)
            }
            .padding()

        }
    }
//logout Function
    func handleLogout() {
        do {
            try Auth.auth().signOut()
            isLoggedOut = true
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
}

struct LogOutView_Previews: PreviewProvider {
    static var previews: some View {
        LogOutView(isLoggedOut: .constant(false))
    }
}
