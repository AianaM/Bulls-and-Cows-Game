//
//  KeyboardView.swift
//  Bulls and Cows Game
//
//  Created by Aiana Miachina on 08.04.2022.
//

import SwiftUI

struct KeyboardView: View {
    @State private var numbers: [Int] = []
    let onSubmit: (_ numbers: [Int]) -> Void
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    private func getKeyTitle(number: Int) -> String {
        switch number {
        case 10:
            return "🔙"
        case 11:
            return "0"
        case 12:
            return "✅"
        default:
            return String(number)
        }
    }
    
    private func setNumber(item: Int) -> Void {
        switch item {
        case 10:
            guard numbers.count > 0 else { return }
            numbers.removeLast()
        case 11:
            guard !numbers.contains(item) && numbers.count < 4 else { return }
            numbers.append(0)
        case 12:
            guard numbers.count == 4 else { return }
            onSubmit(numbers)
            numbers.removeAll()
        default:
            guard !numbers.contains(item) && numbers.count < 4 else { return }
            numbers.append(item)
        }
    }
    
    var body: some View {
        VStack {
            Text(numbers.compactMap{String($0)}.joined()).font(.largeTitle)
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach((1...12), id: \.self) { item in
                    Button(action: {setNumber(item: item)}, label: {
                        Text(getKeyTitle(number: item))
                            .font(.headline)
                            .frame(width: 50 , height: 50, alignment: .center)
                    })
                        .background(.black)
                        .foregroundColor(.white)
                        .cornerRadius(5)
                }
            }
        }
    }
}

struct KeyboardView_Previews: PreviewProvider {
    static var previews: some View {
        KeyboardView(onSubmit: { _ in })
    }
}
