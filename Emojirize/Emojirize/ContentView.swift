//
//  ContentView.swift
//  Emojirize
//
//  Created by André Toti on 26/06/23.
//

import SwiftUI

    //MARK: ContentView

struct ContentView: View {
    
    @State var emojis = ["🚗","🚕","🚙","🚌","🚎","🏎️","🚓","🚑","🚒","🚐","🛻","🚚","🚛","🚜","🚲","🛵","🏍️","🛺","✈️","🛩️","🚀","🛸","🚁","🛶","🚤","🚢"]
    
    @State var emojiCount = 8
    
    var body: some View {
    
        VStack {
            Text("Emojirize!")
                .font(.largeTitle)
                .fontWeight(.bold)
            
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

            .padding(.horizontal)
        }
        .padding(.horizontal)
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
                ZStack {
                    shape.fill()
                    Image(systemName: "car.2")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                }
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
