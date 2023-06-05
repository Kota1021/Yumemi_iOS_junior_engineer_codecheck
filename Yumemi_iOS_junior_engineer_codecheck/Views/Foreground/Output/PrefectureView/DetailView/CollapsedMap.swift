//
//  CollapsedMap.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/06/05.
//

import SwiftUI

struct CollapsedMap: View {
    @Binding var isMapExpanded:Bool
    let url:URL
    var body: some View {
        Button{
            withAnimation{ isMapExpanded = true }
        }label: {
            AsyncImage(url: url){ image in
                VStack{
                    image
                        .resizable()
                        .scaledToFit()
                    HStack{
                        Spacer()
                        Text("位置を確認")
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
