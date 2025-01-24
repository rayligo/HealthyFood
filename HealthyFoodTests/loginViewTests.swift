//
//  loginViewTests.swift
//  HealthyFoodTests
//
//  Created by Li Yiu Yeung  on 24/1/2025.
//

import Foundation
import XCTest
import SwiftUI
@testable import HealthyFood

class SignInViewModelTests: XCTestCase {
    
    
    func testLoginFailed() {
        let viewModel = SignInViewModel()
        let expectation = self.expectation(description: "Login failed")
        
        viewModel.signIn(email: "test@gmail.com", password: "wrongpassword")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { // Assuming network delay
            XCTAssertNotNil(viewModel.errorMessage, "Login should fail, but no error message was received.")
            XCTAssertNil(viewModel.user, "User should not be signed in, but user object is not nil.")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
}
