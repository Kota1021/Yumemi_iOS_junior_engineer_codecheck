//
//  LicenseView.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/05/31.
//

import SwiftUI

struct LicenseView: View {
    var body: some View {
        //        List(Library.libraries, id: \.name) { library in
        //                   Text(library.name)
        //               }
        VStack{
            Text("Alamofire: MIT License ......")
            Text("photos from FIND/47 https://find47.jp via https://github.com/code4fukui/find47")
        }
        
    }
}

struct LicenseView_Previews: PreviewProvider {
    static var previews: some View {
        LicenseView()
    }
}
