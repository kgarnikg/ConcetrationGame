//
//  ViewController.swift
//  ConcetrationGame
//
//  Created by Гар on 18.11.22.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var game = ConcetrationGame(numberOfPairsCards: (buttonCollection.count + 1) / 2)

    var touches = 0 {
        didSet {
            touchLabel.text = "Touches: \(touches)"
        }
    }
    
    

    var collectionEmoji = ["🐶", "🐰", "🦁", "🐻", "🦋", "🐢", "🐞", "🦀", "🐜"]
    
    var emojiDictionary = [Int:String]()
    
    func emojiIdentifier(for card : Card) -> String {
        if emojiDictionary[card.identifier] == nil {
            let randomIndex = Int(arc4random_uniform(UInt32(collectionEmoji.count)))
            emojiDictionary[card.identifier] = collectionEmoji .remove(at: randomIndex)
        }
        return emojiDictionary[card.identifier] ?? "?"
    }
    func updateViewFromModel() {
        for index in buttonCollection.indices {
            let button = buttonCollection[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emojiIdentifier(for : card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 0) : #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
            }
        }
    }
    
    @IBOutlet var buttonCollection: [UIButton]!
    @IBOutlet weak var touchLabel: UILabel!
    @IBAction func buttonAction(_ sender: UIButton) {
        touches += 1
        if let buttonindex = buttonCollection.firstIndex(of: sender) {
            game.chooseCard(at: buttonindex)
            updateViewFromModel()
             
        }
       
    }
}


