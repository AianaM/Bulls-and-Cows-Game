//
//  GuessesView.swift
//  Bulls and Cows Game
//
//  Created by Aiana Miachina on 08.04.2022.
//

import SwiftUI

struct GuessesView: View {
    let guesses: [Game.Guess]
    
    var body: some View {
        VStack(alignment: .center ) {
            HStack {
                Text("Guess").frame(width: (100.0))
                Text("Bulls").frame(width: (50.0))
                Text("Cows").frame(width: (50.0))
            }
            .font(.subheadline)
            ScrollViewReader { proxy in
                List(guesses) { guess in
                    HStack {
                        Spacer()
                        Text(guess.numbers.compactMap{String($0)}.joined()).frame(width: (100.0))
                        Text(String(guess.bulls)).frame(width: (50.0))
                        Text(String(guess.cows)).frame(width: (50.0))
                        Spacer()
                    }
                }
                .font(.body)
                .onChange(of: guesses.count) { count in
                    withAnimation {
                        proxy.scrollTo(count - 1)
                    }
                }
            }
        }
    }}

struct GuessesView_Previews: PreviewProvider {
    static var previews: some View {
        GuessesView(guesses: Game.getGuessesMocks(count: 30, secretNumber: Game.getRandomNumber))
    }
}
