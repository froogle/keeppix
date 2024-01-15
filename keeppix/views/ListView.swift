//
//  ListView.swift
//  keeppix
//
//  Created by Peter Wright on 02/01/2024.
//

import SwiftUI
import SwiftData

struct ListView: View {
    @Query() var pixs: [Pix]
    
    var body: some View {
        VStack(alignment: .leading){
            HStack(alignment: .top, spacing: 30) {
                Button( "Frequent", action: {} ).font(.caption)
                Button( "Newest", action: {} ).font(.caption)
                Button( "Popular", action: {} ).font(.caption)
                Spacer()
            }.padding([.bottom], 10)
            
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                    ForEach(pixs) { pix in
                        ThumbnailView(pix: pix)
                    }
                }
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding( .all )
    }
}

#Preview {
    ListView()
}
