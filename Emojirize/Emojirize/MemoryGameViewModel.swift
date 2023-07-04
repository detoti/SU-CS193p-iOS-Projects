//
//  MemoryGameViewModel.swift
//  Emojirize
//
//  Created by André Toti on 29/06/23.
//

import SwiftUI

//reference types
class MemoryGameViewModel: ObservableObject {
    typealias Card = MemoryGame<String>.Card
    //type proprieties
    private static let emojis = ["🚗","🚕","🚙","🚌","🚎","🏎️","🚓","🚑","🚒","🚐","🛻","🚚","🚛","🚜","🚲","🛵","🏍️","🛺","✈️","🛩️","🚀","🛸","🚁","🛶","🚤","🚢"]
    
    //type function
    private static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: 9) { pairIndex in
            emojis[pairIndex]
        }
    }

    @Published private var model = createMemoryGame()
    
    var cards: Array<Card> {
        model.cards
    }
    
    //MARK: Intent(s)
    
    func choose(_ card: Card) {
        model.choose(card)
    }
}
