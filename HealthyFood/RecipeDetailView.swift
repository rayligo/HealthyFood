//
//  RecipeDetailView.swift
//  HealthyFood
//
//  Created by Li Yiu Yeung  on 24/1/2025.
//

import Foundation
import SwiftUI


struct RecipeDetailView: View {
    var recipe: Recipes
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                if let uiImage = recipe.imageFromBase64() {
                    Image(uiImage: uiImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 300)
                }
                Text("Material")
                    .font(.title)
                    .padding(.top)
                Text(recipe.Material)
                    .font(.title2)
                    .padding(.top)
                Text("Practice")
                    .font(.title)
                    .padding(.top)
                Text(recipe.Practice)
                    .font(.title2)
                    .padding(.top)
            }
            .padding()
        }
        .navigationTitle(recipe.Name)
    }
}
