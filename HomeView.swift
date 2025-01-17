//
//  HomeView.swift
//  HealthyFood
//
//  Created by Li Yiu Yeung  on 17/1/2025.
//

import Foundation
import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            VStack {
                // Grid layout with images
                LazyHGrid(rows: [GridItem(.flexible())], spacing: 10) {
                    ForEach(1..<5) { index in
                        Image("notebook")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 100)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                            .foregroundColor(.white)
                    }
                }
                
                LazyHGrid(rows: [GridItem(.flexible())], spacing: 10) {
                    ForEach(5..<9) { index in
                        Image("notebook")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 100)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                            .foregroundColor(.white)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("HealthyFood")
                        .font(.largeTitle)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Image("notebook")
                        .resizable()
                        .frame(width: 35, height: 35)
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
