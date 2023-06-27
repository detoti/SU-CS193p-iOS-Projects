//
//  ContentView.swift
//  Emojirize
//
//  Created by André Toti on 26/06/23.
//

import SwiftUI

    //MARK: ContentView

struct ContentView: View {
    
    var emojis = ["🚗","🚕","🚙","🚌","🚎","🏎️","🚓","🚑","🚒","🚐","🛻","🚚","🚛","🚜","🚲","🛵","🏍️","🛺","✈️","🛩️","🚀","🛸","🚁","🛶","🚤","🚢"]
    @State var emojiCount = 4
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 70))]) {
                    ForEach(emojis[0..<emojiCount], id:\.self) { emoji in
                        CardView(content: emoji)
                            .aspectRatio(2/3, contentMode: .fit)
                    }
                }
            }
            .foregroundColor(.red)
            Spacer()
            HStack {
                remove
                Spacer()
                add
            }
            .padding(.horizontal)
        }
        .padding(.horizontal)
        
    }
    
    //MARK: Buttons
        var remove: some View {
            Button {
                if emojiCount > 1 {
                    emojiCount -= 1
                }
            } label: {
                Image(systemName: "minus.circle")
                    .font(.largeTitle)
            }
        }
        var add: some View {
            Button {
                if emojiCount < emojis.count {
                    emojiCount += 1
                }
            } label: {
                Image(systemName: "plus.circle")
                    .font(.largeTitle)
        }
    }
}
    //MARK: Cards

struct CardView: View {
    
    var content: String
    @State var isFaceUP: Bool = true
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 10)
            if isFaceUP {
                shape.fill(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(content)
                    .font(.largeTitle)
            } else {
                shape.fill()
            }
        }
        .onTapGesture {
            isFaceUP = !isFaceUP
        }
    }
}

    //MARK: Preview

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.light)
        ContentView()
            .preferredColorScheme(.dark)
    }
}
