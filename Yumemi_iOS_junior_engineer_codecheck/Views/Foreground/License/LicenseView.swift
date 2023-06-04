//
//  LicenseView.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/05/31.
//

import SwiftUI

struct LicenseView: View {
    let viewSize:CGSize
    //    @State private var blurStrength:Double = 0
    
    init(size: CGSize) {
        self.viewSize = size
    }
    
    var body: some View {
        VStack(alignment: .leading,spacing: 0){
            Group{
                Text("Liblaries,")
                    .font(.system(size: 70))
                    .padding(.top)
                Text("Materials,")
                    .font(.system(size: 70))
                Text("and")
                    .font(.system(size: 60))
                Text("Licenses.")
                    .font(.system(size: 70))
                    .padding(.bottom)
            }
            .lineLimit(1)
            .minimumScaleFactor(0.5)
            
            
            Spacer()
            Group{
                HStack{
                    URLButton("Alamofire", url: URL(string: "https://github.com/Alamofire/Alamofire")!)
                        .layoutPriority(1)
                    URLButton("MIT License", url: URL(string: "https://github.com/Alamofire/Alamofire/blob/master/LICENSE")!)
                }
                
                HStack{
                    URLButton("SwiftyUserDefaults", url: URL(string: "https://github.com/sunshinejr/SwiftyUserDefaults")!)
                        .layoutPriority(1)
                    URLButton("MIT License", url: URL(string: "https://github.com/sunshinejr/SwiftyUserDefaults/blob/master/LICENSE")!)
                }
                
                HStack{
                    URLButton("GlowBorder by Samuel Doe", url: URL(string: "https://github.com/SamuelDo02/swiftuitutorials/blob/main/GlowBorder.swift")!)
                }
                
                
                URLButton("Photos from: FIND/47", url: URL(string: "https://find47.jp")!)
                    .layoutPriority(1)
                HStack{
                    Text("     via")
                    
                    URLButton("Code for FUKUI", url: URL(string: "https://github.com/code4fukui/find47")!)
                }
                
                URLButton(URL(string: "https://japan-map.com")!){
                    Text("Map illusts from: 日本地図の無料イラスト素材集")
                        .multilineTextAlignment(.leading)
                    
                }
                
            }.padding(.horizontal)
                .padding(.vertical,5)
                .foregroundColor(Color(.label))
            Spacer()
        }.padding()
            .padding(.vertical,40)
        //        .tint(Color(.label))
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
