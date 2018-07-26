//
//  ViewController.swift
//  test
//
//  Created by 许奕郎 on 2018/7/17.
//  Copyright © 2018 许奕郎. All rights reserved.
//

import UIKit

class ConcentrationViewController: UIViewController {
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    //no need of access control
    var numberOfPairsOfCards : Int {
        return (cardButtons.count+1)/2
    }
    
    private(set) var flipCount = 0{
        didSet{
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    @IBOutlet private weak var flipCountLabel: UILabel! //weak 引用计数不会+1
    
    @IBOutlet private var cardButtons: [UIButton]!
   
    /*  否则确实只能一个个拖动
     原来的按钮应该把下面写的盖住了
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var numOfX = 4
        var numOfY = 4
        var screenWidth = UIScreen.main.bounds.size.width
        var deviWidth: CGFloat = 10
        var buttWidth = (screenWidth - deviWidth * 5) / CGFloat(screenWidth)
        var buttHeight = buttWidth / 2
        
        for x in 0 ..< 4 {
            for y in 0 ..< 4 {
                var xx = CGFloat(x) * (buttWidth + deviWidth)
                var yy = CGFloat(y) * (buttHeight + deviWidth)
                var butt = UIButton(frame: CGRect(x: xx, y: yy, width: buttWidth, height: buttHeight))
                cardButtons.append(butt)
            }
        }
    }*/

    @IBAction private func touchCard(_ sender: UIButton) {
        flipCount += 1

        if let cardNumber = cardButtons.index(of: sender){
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
        else{
            print("chosen card was not in cardButtons")
        }
    }
    
    private func updateViewFromModel(){
        for index in cardButtons.indices{
            let button = cardButtons[index]
            let card = game.cards[index]
            
            //先判断 isMatched 若是 停半秒 最好是淡出效果
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ?  #colorLiteral(red: 0.9254901961, green: 0.9254901961, blue: 0.9254901961, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
        
    }
    
    var theme : String? {
        didSet {
            emojiChoices = theme ?? ""
            emoji = [:]  //不是很能理解
            updateViewFromModel()            
        }
    }
    
    private var emojiChoices: String = "🐶🎃🧙🏿‍♂️🙀👿👻👹👽😨🕯"
    private var emoji = [Card: String]() //dictionary, require the first param key to be Hashable
    private func emoji (for card: Card) -> String{
        if emoji[card] == nil , emojiChoices.count > 0{
            let randomStringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4random)
            emoji[card] = String(emojiChoices.remove(at: randomStringIndex))
        }
        return emoji[card] ?? "?" //may run out of emojiChoices
    }
    
    
}

extension Int {
    var arc4random : Int{
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(-self)))
        } else {
            return 0
        }
    }
}

/* the main diff b.w. struct and class
struct A{
    var s : Int
}
*/

