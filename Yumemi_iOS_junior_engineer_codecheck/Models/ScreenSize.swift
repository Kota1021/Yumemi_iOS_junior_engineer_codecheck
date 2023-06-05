//
//  ScreenSize.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/06/05.
//

import Foundation

class ScreenSize:ObservableObject{
    init(width:CGFloat = .zero, height:CGFloat = .zero){
        self.width = width
        self.height = height
    }
    init(size: CGSize = .zero){
        self.size = size
    }
    
    @Published var width:CGFloat = .zero
    @Published var height:CGFloat = .zero
    public var size:CGSize{
        get{ CGSize(width: width, height: height) }
        set{ width = newValue.width
             height = newValue.height
        }
    }
    
    // Wanna separate iPadOS from iOS, but Conditional Compilation Block doesn't work.
    public var estimatedOS:Plasforms{
        if height < 1000{
            return .iOS
        }else if height < 1500{
            return .iPadOS
        }else{
            return .mac
        }
    }
    
}

enum Plasforms{
    case iOS,iPadOS,mac
}
