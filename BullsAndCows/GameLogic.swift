//
//  GameLogic.swift
//  BullsAndCows
//
//  Created by PiHan Hsu on 5/31/16.
//  Copyright © 2016 Brian. All rights reserved.
//

import Foundation

protocol GameLogicProtocol {
    
    func generateAnswear()
    func checkAnswer(inputStr:String) -> (a: Int, b: Int)
    
}