//
//  Cardify.swift
//  Emojirize
//
//  Created by André Toti on 06/07/23.
//

import SwiftUI

struct Cardify: AnimatableModifier {
    
    init(isFaceUp : Bool) {
        rotation = isFaceUp ? 0 : 180
    }
    
    var animatableData: Double {
        get { rotation }
        set { rotation = newValue }
    }
    
    var rotation: Double // in degrees
    
    func body(content: Content) -> some View {
        ZStack {
            let shape = RoundedRectangle (cornerRadius: DrawingConstants.cornerRadius)
            if rotation < 90 {
                shape.fill(Color(red: 0.2, green: 0.4, blue: 0.6))
                shape.strokeBorder(Color(red: 0.1, green: 0.3, blue: 0.5), lineWidth: DrawingConstants.lineWidth)
                .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 5)
                
            } else {
                ZStack {
                shape.fill(Color(red: 0.1, green: 0.3, blue: 0.5))
                    .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 5)
                Image(systemName: "car.2")
                    .font(.largeTitle)
                    .foregroundColor(Color(red: 0.6, green: 0.8, blue: 1.0))
                }
            }
            content
                .opacity(rotation < 90 ? 1 : 0)
        }
        .rotation3DEffect(Angle.degrees(rotation), axis: (0, 1, 0))
    }
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
    }
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        return self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}
