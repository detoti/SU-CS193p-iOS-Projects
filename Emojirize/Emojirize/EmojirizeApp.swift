//
//  EmojirizeApp.swift
//  Emojirize
//
//  Created by André Toti on 26/06/23.
//

import SwiftUI

@main
struct EmojirizeApp: App {
    let game = MemoryGameViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: game)
        }
    }
}
