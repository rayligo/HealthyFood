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

    let disciplines = ["statue", "mural", "plaque"]
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
                            List(disciplines, id: \.self) { discipline in
                                NavigationLink(destination: DetailView(discipline: discipline)) {
                                    Text(discipline)
                                }
                            }

                            Spacer()
                        }
                        .toolbar {
                            ToolbarItem(placement: .navigationBarLeading) {
                                Text("HealthyFood")
                                    .font(.largeTitle)
                            }
                            ToolbarItem(placement: .navigationBarTrailing) {
                                NavigationLink(destination: NoteBookView().environment(\.managedObjectContext, viewContext)) {
                                    Image("notebook")
                                        .resizable()
                                        .frame(width: 40, height: 40)
                                        .background(Color.white)
                                        .cornerRadius(5)
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
