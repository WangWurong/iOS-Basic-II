//
//  ViewController.swift
//  TicTacToe
//
//  Created by 大兔子殿下 on 1/7/19.
//  Copyright © 2019 大兔子殿下. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var winnerDisplay: UILabel!
    
    @IBOutlet weak var playAgainButton: UIButton!

    @IBAction func playAgain(_ sender: Any) {
        // reset all the values
        gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0] // 0 - empty, 1 - noughts, 2 - crosses
        activeGame = true
        row_count = [0, 0, 0]
        col_count = [0, 0, 0]
        diagonal = 0
        antidiagonal = 0
        
        // reset all the buttons
        for i in 1..<10 {
            // get the view of button and cast to UIButton
            if let button = view.viewWithTag(i) as? UIButton {
                button.setImage(nil, for: [])
            }
        }
        
        // hide the initial label and play again button
        winnerDisplay.isHidden = true
        playAgainButton.isHidden = true
        
        // set the position animation
        winnerDisplay.center = CGPoint(x: winnerDisplay.center.x, y: winnerDisplay.center.y - 500)
        playAgainButton.center = CGPoint(x: playAgainButton.center.x, y: winnerDisplay.center.y - 500)
    }
    
    // 1 is noughts, 2 is crosses
    var activePlayer = 1
    
    // keep track of the game state
    // use what I learned from leetcode, lol
    var gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0] // 0 - empty, 1 - noughts, 2 - crosses
    var activeGame = true
    var row_count = [0, 0, 0]
    var col_count = [0, 0, 0]
    var diagonal = 0
    var antidiagonal = 0

    @IBAction func buttonPressed(_ sender: AnyObject) {
        // get the row and col index from tag(1-9)
        let activePosition = sender.tag - 1
        let row = activePosition / 3
        let col = activePosition % 3
        
        if gameState[activePosition] == 0 && activeGame {
            // the current place is unset, then set and make the decicsion
            
            // change the state
            gameState[activePosition] = activePlayer
            
            // change the image
            if activePlayer == 1 {
                sender.setImage(UIImage(named: "nought.png"), for: [])
                activePlayer = 2
            } else {
                sender.setImage(UIImage(named: "cross.png"), for: [])
                activePlayer = 1
            }
            
            // check the winner
            let add = activePlayer == 1 ? 1 : -1 // if the player is 1 add 1, otherwise -1
            let size = row_count.count
            
            // update the row_count and col_count
            row_count[row] += add
            col_count[col] += add
            if row == col {
                diagonal += add
            }
            if row == (size - col - 1) {
                antidiagonal += add
            }
            
            // check if someone wins
            for i in 0...2 {
                if abs(row_count[i]) == size || abs(col_count[i]) == size {
                    haveWinner(winner: gameState[activePosition])
                }
            }
            if abs(diagonal) == size || abs(antidiagonal) == size {
                haveWinner(winner: gameState[activePosition])
            }
        }
    }
    
    @objc func haveWinner(winner: Int) {
        // set game active
        activeGame = false
        
        // show the label and button
        winnerDisplay.isHidden = false
        playAgainButton.isHidden = false
        
        if winner == 1 {
            winnerDisplay.text = "Noughts has won!"
        } else {
            winnerDisplay.text = "Crosses has won!"
        }
        
        UIView.animate(withDuration: 1, animations: {
            self.winnerDisplay.center = CGPoint(x: self.winnerDisplay.center.x, y: self.winnerDisplay.center.y + 500)
            self.playAgainButton.center = CGPoint(x: self.playAgainButton.center.x, y: self.playAgainButton.center.y + 500)
        })
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // hide the initial label and play again button
        winnerDisplay.isHidden = true
        playAgainButton.isHidden = true
        
        // set the position animation
        winnerDisplay.center = CGPoint(x: winnerDisplay.center.x, y: winnerDisplay.center.y - 500)
        playAgainButton.center = CGPoint(x: playAgainButton.center.x, y: winnerDisplay.center.y - 500)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

