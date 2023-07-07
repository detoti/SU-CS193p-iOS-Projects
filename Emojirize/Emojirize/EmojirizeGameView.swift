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
    @Namespace private var dealingNameSpace
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack{
                gameBody
                HStack {
                  restart
                    Spacer()
                    shuffle
                }
                .padding()
            }
            .background(Color(red: 0.4, green: 0.6, blue: 0.8))
            deckBody
        }
        
    }
    
    @State private var dealt = Set<Int>()
    
    private func deal(_ card: MemoryGameViewModel.Card) {
        dealt.insert(card.id)
    }
    
    private func isUndealt(_ card: MemoryGameViewModel.Card) -> Bool {
        return !dealt.contains(card.id)
    }
    
    private func dealAnimation(for card: MemoryGameViewModel.Card) -> Animation {
        var delay = 0.0
        if let index = game.cards.firstIndex(where: { $0.id == card.id}) {
            delay = Double(index) * (CardConstants.totalDealDuration / Double(game.cards.count))
        }
        return Animation.easeInOut(duration: CardConstants.dealDuration).delay(delay)
    }
    
    private func zIndex(of card: MemoryGameViewModel.Card) -> Double {
        -Double(game.cards.firstIndex(where: { $0.id == card.id }) ?? 0)
    }
    
    var gameBody: some View {
            AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
                if isUndealt(card) || (card.isMatched && !card.isFaceUp) {
                    Color.clear
                } else {
                    CardView(card: card)
                        .matchedGeometryEffect(id: card.id, in: dealingNameSpace)
                        .padding(4)
                        .transition(AnyTransition.asymmetric(insertion: .identity, removal: .scale))
                        .zIndex(zIndex(of: card))
                        .onTapGesture {
                            withAnimation {
                                game.choose(card)
                        }
                    }
                }
            }
            .padding(10)
    }
    
    var deckBody: some View {
        ZStack {
            ForEach(game.cards.filter(isUndealt)) { card in
                CardView(card: card)
                    .matchedGeometryEffect(id: card.id, in: dealingNameSpace)
                    .transition(AnyTransition.asymmetric(insertion: .opacity, removal: .identity))
                    .zIndex(zIndex(of: card))
            }
        }
        .frame(width: CardConstants.undealtWidth, height: CardConstants.undealtHeight)
        .foregroundColor(CardConstants.color)
        .onTapGesture {
            for card in game.cards {
                withAnimation(dealAnimation(for: card)) {
                    deal(card)
                }
            }
        }
    }
    
    var shuffle: some View {
        Button("Shuffle") {
            withAnimation(.easeOut(duration: 1)) {
                game.shuffle()
            }
        }
        .buttonStyle(.plain)
        .foregroundColor(.white)
    }
    
    var restart: some View {
        Button("New Game") {
            withAnimation(.easeOut(duration: 1)) {
                dealt = []
                game.restart()
            }
        }
        .buttonStyle(.plain)
        .foregroundColor(.white)
    }
    
    private struct CardConstants {
        static let color = Color.red
        static let aspectRatio: CGFloat = 2/3
        static let dealDuration: Double = 0.5
        static let totalDealDuration: Double = 2
        static let undealtHeight: CGFloat = 90
        static let undealtWidth = undealtHeight * aspectRatio
    }
}

    //MARK: Cards

struct CardView: View {
    let card: MemoryGameViewModel.Card
    
    @State private var animatedBonusRemaining: Double = 0
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Group {
                    if card.isConsumingBonusTime {
                        Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: (1-animatedBonusRemaining)*360-90))
                            .onAppear {
                                animatedBonusRemaining = card.bonusRemaining
                                withAnimation(.linear(duration: card.bonusTimeRemaining)) {
                                    animatedBonusRemaining = 0
                                }
                            }
                    } else {
                        Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: (1-card.bonusRemaining)*360-90))
                    }
                }
                        .padding(2)
                        .opacity(0.7)
                    Text(card.content)
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false))
                    .font(Font.system(size: DrawingConstants.fontSize))
                    .scaleEffect(scale(thatfits: geometry.size))
            }
            .cardify(isFaceUp: card.isFaceUp)
            
        }
    }
    
    private func scale(thatfits size: CGSize) -> CGFloat {
    min (size.width, size.height) / (DrawingConstants.fontSize / DrawingConstants.fontScale)
    }
    
    private struct DrawingConstants {
        static let fontScale: CGFloat = 0.7
        static let fontSize: CGFloat = 32
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
