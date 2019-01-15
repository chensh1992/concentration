//
//  Card.swift
//  Concentration
//
//  Created by Siheng Chen on 1/11/19.
//  Copyright © 2019 S&F. All rights reserved.
///Users/sihengc/Developer/Concentration/Concentration/Concentration.swift

import Foundation

struct Card {
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
    
    static func resetIdentifierFactory() {
        identifierFactory = 0
    }
} 
