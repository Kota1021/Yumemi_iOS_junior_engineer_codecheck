//
//  ErrorView.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/05/31.
//

import SwiftUI
import Alamofire

struct ErrorView: View {
    let error:AFError
    var body: some View {
        Text("Error occored while fetching a lucky prefecture.\nPlease contact to the developper.\nContact:#####")
        Text(error.localizedDescription)
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var  error = AFError.createURLRequestFailed(error: MyError.someError)
    static var previews: some View {
        ErrorView(error:error)
    }
}
enum MyError: Error {
    case someError
}

extension AFError:Equatable{
    public static func == (lhs: Alamofire.AFError, rhs: Alamofire.AFError) -> Bool {
        lhs.localizedDescription == rhs.localizedDescription
    }
}


