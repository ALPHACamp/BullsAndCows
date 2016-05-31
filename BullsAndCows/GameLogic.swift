//
//  GameLogic.swift
//  BullsAndCows
//
//  Created by PiHan Hsu on 5/31/16.
//  Copyright © 2016 Brian. All rights reserved.
//

import UIKit

class GameLogic: NSObject {
    var answerString: String = ""
    
    func generateAnswear() -> String {
        answerString = ""
        //ramdon pick an element and put into answer array then remove it from numberArray
        var numberArray = ["0","1","2","3","4","5","6","7","8","9"]
        for _ in 0...3{
            let r = Int(arc4random_uniform(UInt32(numberArray.count)))
            answerString = answerString + numberArray.removeAtIndex(r)
        }
        
        return answerString
    }

    
    func checkAnswer(inputStr:String) -> (a: Int, b: Int){
        var a = 0
        var b = 0

        //convert Str into Array<Character> to compare
        let inputCharArray = Array(inputStr.characters)
        let answerCharArray = Array(answerString.characters)

        for (index, element) in inputCharArray.enumerate() {
            if element == answerCharArray[index] {
                a += 1
            }else if answerCharArray.contains(element){
                b += 1
            }
        }
        return (a, b)
    }


}
