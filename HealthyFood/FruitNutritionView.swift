//
//  FruitNutritionView.swift
//  HealthyFood
//
//  Created by Li Yiu Yeung  on 21/1/2025.
//

import SwiftUI

struct FruitNutritionView: View {
    var fruit: String
    
    var body: some View {
        NavigationView {
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: [GridItem(.fixed(200))]) {
                    if shouldShowFruit(fruit, target: "apple") {
                        FruitRow(
                            fruit: "Apple",
                            nutrition: """
                            Rich in dietary fiber and vitamin C, supports heart health
                            Calories: 52 kcal
                            Carbohydrates: 14 gm
                            Sugars: 10 gm
                            Dietary Fiber: 2.4 gm
                            Proteins: 0.3 gm
                            """)
                    }
                    if shouldShowFruit(fruit, target: "watermelon") {
                        FruitRow(
                            fruit: "Watermelon",
                            nutrition: """
                            High in Vitamin C, very hydrating
                            Calories: 30 kcal
                            Carbohydrates: 8 gm
                            Sugars: 6 gm
                            Dietary Fiber: 0.4 gm
                            Proteins: 0.6 gm
                            """)
                    }
                    if shouldShowFruit(fruit, target: "pomegranate") {
                        FruitRow(
                            fruit: "Pomegranate",
                            nutrition: """
                            Rich in antioxidants, vitamins C and K
                            Calories: 83 kcal
                            Carbohydrates: 19 gm
                            Sugars: 14 gm
                            Dietary Fiber: 3.4 gm
                            Proteins: 1.7 gm
                            """)
                    }
                    if shouldShowFruit(fruit, target: "pineapple") {
                        FruitRow(
                            fruit: "Pineapple",
                            nutrition: """
                            Contains bromelain, vitamins C and B6
                            Calories: 50 kcal
                            Carbohydrates: 13 gm
                            Sugars: 10 gm
                            Dietary Fiber: 1.4 gm
                            Proteins: 0.5 gm
                            """)
                    }
                    if shouldShowFruit(fruit, target: "pear") {
                        FruitRow(
                            fruit: "Pear",
                            nutrition: """
                            Good source of dietary fiber, vitamins C and K
                            Calories: 57 kcal
                            Carbohydrates: 15 gm
                            Sugars: 10 gm
                            Dietary Fiber: 3.1 gm
                            Proteins: 0.4 gm
                            """)
                    }
                    if shouldShowFruit(fruit, target: "orange") {
                        FruitRow(
                            fruit: "Orange",
                            nutrition: """
                            High in Vitamin C, promotes healthy immune function
                            Calories: 47 kcal
                            Carbohydrates: 12 gm
                            Sugars: 9 gm
                            Dietary Fiber: 2.4 gm
                            Proteins: 0.9 gm
                            """)
                    }
                    if shouldShowFruit(fruit, target: "mango") {
                        FruitRow(
                            fruit: "Mango",
                            nutrition: """
                            Rich in Vitamin A and Vitamin C, supports eye health
                            Calories: 60 kcal
                            Carbohydrates: 15 gm
                            Sugars: 13 gm
                            Dietary Fiber: 1.6 gm
                            Proteins: 0.8 gm
                            """)
                    }
                    if shouldShowFruit(fruit, target: "kiwi") {
                        FruitRow(
                            fruit: "Kiwi",
                            nutrition: """
                            Packed with Vitamin C and Vitamin K
                            Calories: 42 kcal
                            Carbohydrates: 10 gm
                            Sugars: 6 gm
                            Dietary Fiber: 2.1 gm
                            Proteins: 0.8 gm
                            """)
                    }
                    if shouldShowFruit(fruit, target: "grapes") {
                        FruitRow(
                            fruit: "Grapes",
                            nutrition: """
                            Good source of vitamins C and K, contains antioxidants
                            Calories: 69 kcal
                            Carbohydrates: 18 gm
                            Sugars: 16 gm
                            Dietary Fiber: 0.9 gm
                            Proteins: 0.7 gm
                            """)
                    }
                    if shouldShowFruit(fruit, target: "banana") {
                        FruitRow(
                            fruit: "Banana",
                            nutrition: """
                            High in potassium, beneficial for heart health
                            Calories: 89 kcal
                            Carbohydrates: 23 gm
                            Sugars: 12 gm
                            Dietary Fiber: 2.6 gm
                            Proteins: 1.1 gm
                            """)
                    }
                }
            }
            .navigationTitle("Fruit Nutrition")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }

    func shouldShowFruit(_ fruit: String, target: String) -> Bool {
        return fruit == target
    }
}

struct FruitRow: View {
    var fruit: String
    var nutrition: String

    var body: some View {
        VStack(alignment: .leading) {
            Text(fruit)
                .font(.headline)
            Text(nutrition)
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding()
    }
}

struct FruitNutritionView_Previews: PreviewProvider {
    static var previews: some View {
        FruitNutritionView(fruit: "apple")
    }
}
 
