//
//  Concentration.swift
//  Concentration
//
//  Created by Rongrong Wang on 2019/7/23.
//  Copyright © 2019 Rongrong Wang. All rights reserved.
//

import Foundation

// model class
class Concentration {
	var cards = [Card]()
	
	var indexOfOneAndOnlyFaceUpCard : Int?
	
	init(numberOfPairs: Int) {
		// .. < not including
		// ... including
		for _ in 0 ..< numberOfPairs {
			let card = Card()
			cards += [card, card]	// struct pass by value. so not the same card
		}
		// TODO: shuffle cards
	}
	
	func chooseCard(at index: Int){
		if(!cards[index].isMatched) {
			if let matchedIndex = indexOfOneAndOnlyFaceUpCard, matchedIndex != index {
				if cards[matchedIndex].identifier == cards[index].identifier {
					cards[index].isMatched = true
					cards[matchedIndex].isMatched = true
				}
				indexOfOneAndOnlyFaceUpCard = nil
			} else {
				for index in cards.indices {
					if(!cards[index].isMatched) {
						cards[index].isFaceUp = false
					}
				}
				indexOfOneAndOnlyFaceUpCard = index
			}
			cards[index].isFaceUp = true
		}
	}
	
	func finishedMatching() -> Bool {
		for card in cards {
			if !card.isMatched {
				return false
			}
		}
		return true
	}
	
}
