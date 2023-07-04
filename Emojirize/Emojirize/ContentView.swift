//
//  ContentView.swift
//  Emojirize
//
//  Created by André Toti on 26/06/23.
//

import SwiftUI

    //MARK: ContentView

struct ContentView: View {
    @ObservedObject var viewModel: MemoryGameViewModel
    
    var body: some View {
        VStack {
            Text("Emojirize!")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 70))]) {
                    ForEach(viewModel.cards) { card in
                        CardView(card: card)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                viewModel.choose(card)
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
    let card: MemoryGame<String>.Card
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 10)
            if card.isFaceUp {
                shape.fill(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(card.content)
                    .font(.largeTitle)
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

    //MARK: Preview

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = MemoryGameViewModel()
        ContentView(viewModel: game)
            .preferredColorScheme(.light)
        ContentView(viewModel: game)
            .preferredColorScheme(.dark)
    }
}
