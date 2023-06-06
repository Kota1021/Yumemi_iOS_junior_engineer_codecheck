//
//  CollapsedMap.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/06/05.
//

import SwiftUI

struct MapButton: View {
    @Binding var isMapExpanded: Bool
    let imageURL: URL
    var body: some View {
        Button {
            withAnimation { isMapExpanded = true }
        } label: {
            AsyncImage(url: imageURL) { image in
                VStack {
                    image
                        .resizable()
                        .scaledToFit()
                    HStack {
                        Spacer()
                        Text("Location")
                            .lineLimit(1)
                        Image(systemName: "hand.tap.fill")
                    }.foregroundColor(.gray)
                }
                .padding()
            } placeholder: {
                ProgressView()
            }
        }.layoutPriority(-1)
            .background(Color(.secondarySystemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}
