//
//  ViewController.swift
//  BullsAndCows
//
//  Created by Brian Hu on 5/19/16.
//  Copyright © 2016 Brian. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var guessTextField: UITextField!
    @IBOutlet weak var guessButton: UIButton!
    @IBOutlet weak var remainingTimeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var answearLabel: UILabel!
    var remainingTime: UInt8! {
        didSet {
            remainingTimeLabel.text = "remaining time: \(remainingTime)"
            if remainingTime == 0 {
                guessButton.enabled = false
            } else {
                guessButton.enabled = true
            }
        }
    }
    
    var hintArray = [(guess: String, hint: String)]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    // TODO: 1. decide the data type you want to use to store the answear
    
    var answerString: String = ""
    var guessArray: Array<String> = []
    var game = GameLogic()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setGame()
    }

    func setGame() {
        answerString = game.generateAnswear()
        remainingTime = 9
        hintArray.removeAll()
        answearLabel.text = nil
        guessTextField.text = nil
        guessArray = []
        remainingTimeLabel.textColor = UIColor.blackColor()
    }
    
    
    @IBAction func guess(sender: AnyObject) {
        
        let guessString = guessTextField.text
        guard guessString?.characters.count == 4 else {
            let alert = UIAlertController(title: "you should input 4 digits to guess!", message: nil, preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            return
        }
        
        // TODO: 7 check guessString is repeating?
        
        if guessArray.contains(guessString!){
            let alert = UIAlertController(title: "you should try different numbers!", message: nil, preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            guessTextField.text = ""
            return
        }else{
            guessArray.append(guessString!)
        }
        
        // TODO: 3. convert guessString to the data type you want to use and judge the guess
        
        let hintTuple = game.checkAnswer(guessString!)
        
        // TODO: 4. update the hint
        let hintString = "\(hintTuple.a)A\(hintTuple.b)B"
        hintArray.append((guessString!, hintString))
        
        // TODO: 5. update the constant "correct" if the guess is correct
        let correct = hintTuple.a == 4
        
        if correct {
            let alert = UIAlertController(title: "Wow! You are awesome!", message: nil, preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            guessButton.enabled = false
        } else {
            remainingTime! -= 1
            //TODO 8. change color
            if remainingTime <= 3 {
                remainingTimeLabel.textColor = UIColor.redColor()
            }else if remainingTime <= 6 {
                remainingTimeLabel.textColor = UIColor.yellowColor()
            }
        }
        
        //TODO 9. empty guessTextField
        guessTextField.text = ""
    }
    @IBAction func showAnswear(sender: AnyObject) {
        // TODO: 6. convert your answear to string(if it's necessary) and display it
        answearLabel.text = "\(answerString)"
    }
    
    @IBAction func playAgain(sender: AnyObject) {
        setGame()
    }
    
    
    // MARK: TableView
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hintArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Hint Cell", forIndexPath: indexPath)
        let (guess, hint) = hintArray[indexPath.row]
        cell.textLabel?.text = "\(guess) => \(hint)"
        return cell
    }
}

