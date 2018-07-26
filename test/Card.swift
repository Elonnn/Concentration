//
//  Card.swift
//  test
//
//  Created by 许奕郎 on 2018/7/17.
//  Copyright © 2018 许奕郎. All rights reserved.
//

import Foundation

struct Card : Hashable
{
    init() {
        self.identifier = Card.getUniqueIdentifier ()
    }
    
    var isFaceUp = false
    var isMatched = false
    private var identifier : Int
    
    static private var identifierFactory = 0
    static private func getUniqueIdentifier() -> Int{
        identifierFactory += 1
        return identifierFactory
    }
    
    var hashValue: Int {return identifier}  //如果不自行定义 会用系统默认提供的 达不到这样的功能
    static func == (lhs: Card, rhs: Card) -> Bool { //why static?  类可以直接调用？因为是两个参数  如果把==换成函数名 可以直接调用  Card.equal(a, b)  但 == 有一层封装 只能用 == 不可以显式调用 Card.==()
        return lhs.identifier == rhs.identifier
    }
//    func equal (rhs: Card) -> Bool { //为啥不对  换个名字如equal 就可以
//        return identifier == rhs.identifier
//    }
    
}
