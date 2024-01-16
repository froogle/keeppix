//
//  HomeView.swift
//  keeppix
//
//  Created by Peter Wright on 01/01/2024.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading){
                HStack(alignment: .top, spacing: 30) {
                    Button( "Frequent", action: {} ).font(.caption)
                    Button( "Newest", action: {} ).font(.caption)
                    Button( "Popular", action: {} ).font(.caption)
                    Spacer()
                }.padding([.bottom], 10)
                
                ZStack( alignment: .top) {
                    Image(systemName: "photo.artframe")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")
                        .font(.body)
                        .foregroundColor(.white)
                        .lineLimit(1)
                        .truncationMode(.tail)
                        .padding(10)
                        .background(LinearGradient(gradient: Gradient(colors: [.blue, .gray]), startPoint: .top, endPoint: .bottom)
                        .cornerRadius(10)
                        )
                        .offset(y: 5)
                        .opacity(0.95)
                }.padding(0)
                
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                    ForEach(0..<6) { index in
                        Image(systemName: "square")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding([.leading, .trailing], 5)
                    }
                }
                
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding( .all )
        }
        
        
    }
}

#Preview {
    HomeView()
}
