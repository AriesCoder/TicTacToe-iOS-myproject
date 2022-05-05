//
//  ViewController.swift
//  TicTacToe
//
//  Created by Aries Lam on 4/27/22.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var player1TF: UITextField!
    @IBOutlet weak var player2TF: UITextField!
    @IBOutlet weak var sizeTF: UITextField!
    @IBOutlet weak var player1Label: UILabel!
    @IBOutlet weak var player2Label: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var player1VS: UILabel!
    @IBOutlet weak var player2VS: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    var sizeInInt = 3
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleSetting()
        uiSetting()

    }
    
    func uiSetting(){
        player1TF.layer.borderColor = UIColor.white.cgColor
        player1TF.layer.borderWidth = 3.0
        player1TF.layer.cornerRadius = 10
        player1TF.attributedPlaceholder = NSAttributedString(
            string: "Player 1",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray]
        )
        
        player2TF.layer.borderColor = UIColor.white.cgColor
        player2TF.layer.borderWidth = 3.0
        player2TF.layer.cornerRadius = 10
        player2TF.attributedPlaceholder = NSAttributedString(
            string: "Player 2",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray])
        
        sizeTF.layer.borderColor = UIColor.white.cgColor
        sizeTF.layer.borderWidth = 3.0
        sizeTF.layer.cornerRadius = 10
        sizeTF.attributedPlaceholder = NSAttributedString(
            string: "Size",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray])
        
        startBtn.layer.borderColor = UIColor.white.cgColor
        startBtn.layer.borderWidth = 3.0
        startBtn.layer.cornerRadius = 10
    }
    
    func titleSetting(){
        
        //set amination
        let titleText = "Tic Tac Toe"
        titleLabel.text = ""
       var charIndex = 0
       for char in titleText{
           Timer.scheduledTimer(withTimeInterval: 0.2 * Double(charIndex), repeats: false) { _ in
               self.titleLabel.text?.append(char)
           }
           charIndex += 1
       }
    }
    

    @IBAction func player1Name(_ sender: UITextField) {
        player1Label.text = sender.text
        player1VS.text = sender.text
    }
    
    @IBAction func player2Name(_ sender: Any) {
        player2Label.text = player2TF.text
        player2VS.text = player2TF.text
    }
    
    
    @IBAction func gameSize(_ sender: Any) {
        guard let size = sizeTF.text else {return}
        sizeInInt = Int(size) ?? 3
        if 2 < sizeInInt && sizeInInt < 6 {
            sizeLabel.text = "\(sizeInInt) x \(sizeInInt)"
        }else{
            sizeLabel.text = "3 x 3"
            sizeInInt = 3
        }
        
    }
    
    @IBAction func startBtn(_ sender: Any) {
        player1TF.text = ""
        player2TF.text = ""
        sizeTF.text = ""

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segToGame"{
            if let gameboard = segue.destination as? GameBoardViewController{
                gameboard.player1 = player1Label.text ?? "player 1"
                gameboard.player2 = player2Label.text ?? "player 2"
                gameboard.size = Double(sizeInInt)
                
            }
        }
    }
    
    
}

