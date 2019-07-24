//
//  ViewController.swift
//  Concentration
//
//  Created by Rongrong Wang on 2019/7/23.
//  Copyright © 2019 Rongrong Wang. All rights reserved.
//

import UIKit
let emojiSet = ["🌸", "🌺", "🍀", "🌼", "🐰", "💩", "🐶", "😺", "👻", "👩🏼", "🐹", "🍏"]

class ViewController: UIViewController {
	lazy var game = Concentration(numberOfPairs: (CardButtons.count) / 2)
	
	var emojiArr = emojiSet
	var emojiDict = [Int: String]() // Dictionary<Int, String>()
	var flipCount = 0 { 		// type inference
		didSet {		// will be called every time it got set
			flipCountLabel.text = "Flips: \(flipCount)"
		}
	}
	
	@IBOutlet weak var flipCountLabel: UILabel!
	@IBOutlet weak var reloadGameBtn: UIButton!
	
	@IBOutlet var CardButtons: [UIButton]!
	
	@IBOutlet weak var EndLabel: UITextField!
	
	@IBAction func reloadGame(_ sender: UIButton) {
		game = Concentration(numberOfPairs: (CardButtons.count) / 2)
		emojiArr = emojiSet
		emojiDict.removeAll()
		flipCount = 0
		self.viewDidLoad()
		self.viewWillAppear(true)
	}
	
	@IBAction func touchCard(_ sender: UIButton) {
		if let cardIndex: Int = CardButtons.firstIndex(of: sender) { // if its not nil, unwrap it safely
			game.chooseCard(at: cardIndex)
			updateViewFromModel()
		}
		flipCount += 1
	}
	
	override func viewDidLoad() {
		for button in CardButtons {
			button.isHidden = false
		}
		
		for button in CardButtons {
			button.layer.cornerRadius = 5
			button.layer.borderWidth = 1
			button.layer.borderColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
		}
		
		reloadGameBtn.backgroundColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
		reloadGameBtn.layer.cornerRadius = 5
		reloadGameBtn.layer.borderWidth = 1
		reloadGameBtn.layer.borderColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
		
		flipCountLabel.isHidden = false
		EndLabel.isHidden = true
		reloadGameBtn.isHidden = true
		updateViewFromModel()
	}
	
	func updateViewFromModel() {
		for index in CardButtons.indices {
			let button : UIButton = CardButtons[index]
			let card = game.cards[index]
			if(card.isFaceUp) { // Setting the state, not changing it.
				button.setTitle(emojiFor(card: card), for: UIControl.State.normal)
				button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
			} else {
				button.setTitle("", for: UIControl.State.normal)
				button.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
			}
		}
		
		if game.finishedMatching() {
			for button in CardButtons {
				button.isHidden = true
			}
			flipCountLabel.isHidden = true
			EndLabel.isHidden = false
			reloadGameBtn.isHidden = false
		}
	}
	
	func emojiFor(card: Card) -> String {
		if(emojiDict[card.identifier] == nil) && emojiArr.count > 0 {
			let index = Int(arc4random_uniform(UInt32(emojiArr.count))) // upper bound cannot be 0.
			emojiDict[card.identifier] = emojiArr.remove(at: index)
		}
		return (emojiDict[card.identifier]) ?? "?"		// return value, if nil, return ?
	}

}

