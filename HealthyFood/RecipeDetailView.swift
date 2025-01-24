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
                //Show Recipe Image
                if let uiImage = recipe.imageFromBase64() {
                    Image(uiImage: uiImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 300)
                }
                // show Section for materials
                Text("Material")
                    .font(.title)
                    .padding(.top)
                Text(recipe.Material)
                    .font(.title2)
                    .padding(.top)
                //Display the steps part
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
