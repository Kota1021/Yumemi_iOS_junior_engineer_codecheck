//
//  LicenseView.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/05/31.
//

import SwiftUI

struct LicenseView: View {
    let viewSize: CGSize
    let width: CGFloat

    init(size: CGSize) {
        self.viewSize = size
        self.width = size.width
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            //making a boaring licence display a little bit sexier.
            Text("Liblaries,\nMaterials,\nand\nLicenses.")
                .font(.system(size: width / 6))
                .lineLimit(4)
                .minimumScaleFactor(0.8)

            Spacer()
            Group {
                HStack {
                    URLButton(
                        "Alamofire", url: URL(string: "https://github.com/Alamofire/Alamofire")!
                    )
                    .layoutPriority(1)
                    URLButton(
                        "MIT License",
                        url: URL(
                            string: "https://github.com/Alamofire/Alamofire/blob/master/LICENSE")!)
                }

                HStack {
                    URLButton(
                        "SwiftyUserDefaults",
                        url: URL(string: "https://github.com/sunshinejr/SwiftyUserDefaults")!
                    )
                    .layoutPriority(1)
                    URLButton(
                        "MIT License",
                        url: URL(
                            string:
                                "https://github.com/sunshinejr/SwiftyUserDefaults/blob/master/LICENSE"
                        )!)
                }

                HStack {
                    URLButton(
                        "GlowBorder by Samuel Doe",
                        url: URL(
                            string:
                                "https://github.com/SamuelDo02/swiftuitutorials/blob/main/GlowBorder.swift"
                        )!)
                }

                URLButton("Photos from: FIND/47", url: URL(string: "https://find47.jp")!)
                    .layoutPriority(1)
                HStack {
                    Text("     via")

                    URLButton(
                        "Code for FUKUI", url: URL(string: "https://github.com/code4fukui/find47")!)
                }

                URLButton(URL(string: "https://japan-map.com")!) {
                    Text("Map illusts from: 日本地図の無料イラスト素材集")
                        .multilineTextAlignment(.leading)

                }

            }.padding(.horizontal)
                .padding(.vertical, 5)
                .foregroundColor(Color(.label))
                .layoutPriority(1)
            Spacer()
            Spacer()
        }.padding()
            .padding(.vertical, 40)
            .fontWeight(.bold)
            .glowBorder(color: Color(.systemBackground), lineWidth: 3)
            .background(
                Color.clear
                    .frame(width: viewSize.width, height: viewSize.height)
                    .background(.ultraThinMaterial)
            )
    }
}

struct LicenseView_Previews: PreviewProvider {
    static var previews: some View {
        LicenseView(size: PreviewData.screenSize)
    }
}
