//
//  SwiftyUserDefaultKeys.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/06/04.
//

import Foundation
import SwiftyUserDefaults
//cf. https://software.small-desk.com/development/2021/01/18/swiftui-color-userdefaults-swiftyuserdefaults/
extension DefaultsKeys {
    var userInfo:DefaultsKey<FetchInput> { .init("userInfo", defaultValue: FetchInput(name: "",
                                                                            birthday: YearMonthDay(from: Date() ),
                                                                            bloodType: .a,
                                                                            today: YearMonthDay(from: Date() ) ) ) }
}
