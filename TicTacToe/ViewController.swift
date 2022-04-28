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
    
    var sizeInInt = 3
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func player1Name(_ sender: UITextField) {
        player1Label.text = sender.text
    }
    
    @IBAction func player2Name(_ sender: Any) {
        player2Label.text = player2TF.text
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

