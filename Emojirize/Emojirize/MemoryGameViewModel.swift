//
//  MemoryGameViewModel.swift
//  Emojirize
//
//  Created by André Toti on 29/06/23.
//

import SwiftUI

class MemoryGameViewModel {
    
    //type proprieties
    static let emojis = ["🚗","🚕","🚙","🚌","🚎","🏎️","🚓","🚑","🚒","🚐","🛻","🚚","🚛","🚜","🚲","🛵","🏍️","🛺","✈️","🛩️","🚀","🛸","🚁","🛶","🚤","🚢"]
    
    //type function
    static func createMemoryGame() -> MemoryGame<String> {
    MemoryGame<String>(numberOfPairsOfCards: 4) { pairIndex in
        emojis[pairIndex]
        }
    }

    private var model: MemoryGame<String> = createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
}
