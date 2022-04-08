//
//  Game.swift
//  Bulls and Cows Game
//
//  Created by Aiana Miachina on 08.04.2022.
//

import Foundation
import SwiftUI

struct Game {
    private let secretNumber: [Int]
    
    struct Guess: Identifiable {
        let id: Int
        let numbers: [Int]
        let bulls: Int
        let cows: Int
        
        init(id: Int, numbers: [Int], secretNumber: [Int]) {
            var bulls = 0
            var cows = 0
            for index in numbers.indices {
                if secretNumber[index] == numbers[index] {
                    bulls += 1
                } else if secretNumber.contains(numbers[index]) {
                    cows += 1
                }
            }
            self.id = id
            self.numbers = numbers
            self.bulls = bulls
            self.cows = cows
        }
    }
    private (set) var guesses = [Guess]()
    
    private (set) var done = false
    
    public static var getRandomNumber: [Int] {
        get {
            let numbers = (0...9)
            var secretNumber = [Int]()
            repeat {
                guard let number = numbers.randomElement() else { continue }
                guard !secretNumber.contains(number) else { continue }
                secretNumber.append(number)
            } while secretNumber.count < 4
            return secretNumber
        }
    }
    
    init(secretNumber: [Int]) {
        self.secretNumber = secretNumber
    }
    
    mutating func addGuess(numbers: [Int]) -> Void {
        let answer = Guess(id: guesses.count, numbers: numbers, secretNumber: secretNumber);
        guesses.append(answer)
        guard answer.bulls == 4 else { return }
        done = true
    }
}

extension Game {
    var secretNumberAsString: String {
        get {
            return secretNumber.compactMap{String($0)}.joined()
            
        }
    }
    
    static func setGuessesMocks(game: inout Game, count: Int) {
        (1...count).forEach { i in
            game.addGuess(numbers: Game.getRandomNumber)
        }
    }
    
    static func getGuessesMocks(count: Int, secretNumber: [Int]) -> [Game.Guess] {
        return (1...count).map { i in
            Game.Guess(id: i, numbers: Game.getRandomNumber, secretNumber: secretNumber)
        }
    }
}
