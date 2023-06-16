//
//  InfoView.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/06/01.
//

import AudioToolbox
import SwiftUI

struct DetailView: View {
    @EnvironmentObject var screen: ScreenSize
    let prefecture: Prefecture
    @Binding var isBreafViewExpanded: Bool
    @Binding var isMapExpanded: Bool

    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {

                    Text(prefecture.name)
                        .fontWeight(.black)
                        .font(.system(size: 55))
                        .shadow(radius: 20)
                        .padding(10)

                    VStack(alignment: .custom) {
                        HStack(spacing: 0) {
                            Text("CapitalCity")
                                .alignmentGuide(.custom) { $0[.trailing] }
                            Text(" ")
                            Text("\(prefecture.capital)")
                        }
                        HStack(spacing: 0) {
                            Text("Citizen'sDay")
                                .alignmentGuide(.custom) { $0[.trailing] }
                            Text(" ")
                            // Below: ternary operator cannot handle String and LocalizedStringKey at the same time.
                            if let citizenDay = prefecture.citizenDay{
                                Text(citizenDay.toString() )
                                
                            }else{
                                    Text("NotExists")
                                }
                        }
                        HStack(spacing: 0) {
                            Text("Coastline")
                                .alignmentGuide(.custom) { $0[.trailing] }
                            Text(" ")
                            Text(prefecture.hasCoastLine ? "Exists" : "NotExists")
                        }
                    }
                    Spacer()
                    Text("Brief")
                        .padding(.top)
                }

                // How to separate iPadOS from iOS with Conditional compilation block ?
                if screen.estimatedOS == .iOS {
                    MapButton(
                        isMapExpanded: $isMapExpanded,
                        imageURL: prefecture.logoUrl)
                } else {
                    MapView(pinLocation: prefecture.location)
                }

            }

            Button {
                withAnimation { isBreafViewExpanded = true }

            } label: {
                VStack {
                    Text(prefecture.brief)
                    HStack {
                        Spacer()
                        Text("TapToRead")
                            .lineLimit(1)
                        Image(systemName: "hand.tap.fill")
                    }.foregroundColor(.gray)
                }.padding()
            }.buttonStyle(.plain)
                .background(Color(.secondarySystemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 8))

        }.padding(.horizontal)
            .padding(.bottom)
    }
}

struct InfoView_Previews: PreviewProvider {
    @State private static var isDetailDisplayed = false
    @State private static var isMapDisplayed = false

    static var previews: some View {

        DetailView(
            prefecture: PreviewData.prefecture, isBreafViewExpanded: $isDetailDisplayed,
            isMapExpanded: $isMapDisplayed
        )
        .environmentObject(ScreenSize())
    }
}
