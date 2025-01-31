//
//  NoteBookView.swift
//  HealthyFood
//
//  Created by Li Yiu Yeung  on 17/1/2025.
//



import Foundation
import SwiftUI
import LocalAuthentication

struct NoteBookView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Device.timestamp, ascending: true)],
        animation: .default)
    private var devices: FetchedResults<Device>
    
    @State var showingSheet: Bool = false
    @State private var isUnlocked = false
    
    var body: some View {
        if isUnlocked {
            NavigationView {
                List {
                    ForEach(devices) { device in
                        NavigationLink {
                            NoteBookDetailView(device: device)
                            // Apply navigation style to destination view
                                .navigationViewStyle(StackNavigationViewStyle())
                        } label: {
                            Text("\(device.title ?? "Unknown Title")")
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
                .toolbar {
                    ToolbarItem {
                        Button(action: {
                            showingSheet = true
                        }) {
                            Label("Add Item", systemImage: "plus")
                        }
                    }
                }
            }
            .sheet(isPresented: $showingSheet, content: {
                NoteBookAddDetailView(showingSheet: $showingSheet)
                // Apply navigation style to sheet view
                    .navigationViewStyle(StackNavigationViewStyle())
            })
            // Apply navigation style to main NavigationView
            .navigationViewStyle(StackNavigationViewStyle())
        } else {
            VStack {
                Text("Please authenticate to view your notebooks.")
                //Button to start authentication
                Button(action: authenticate) {
                    Text("Authenticate")
                        .font(.headline)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            // Apply authentication view
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
    //Authenticate User
    private func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Authenticate to view your notebooks."
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        self.isUnlocked = true
                    } else {
                        
                    }
                }
            }
        } else {
           
        }
    }
    //add a new device
    private func addItem() {
        withAnimation {
            let newItem = Device(context: viewContext)
            newItem.timestamp = Date()
            newItem.title = "New Device"
            newItem.content = "Device Content"

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    //delete selected devices
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { devices[$0] }.forEach(viewContext.delete)
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct NoteBookView_Previews: PreviewProvider {
    static var previews: some View {
        let persistenceController = PersistenceController.shared
        NoteBookView()
            .environment(\.managedObjectContext, persistenceController.container.viewContext)
    }
}
