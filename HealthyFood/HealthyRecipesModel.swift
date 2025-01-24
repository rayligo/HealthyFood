//
//  HealthyRecipesMode.swift
//  HealthyFood
//
//  Created by Li Yiu Yeung  on 23/1/2025.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseFirestore
import PhotosUI

//Recipe structure
struct Recipes: Identifiable {
    var id: String
    var Image: String
    var Material: String
    var Name: String
    var Practice: String
    
    //Convert base64 to Image
    func imageFromBase64() -> UIImage? {
        guard let data = Data(base64Encoded: Image, options: .ignoreUnknownCharacters) else { return nil }
        return UIImage(data: data)
    }
}

class ViewModel: ObservableObject {
    @Published var list = [Recipes]()
    @Published var isLoading = true
    
    //Adding a new recipe to Firestore
    func addDate(name: String, image: UIImage, material: String, practice: String) {
        let imageData = image.jpegData(compressionQuality: 0.8)?.base64EncodedString() ?? ""
        let db = Firestore.firestore()
        
        db.collection("Healthy Recipes").getDocuments { snapshot, error in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                if let snapshot = snapshot {
                    let uploadID = snapshot.documents.count + 1
                    db.collection("Healthy Recipes").document("\(uploadID)").setData([
                        "Name": name,
                        "Image": imageData,
                        "Material": material,
                        "Practice": practice
                    ]) { error in
                        if let error = error {
                            print("Error adding document: \(error)")
                        } else {
                            self.getData()
                        }
                    }
                }
            }
        }
    }
    // Get recipe data from Firestore
    func getData() {
        let db = Firestore.firestore()
        db.collection("Healthy Recipes").getDocuments { snapshot, error in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                if let snapshot = snapshot {
                    self.list = snapshot.documents.map { d in
                        return Recipes(
                            id: d.documentID,
                            Image: d["Image"] as? String ?? "",
                            Material: (d["Material"] as? String ?? "").replacingOccurrences(of: "\\n", with: "\n"),
                            Name: d["Name"] as? String ?? "",
                            Practice: (d["Practice"] as? String ?? "").replacingOccurrences(of: "\\n", with: "\n")
                        )
                    }
                }
            }
            self.isLoading = false
        }
    }
}
