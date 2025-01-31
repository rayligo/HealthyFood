//
//  AddDeviceView.swift
//  HealthyFood
//
//  Created by Li Yiu Yeung  on 17/1/2025.
//

import Foundation
import SwiftUI

struct NoteBookAddDetailView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Binding var showingSheet: Bool
    
    @State var title: String = ""
    @State var content: String = ""
    
    var body: some View {
        VStack {
            // Header text
            Text("Create a new notebook").padding()
            // TextField for title
            TextField("Title", text: $title)
                .padding()
            // TextField for content
            TextField("Content", text: $content)
                .padding()
            // Save and Cancel buttons
            HStack {
                Button(action: {
                    createDevice()
                }, label: {
                    Text("Save")
                })
                
                Button(action: {
                    showingSheet = false
                }, label: {
                    Text("Cancel")
                })
            }
            Spacer()
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    // Create a new device and save it
    fileprivate func createDevice() {
        let device = Device(context: viewContext)
        device.title = title
        device.content = content
        device.timestamp = Date()
        
        try? viewContext.save()
        
        // Clear the fields and close the sheet
        self.title = ""
        self.content = ""
        showingSheet = false
    }
}
