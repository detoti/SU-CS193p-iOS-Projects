//
//  MemoryGameViewModel.swift
//  Emojirize
//
//  Created by André Toti on 29/06/23.
//

import SwiftUI

//reference types
class MemoryGameViewModel: ObservableObject {
    
    //type proprieties
    static let emojis = ["🚗","🚕","🚙","🚌","🚎","🏎️","🚓","🚑","🚒","🚐","🛻","🚚","🚛","🚜","🚲","🛵","🏍️","🛺","✈️","🛩️","🚀","🛸","🚁","🛶","🚤","🚢"]
    
    //type function
    static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: 4) { pairIndex in
            emojis[pairIndex]
        }
    }

    @Published private var model: MemoryGame<String> = createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    //MARK: Intent(s)
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
}
