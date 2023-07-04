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
            Text("Emojirize!")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))]) {
                    ForEach(game.cards) { card in
                        CardView(card: card)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                game.choose(card)
                            }
                    }
                }
            }
            .foregroundColor(.red)
            Spacer()
        }
        .padding(.horizontal)
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
                    shape.fill(.white)
                    shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
                    Text(card.content)
                        .font(font(in: geometry.size))
                } else if card.isMatched {
                    shape.opacity(0)
                } else {
                    ZStack {
                        shape.fill()
                        Image(systemName: "car.2")
                            .font(.largeTitle)
                            .foregroundColor(.white)
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
        static let fontScale: CGFloat = 0.8
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
