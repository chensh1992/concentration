//
//  ViewController.swift
//  Concentration
//
//  Created by Siheng Chen on 1/8/19.
//  Copyright © 2019 S&F. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    var numberOfPairsOfCards: Int {
        return (cardButtons.count + 1) / 2
    }
    private(set) var flipCount = 0 {
        didSet {
            flipCountLabel.text = "\(flipCount)"
        }
    }
    private(set) var gameOver = false {
        didSet {
            newGameButton.isEnabled = gameOver
        }
    }
    private lazy var emojiChoices = game.emojiChoices
    private var emoji = [Int: String]()
    
    @IBOutlet private var cardButtons: [UIButton]!
    @IBOutlet private weak var flipCountLabel: UILabel!
    @IBOutlet private weak var newGameButton: UIButton!
    
    @IBAction private func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("Card not in")
        }
    }
    @IBAction private func pressNewGameButton(_ sender: UIButton) {
        flipCount = 0
        game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
        emojiChoices = game.emojiChoices
        emoji.removeAll()
        updateViewFromModel()
        gameOver = false
    }
    
    private func updateViewFromModel() {
        for index in cardButtons.indices {  
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
        print (emoji)
        gameOver = game.checkOver()
    }
    
    private func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            emoji[card.identifier] = emojiChoices.remove(at: emojiChoices.count.arc4random)
        }
        return emoji[card.identifier] ?? "?"
    }
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}
