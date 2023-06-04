//
//  LongPressViewTest.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/06/04.
//

import SwiftUI

///cf. https://developer.apple.com/documentation/swiftui/longpressgesture
struct LongPressButton<Content:View>: View {
    
    let minimumDuration:Double
    let unpressed:Color
    let pressed:Color
    let action: () -> Void
    let content:() -> Content
    
    init(minimumDuration: Double,
         unpressed: Color = .clear,
         pressed: Color = .clear,
         action: @escaping () -> Void,
         label content: @escaping ()->Content = {Circle()} ) {
        self.unpressed = unpressed
        self.pressed = pressed
        self.minimumDuration = minimumDuration
        self.action = action
        self.content = content
    }
    
    @GestureState private var isDetectingLongPress = false
    var longPress: some Gesture {
        LongPressGesture(minimumDuration: minimumDuration)
            .updating($isDetectingLongPress) { currentState, gestureState,
                    transaction in
                gestureState = currentState
                transaction.animation = Animation.easeIn(duration:minimumDuration)
            }
            .onEnded{ _ in
                action()
            }
    }

    var body: some View {
        content()
            .background(self.isDetectingLongPress ?  pressed : unpressed )
            .clipShape(RoundedRectangle(cornerRadius: 8) )
            .gesture(longPress)
    }
}

struct LongPressView_Previews: PreviewProvider {
    static var previews: some View {
        LongPressButton(minimumDuration: 1.0, unpressed: Color.red, pressed: Color.green){
            print("action!")
        }label:{
            Text("hi!")
                .padding()
        }
    }
}
