//
//  Card.swift
//  Concentration
//
//  Created by Rongrong Wang on 2019/7/23.
//  Copyright © 2019 Rongrong Wang. All rights reserved.
//

import Foundation
// model not UI
struct Card { // same as class
	// but stuct no inhereince
	// pass by value, not reference (class)
	// array, int, diction all structs
	// only make copies when got modified
	var isFaceUp = false
	var isMatched = false
	var identifier: Int
	
	static var indentifierFactory = 0
	
	static func getUniqueIdentifier() -> Int {
		indentifierFactory += 1		// inside a static func, accessing a static var, no need to add class type .
		return indentifierFactory
	}
	
	init() {
		self.identifier = Card.getUniqueIdentifier()
	}
}
