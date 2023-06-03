//
//  LicenseView.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/05/31.
//

import SwiftUI

struct LicenseView: View {
    var body: some View {
        VStack{
            Text("Alamofire: MIT License ......")
            Text("images from: FIND/47 https://find47.jp via https://github.com/code4fukui/find47")
            Text("images from: https://japan-map.com/")
            Text("GlowBorder by Samuel Doe from: https://github.com/SamuelDo02/swiftuitutorials/blob/main/GlowBorder.swift")
        }
        
    }
}

struct LicenseView_Previews: PreviewProvider {
    static var previews: some View {
        LicenseView()
    }
}
