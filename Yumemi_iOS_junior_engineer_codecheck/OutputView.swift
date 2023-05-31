//
//  OutputView.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/05/31.
//

import SwiftUI

struct OutputView: View {
    
    let prefacture:FortuneOutput
    
    var body: some View {
            VStack{
                AsyncImage(url: prefacture.logoUrl){ image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                Text(prefacture.name)
                Text(prefacture.capital)
                Text(prefacture.citizenDay?.toString() ?? "")
                Text(prefacture.hasCoastLine ? "海あり":"海なし")
                Text(prefacture.brief)
            }
    }
}

struct OutputView_Previews: PreviewProvider {
    
     static var luckeyPrefacture = FortuneOutput(name: "徳島県", brief: "徳島県（とくしまけん）は、日本の四国地方に位置する県。県庁所在地は徳島市。\n※出典: フリー百科事典『ウィキペディア（Wikipedia）』", capital: "徳島市", citizenDay: nil, hasCoastLine: true, logoUrl: URL(string: "https://japan-map.com/wp-content/uploads/tokushima.png")!)
    
    static var previews: some View {
        OutputView(prefacture:luckeyPrefacture)
    }
}
