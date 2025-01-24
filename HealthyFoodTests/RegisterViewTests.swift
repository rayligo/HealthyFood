//
//  HealthyFoodTests.swift
//  HealthyFoodTests
//
//  Created by Li Yiu Yeung  on 24/1/2025.
//
import XCTest
import SwiftUI
@testable import HealthyFood
import FirebaseAuth


class RegisterViewTests: XCTestCase {


    
    func testPasswordMismatch() {
        let viewModel = RegisterViewModel()
        viewModel.register(email: "test@example.com", password: "password123", confirmPassword: "password124")
        
        XCTAssertEqual(viewModel.errorMessage, "Passwords do not match.", "Passwords do not match, but no error message was received.")
        XCTAssertNil(viewModel.user, "User should not be registered, but user object is not nil.")
    }
}
