//
//  DetailView.swift
//  HealthyFood
//
//  Created by Li Yiu Yeung  on 17/1/2025.
//

import Foundation
import SwiftUI

struct DetalView : View {
        
        @Environment(\.managedObjectContext) private var viewContext
        @Environment(\.presentationMode) var presentationMode
        
        var device : Device
        
        @State var title : String = ""
        @State var content : String = ""
        
        fileprivate func saveAndBack() {
            device.title = title
            device.content = content
            device.timestamp = Date()
            
            try? viewContext.save()
            self.presentationMode.wrappedValue.dismiss()
        }
        
        var body: some View {
            VStack {
                Text("Create a new Device").padding()
                
                TextField("Title", text: $title)
                    .padding()
                TextField("Content", text: $content)
                    .padding()
                
                HStack {
                    Button(action: {
                        saveAndBack()
                    }, label: {
                        Text("Save")
                    })
                }
                Spacer()
            }
            .onAppear {
                title = device.title ?? ""
                content = device.content ?? ""
            }
            .navigationBarBackButtonHidden(true)
        }
    }


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
