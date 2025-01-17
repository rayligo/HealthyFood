//
//  NoteBookView.swift
//  HealthyFood
//
//  Created by Li Yiu Yeung  on 17/1/2025.
//


import Foundation
import SwiftUI

struct NoteBookView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Device.timestamp, ascending: true)],
        animation: .default)
    private var devices: FetchedResults<Device>

    @State var showingSheet: Bool = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(devices) { device in
                    NavigationLink {
                        DetalView(device: device)
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
        }.sheet(isPresented: $showingSheet, content: {
            AddDeviceView(showingSheet: $showingSheet)
        })
    }

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
