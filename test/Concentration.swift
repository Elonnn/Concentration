//
//  Concentration.swift
//  test
//
//  Created by 许奕郎 on 2018/7/17.
//  Copyright © 2018 许奕郎. All rights reserved.
//

import Foundation

class Concentration{
    var cards = [Card]()
    
    init(numberOfPairsOfCards : Int) {
        for _ in 0 ..< numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        cards.shuffle()
    }
    
    private var indexOfTheOneAndOnlyFaceUpCard : Int?{
        get{
            let faceUpCardsIndices = cards.indices.filter{cards[$0].isFaceUp }
            return faceUpCardsIndices.count == 1 ? faceUpCardsIndices.first : nil
        }
        set{
            for index in cards.indices{
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    func chooseCard(at index : Int)  {
        if cards[index].isMatched{
            // TODO:
            //如果直接调用对Controller的数据改动   则破坏了MVC  so Model应该怎么跟Controller通信?
            //只是个框架 不一定要严格遵守 
            return
        } // just ignore
        if let matchIndex = indexOfTheOneAndOnlyFaceUpCard, matchIndex != index{
            if cards[matchIndex] == cards [index]{
                cards[matchIndex].isMatched = true
                cards[index].isMatched = true
            }
            cards[index].isFaceUp = true
        } else { // two or no cards are faced up
            //cards[index].isFaceUp = true ...
            indexOfTheOneAndOnlyFaceUpCard = index
        }
    }
    
}

extension Array {  //swift 4.2+ has already implemented that
    mutating func shuffle() {
        for i in 0 ..< (count - 1) {
            //let j = Int(arc4random_uniform(UInt32(count - i))) + i
            let j = count.arc4random
            swapAt(i, j)
        }
    }
}

