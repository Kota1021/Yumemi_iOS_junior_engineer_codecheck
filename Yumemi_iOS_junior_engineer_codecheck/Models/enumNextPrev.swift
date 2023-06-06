//
//  enumNextPrev.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/06/06.
//

import Foundation

///these functions are used in selecting views to display
///cf. https://stackoverflow.com/questions/51103795/how-to-get-next-case-of-enumi-e-write-a-circulating-method-in-swift-4-2
extension CaseIterable where Self: Equatable {
    func next() -> Self {
        let all = Self.allCases
        let index = all.firstIndex(of: self)!

        if index == all.index(all.endIndex, offsetBy: -1) { return self }
        let nextIndex = all.index(index, offsetBy: 1)
        return all[nextIndex]
    }
    func previous() -> Self {
        let all = Self.allCases
        let index = all.firstIndex(of: self)!

        if index == all.startIndex { return self }
        let previousIndex = all.index(index, offsetBy: -1)
        return all[previousIndex]
    }
}
