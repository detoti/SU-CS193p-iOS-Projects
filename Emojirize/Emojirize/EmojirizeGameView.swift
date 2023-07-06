//
//  ContentView.swift
//  Emojirize
//
//  Created by André Toti on 26/06/23.
//

import SwiftUI

    //MARK: EmojirizeGameView

struct EmojirizeGameView: View {
    @ObservedObject var game: MemoryGameViewModel
    
    var body: some View {
        VStack {
            Text("--== Emojirize ==--")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(Color(red: 0.1, green: 0.3, blue: 0.5))
            
            AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
                if card.isMatched && !card.isFaceUp {
                    Rectangle().opacity(0)
                } else {
                    CardView(card: card)
                        .padding(4)
                        .onTapGesture {
                            game.choose(card)
                        }
                }
            }
        }
        .padding(.horizontal)
        .background(Color(red: 0.4, green: 0.6, blue: 0.8))
    }
}
    //MARK: Cards

struct CardView: View {
    let card: MemoryGameViewModel.Card
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                if card.isFaceUp {
                    shape.fill(Color(red: 0.2, green: 0.4, blue: 0.6))
                    shape.strokeBorder(Color(red: 0.1, green: 0.3, blue: 0.5), lineWidth: DrawingConstants.lineWidth)
                        .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 5)
                    Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: 120-90))
                        .foregroundColor(Color(red: 0.3, green: 0.5, blue: 0.7))
                        .padding(2)
                        .opacity(0.7)
                    Text(card.content)
                        .font(font(in: geometry.size))
                } else if card.isMatched {
                    shape.opacity(0)
                } else {
                    ZStack {
                        shape.fill(Color(red: 0.1, green: 0.3, blue: 0.5))
                            .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 5)
                        Image(systemName: "car.2")
                            .font(.largeTitle)
                            .foregroundColor(Color(red: 0.6, green: 0.8, blue: 1.0))
                    }
                }
            }
        }
    }
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.7
    }
}

    //MARK: Preview

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = MemoryGameViewModel()
        EmojirizeGameView(game: game)
            .preferredColorScheme(.light)
        EmojirizeGameView(game: game)
            .preferredColorScheme(.dark)
    }
}
