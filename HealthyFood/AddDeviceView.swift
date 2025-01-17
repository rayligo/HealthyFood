//
//  AddDeviceView.swift
//  HealthyFood
//
//  Created by Li Yiu Yeung  on 17/1/2025.
//

import Foundation
import SwiftUI

struct AddDeviceView : View {
    @Environment(\.managedObjectContext) private var viewContext
    @Binding var showingSheet : Bool
    
    @State var title : String = ""
    @State var content : String = ""
    
    var body: some View {
        VStack {
            
            Text("Create a new notebook").padding()
            
            TextField("Title", text: $title)
                .padding()
            TextField("Content", text: $content)
                .padding()

            
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
        
        
    }
    
    
    fileprivate func createDevice() {
        let device = Device(context: viewContext)
        device.title = title
        device.content = content
        device.timestamp = Date()
        
        try? viewContext.save()
        
        self.title = ""
        self.content = ""

        showingSheet = false
    }
}
