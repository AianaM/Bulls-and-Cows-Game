//
//  ContentView.swift
//  Bulls and Cows Game
//
//  Created by Aiana Miachina on 08.04.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var game = Game(secretNumber: Game.getRandomNumber)
    
    var body: some View {
        VStack {
            Text("Find the secret number")
//            Text(game.secretNumberAsString)
            GuessesView(guesses: game.guesses)
            if game.done {
                Text("You WIN!").font(.title)
                    .padding(.bottom, 30)
                Button("🔄") {
                    game = Game(secretNumber: Game.getRandomNumber)
                }
            } else {
//                Button("Add mocks") {
//                    Game.setGuessesMocks(game: &game, count: 55)
//                }.padding()
                KeyboardView() {
                    game.addGuess(numbers: $0)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
