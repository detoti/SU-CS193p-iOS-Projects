//
//  EmojirizeApp.swift
//  Emojirize
//
//  Created by André Toti on 26/06/23.
//

import SwiftUI

@main
struct EmojirizeApp: App {
    private let game = MemoryGameViewModel()
    
    var body: some Scene {
        WindowGroup {
            EmojirizeGameView(game: game)
        }
    }
}
