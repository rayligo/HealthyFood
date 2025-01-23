//
//  HomeView.swift
//  HealthyFood
//
//  Created by Li Yiu Yeung  on 17/1/2025.
//

import SwiftUI
import FirebaseAuth

struct HomeView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject private var HomedataViewModel = ViewModel()
    
    @State private var isLoggedOut = false
    @State private var isNavigatingToLogin = false

    var body: some View {
        Group {
            if isLoggedOut {
                NavigationLink(
                    destination: LoginView(isLoggedOut: $isLoggedOut),
                    isActive: $isNavigatingToLogin,
                    label: { EmptyView() }
                ).hidden()
            } else {
                TabView {
                    NavigationView {
                        VStack(spacing: 20) {
                            if HomedataViewModel.isLoading {
                                ProgressView()
                            } else {
                                List(HomedataViewModel.list) { item in
                                    NavigationLink(destination: RecipeDetailView(recipe: item)) {
                                        HStack {
                                            if let uiImage = item.imageFromBase64() {
                                                Image(uiImage: uiImage)
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(height: 100)
                                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                            }
                                            VStack(alignment: .leading) {
                                                Text(item.id + "." + item.Name)
                                                    .font(.headline)
                                                    .padding(.bottom, 2)
                                                
                                                
                                            }
                                            .padding()
                                        }
                                    }
                                }
                            }
                        }
                        .onAppear {
                            HomedataViewModel.getData()
                        }
                        .toolbar {
                            ToolbarItem(placement: .principal) {
                                HStack {
                                    Text("Healthy Recipes")
                                        .font(.largeTitle)
                                    Spacer()
                                    NavigationLink(destination: UploadHealthyRecipesView()) {
                                        Image("addButton")
                                            .resizable()
                                            .frame(width: 40, height: 40)
                                            .background(Color.white)
                                            .cornerRadius(5)
                                    }
                                }
                            }
                        }
                    }
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("Home")
                    }
                    
                    NavigationView {
                        MapView()
                            .navigationBarTitle("Map")
                            .navigationBarBackButtonHidden(true)
                    }
                    .tabItem {
                        Image(systemName: "map.fill")
                        Text("Map")
                    }
                    
                    NavigationView {
                        AIFruitClassificationView()
                            .navigationBarTitle("Fruit Classification")
                            .navigationBarBackButtonHidden(true)
                    }
                    .tabItem {
                        Image(systemName: "camera.fill")
                        Text("Classify")
                    }
                    
                    NavigationView {
                        NoteBookView()
                            .navigationBarTitle("Notebook")
                            .navigationBarBackButtonHidden(true)
                    }
                    .tabItem {
                        Image(systemName: "note.text")
                        Text("Notebook")
                    }
                    

                    NavigationView {
                        LogOutView(isLoggedOut: $isLoggedOut)
                            .navigationBarTitle("Notepad", displayMode: .inline)
                            .navigationBarBackButtonHidden(true)
                    }
                    .tabItem {
                        Image(systemName: "gearshape.fill")
                        Text("Log Out")
                    }
                }
                .navigationViewStyle(StackNavigationViewStyle())
            }
        }
        .onAppear {
            isLoggedOut = false
        }
        .onChange(of: isLoggedOut) { isLoggedOut in
            if isLoggedOut {
                isNavigatingToLogin = true
            }
        }
    }
}

struct DetailView: View {
    let discipline: String

    var body: some View {
        Text(discipline)
            .font(.largeTitle)
            .padding()
            .navigationBarTitle(Text(discipline), displayMode: .inline)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        let persistenceController = PersistenceController.shared
        HomeView()
            .environment(\.managedObjectContext, persistenceController.container.viewContext)
    }
}
