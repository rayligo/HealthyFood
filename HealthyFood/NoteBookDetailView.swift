//
//  DetailView.swift
//  HealthyFood
//
//  Created by Li Yiu Yeung  on 17/1/2025.
//

import Foundation
import SwiftUI

struct NoteBookDetailView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
    
    var device: Device
    
    @State var title: String = ""
    @State var content: String = ""
    
    // Save changes and return
    fileprivate func saveAndBack() {
        device.title = title
        device.content = content
        device.timestamp = Date()
        
        try? viewContext.save()
        self.presentationMode.wrappedValue.dismiss()
    }
    
    var body: some View {
        VStack {
            // Header text
            Text("Edit Notebook").padding()
            // TextField for title
            TextField("Title", text: $title)
                .padding()
            // TextField for content
            TextField("Content", text: $content)
                .padding()
            // Save button
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
            // Initialize the text fields with the device's current data
            title = device.title ?? ""
            content = device.content ?? ""
        }
        .navigationBarBackButtonHidden(true)
        .navigationViewStyle(StackNavigationViewStyle()) // Apply navigation style
    }
}
